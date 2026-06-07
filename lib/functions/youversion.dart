import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/bible/word.dart';
import 'package:bible/models/reference/chapter_reference.dart';
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
      queryParameters: {'format': 'html', 'include_headings': true},
    );
    return parseChapter(response.data['content']);
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
            // The visible verse-number label duplicates the marker; skip its text.
            dom.Element child when child.classes.contains('yv-vlbl') => <Verse>[],
            dom.Element child when child.classes.contains('wj') => parseVerses(
              child,
              isRedLetters: true,
              isItalic: isItalic,
            ),
            // Translator-supplied words (e.g. NASB) are wrapped in `<span class="it">`.
            dom.Element child when child.classes.contains('it') => parseVerses(
              child,
              isRedLetters: isRedLetters,
              isItalic: true,
            ),
            dom.Element child => parseVerses(child, isRedLetters: isRedLetters, isItalic: isItalic),
            _ => <Verse>[],
          },
        )
        .withSameVersesCombined()
        .toList();

    final paragraphs = root.children.fold(<Paragraph>[], (paragraphs, div) {
      // Class is e.g. "s1 yv-h" or "p"; the USX-style token is the non-`yv-` one.
      final style = div.classes.firstWhereOrNull((className) => !className.startsWith('yv-'));

      VersesParagraph? versesParagraph(ParagraphType paragraphType) {
        final previousLastVerseNum = lastVerseNum;
        final verses = parseVerses(div).trim();
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

      final paragraph = switch (style) {
        's' || 's1' => SectionParagraph(type: .s1, text: div.text.trim()),
        's2' => SectionParagraph(type: .s2, text: div.text.trim()),
        'p' || 'pmo' || 'pc' => versesParagraph(.p),
        'd' => versesParagraph(.d),
        'q' || 'q1' => versesParagraph(.q1),
        'q2' => versesParagraph(.q2),
        'qr' => versesParagraph(.qr),
        'li' || 'li1' => versesParagraph(.li1),
        'li2' => versesParagraph(.li2),
        'b' => BreakParagraph(),
        _ => null,
      };

      return paragraph == null ? paragraphs : (paragraphs..add(paragraph));
    });

    return Chapter(paragraphs: paragraphs.nonNulls.toList());
  }
}
