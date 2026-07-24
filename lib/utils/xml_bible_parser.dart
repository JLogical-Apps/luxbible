import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/footnote.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/bible/word.dart';
import 'package:bible/utils/markdown.dart';
import 'package:collection/collection.dart';
import 'package:xml/xml.dart';

abstract final class XmlBibleParser {
  static Chapter parse(
    XmlElement root, {
    required int? Function(XmlElement) getVerseNumber,
    required bool Function(XmlElement) shouldIgnore,
    required Markdown? Function(XmlElement) buildFootnote,
    required bool Function(XmlElement) isRedLetters,
    required bool Function(XmlElement) isItalic,
    required String? Function(XmlElement) getParagraphStyle,
    required String Function(XmlElement) buildSectionText,
    required String Function(String) buildText,
  }) {
    int? lastVerseNum;

    List<Verse> parseVerses(XmlNode node, {bool redLetters = false, bool italic = false}) => node.children
        .expand<Verse>(
          (child) => switch (child) {
            XmlText(:final value) when lastVerseNum != null => [
              Verse(
                verseNum: lastVerseNum!,
                words: [Word(text: buildText(value), redLetters: redLetters, italic: italic)],
              ),
            ],
            XmlElement child => () {
              if (shouldIgnore(child)) return <Verse>[];
              if (getVerseNumber(child) case final verseNum?) {
                lastVerseNum = verseNum;
                return <Verse>[];
              }
              if (buildFootnote(child) case final footnote?) {
                return [
                  Verse(
                    verseNum: lastVerseNum ?? 0,
                    words: [],
                    footnotes: [Footnote(offset: 0, text: footnote)],
                  ),
                ];
              }
              return parseVerses(
                child,
                redLetters: redLetters || isRedLetters(child),
                italic: italic || isItalic(child),
              );
            }(),
            _ => [],
          },
        )
        .withSameVersesCombined()
        .toList();

    final paragraphs = root.childElements.fold(<Paragraph>[], (paragraphs, element) {
      SectionParagraph sectionParagraph(SectionType sectionType) =>
          SectionParagraph(text: buildSectionText(element), type: sectionType);

      VersesParagraph? buildVersesParagraph(
        ParagraphType paragraphType,
        int? previousLastVerseNum,
        List<Verse> verses,
      ) {
        if (verses.isEmpty) return null;

        final otherParagraphsWithVerse = paragraphs
            .whereType<VersesParagraph>()
            .expand((paragraph) => paragraph.verses)
            .where((verse) => verse.verseNum == verses.first.verseNum);

        return VersesParagraph(
          type: paragraphType,
          verses: verses,
          firstVerseOffset: verses.first.verseNum == previousLastVerseNum
              ? otherParagraphsWithVerse.map((verse) => verse.text.length).sum + otherParagraphsWithVerse.length
              : 0,
        );
      }

      VersesParagraph? versesParagraph(ParagraphType paragraphType) =>
          buildVersesParagraph(paragraphType, lastVerseNum, parseVerses(element).trim());

      VersesParagraph? tableParagraph() {
        final previousLastVerseNum = lastVerseNum;
        final verses = element
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

      final paragraph = element.localName == 'table'
          ? tableParagraph()
          : switch (getParagraphStyle(element)) {
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

    return Chapter(paragraphs: paragraphs);
  }
}

extension XmlBibleElementExtensions on XmlElement {
  Set<String> get classNames =>
      (getAttribute('class') ?? '').split(RegExp(r'\s+')).where((name) => name.isNotEmpty).toSet();
}
