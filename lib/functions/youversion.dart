import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/footnote.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/bible/word.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/utils/footnote_markdown.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;

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
    final fragment = html_parser.parseFragment(content);

    final root = fragment.children.length == 1 && fragment.children.single.localName == 'div'
        ? fragment.children.single
        : fragment;

    int? lastVerseNum;

    List<Verse> parseVerses(dom.Node node, {bool isRedLetters = false, bool isItalic = false}) => node.nodes
        .expand<Verse>(
          (child) => switch (child) {
            dom.Text() when lastVerseNum != null => [
              Verse(
                verseNum: lastVerseNum!,
                words: [Word(text: child.text, redLetters: isRedLetters, italic: isItalic)],
              ),
            ],
            dom.Element child when child.classes.contains('yv-v') => () {
              lastVerseNum = int.parse(child.attributes['v']!);
              return <Verse>[];
            }(),
            dom.Element child when child.classes.contains('yv-vlbl') => [],
            dom.Element child when child.classes.contains('wj') => parseVerses(
              child,
              isRedLetters: true,
              isItalic: isItalic,
            ),
            dom.Element child when child.classes.contains('it') => parseVerses(
              child,
              isRedLetters: isRedLetters,
              isItalic: true,
            ),
            dom.Element child when child.classes.contains('yv-n') => [
              Verse(
                verseNum: lastVerseNum ?? 0,
                words: [],
                footnotes: [Footnote(offset: 0, text: _footnoteMarkdown(child))],
              ),
            ],
            dom.Element child => parseVerses(child, isRedLetters: isRedLetters, isItalic: isItalic),
            _ => [],
          },
        )
        .withSameVersesCombined()
        .toList();

    final paragraphs = root.children.fold(<Paragraph>[], (paragraphs, div) {
      // Class is e.g. "s1 yv-h" or "p"; the USX-style token is the non-`yv-` one.
      final style = div.classes.firstWhereOrNull((className) => !className.startsWith('yv-'));

      SectionParagraph sectionParagraph(SectionType sectionType) => SectionParagraph(
        text: div.nodes
            .where((node) => node.attributes['class']?.startsWith('yv-') != true)
            .map((node) => node.text)
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
            .querySelectorAll('tr')
            .expandIndexed<Verse>((rowIndex, row) {
              final cells = row.children.where((cell) => cell.localName == 'td').toList();
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

String _footnoteMarkdown(dom.Element note) {
  final runs = <FootnoteMarkdownRun>[];
  void walk(dom.Node node, bool italic, String? link) {
    for (final child in node.nodes) {
      if (child is dom.Text) {
        runs.add((text: child.data, italic: italic, link: link));
      } else if (child is dom.Element && !child.classes.contains('fr')) {
        walk(
          child,
          italic || child.classes.any((clazz) => FootnoteMarkdown.italicStyles.contains(clazz)),
          child.classes.contains('ref') ? FootnoteMarkdown.osisIdFromUsxReference(child.attributes['usfm']) : link,
        );
      }
    }
  }

  walk(note, false, null);
  return FootnoteMarkdown.runsToMarkdown(runs);
}
