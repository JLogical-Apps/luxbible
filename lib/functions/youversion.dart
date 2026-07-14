import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/footnote.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/bible/word.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/utils/usx_utils.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class YouVersion {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.youversion.com',
      headers: {'x-yvp-app-key': 'UIFrcghkECmF1yy9KNy7akj073UqDcodMPk2eJa0BDpr6TDt'},
    ),
  )..interceptors.add(LogInterceptor(responseBody: false));

  static Future<Chapter> fetchChapter({required int bibleId, required ChapterReference chapterReference}) async {
    final response = await dio.get(
      '/v1/bibles/$bibleId/passages/${chapterReference.usxId()}',
      queryParameters: {'format': 'html', 'include_headings': true, 'include_notes': true},
    );

    return parseChapter(response.data['content'] as String);
  }

  static Chapter parseChapter(String content) {
    final root = XmlDocument.parse(content).rootElement;

    int? lastVerseNum;

    List<Verse> parseVerses(XmlNode node, {bool isRedLetters = false, bool isItalic = false}) => node.children
        .expand<Verse>(
          (child) => switch (child) {
            XmlText(:final value) when lastVerseNum != null => [
              Verse(
                verseNum: lastVerseNum!,
                words: [Word(text: value, redLetters: isRedLetters, italic: isItalic)],
              ),
            ],
            XmlElement child when child.classNames.contains('yv-v') => () {
              lastVerseNum = int.parse(child.getAttribute('v')!);
              return <Verse>[];
            }(),
            XmlElement child when child.classNames.contains('yv-vlbl') => [],
            XmlElement child when child.classNames.contains('wj') => parseVerses(
              child,
              isRedLetters: true,
              isItalic: isItalic,
            ),
            XmlElement child when child.classNames.contains('it') => parseVerses(
              child,
              isRedLetters: isRedLetters,
              isItalic: true,
            ),
            XmlElement child when child.classNames.contains('yv-n') => [
              Verse(
                verseNum: lastVerseNum ?? 0,
                words: [],
                footnotes: [Footnote(offset: 0, text: UsxUtils.noteToMarkdown(child))],
              ),
            ],
            XmlElement child => parseVerses(child, isRedLetters: isRedLetters, isItalic: isItalic),
            _ => [],
          },
        )
        .withSameVersesCombined()
        .toList();

    final paragraphs = root.childElements.fold(<Paragraph>[], (paragraphs, div) {
      // Class is e.g. "s1 yv-h" or "p"; the USX-style token is the non-`yv-` one.
      final style = div.classNames.firstWhereOrNull((className) => !className.startsWith('yv-'));

      SectionParagraph sectionParagraph(SectionType sectionType) => SectionParagraph(
        text: div.children
            .where(
              (node) => switch (node) {
                XmlElement() => node.getAttribute('class')?.startsWith('yv-') != true,
                _ => true,
              },
            )
            .map(
              (node) => switch (node) {
                XmlText(:final value) => value,
                XmlElement() => node.innerText,
                _ => '',
              },
            )
            .join(),
        type: sectionType,
      );

      VersesParagraph? buildVersesParagraph(
        ParagraphType paragraphType,
        int? previousLastVerseNum,
        List<Verse> verses,
      ) {
        if (verses.isEmpty) {
          return null;
        }

        final otherParagraphsWithVerse = paragraphs
            .whereType<VersesParagraph>()
            .expand((para) => para.verses)
            .where((verse) => verse.verseNum == verses.first.verseNum);

        return VersesParagraph(
          type: paragraphType,
          verses: verses,
          firstVerseOffset: verses.first.verseNum == previousLastVerseNum
              ? otherParagraphsWithVerse.map((verse) => verse.text.length).sum +
                    // Account for spaces between paragraphs
                    otherParagraphsWithVerse.length
              : 0,
        );
      }

      VersesParagraph? versesParagraph(ParagraphType paragraphType) =>
          buildVersesParagraph(paragraphType, lastVerseNum, parseVerses(div).trim());

      VersesParagraph? tableParagraph() {
        final previousLastVerseNum = lastVerseNum;
        final verses = div
            .findAllElements('tr')
            .expandIndexed<Verse>((rowIndex, row) {
              final cells = row.childElements.where((cell) => cell.localName == 'td').toList();
              return [
                if (rowIndex != 0)
                  Verse(
                    verseNum: lastVerseNum ?? 0,
                    words: [Word(text: '\n')],
                  ),
                ...cells.expandIndexed(
                  (cellIndex, cell) => [
                    if (cellIndex != 0)
                      Verse(
                        verseNum: lastVerseNum ?? 0,
                        words: [Word(text: '   ')],
                      ),
                    ...parseVerses(cell),
                  ],
                ),
              ];
            })
            .withSameVersesCombined()
            .toList()
            .trim();
        return buildVersesParagraph(.m, previousLastVerseNum, verses);
      }

      final paragraph = div.localName == 'table'
          ? tableParagraph()
          : switch (style) {
              'ms' => sectionParagraph(.ms),
              's' || 's1' || 'cl' => sectionParagraph(.s1),
              's2' => sectionParagraph(.s2),
              'd' || 'qd' => sectionParagraph(.d),
              'p' || 'pm' || 'pmo' || 'pmc' => versesParagraph(.p),
              'pc' => versesParagraph(.pc),
              'nb' => versesParagraph(.nb),
              'pr' || 'pmr' || 'cls' => versesParagraph(.pr),
              'pi' || 'pi1' => versesParagraph(.pi),
              'm' || 'mi' => versesParagraph(.m),
              'q' || 'q1' => versesParagraph(.q1),
              'q2' => versesParagraph(.q2),
              'qr' => versesParagraph(.qr),
              'qc' => versesParagraph(.qc),
              'qa' => sectionParagraph(.qa),
              'li' || 'li1' => versesParagraph(.li1),
              'li2' || 'lim' => versesParagraph(.li2),
              'b' => BreakParagraph(),
              _ => null,
            };

      return paragraph == null ? paragraphs : (paragraphs..add(paragraph));
    });

    return Chapter(paragraphs: paragraphs.nonNulls.toList());
  }
}

extension on XmlElement {
  Set<String> get classNames =>
      (getAttribute('class') ?? '').split(RegExp(r'\s+')).where((name) => name.isNotEmpty).toSet();
}
