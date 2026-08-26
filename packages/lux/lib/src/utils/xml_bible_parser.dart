import 'package:collection/collection.dart';
import 'package:lux/lux_core.dart';
import 'package:xml/xml.dart';

abstract final class XmlBibleParser {
  static Chapter parse(
    Iterable<XmlElement> elements, {
    required int? Function(XmlElement) getVerseNumber,
    required bool Function(XmlElement) shouldIgnore,
    required Markdown? Function(XmlElement) buildFootnote,
    required bool Function(XmlElement) isRedLetters,
    required bool Function(XmlElement) isItalic,
    required bool Function(XmlElement) isUppercase,
    InterlinearData? Function(XmlElement)? getInterlinearData,
    required String? Function(XmlElement) getParagraphStyle,
    required String Function(XmlElement) buildSectionText,
    required String Function(String) buildText,
  }) {
    int? lastVerseNum;

    XmlElement sectionWithoutNotes(XmlElement element) => XmlElement(
      element.name,
      element.attributes.map((attribute) => attribute.copy()),
      element.children.expand(
        (child) => switch (child) {
          XmlElement child when shouldIgnore(child) || buildFootnote(child) != null => [],
          XmlElement child => [sectionWithoutNotes(child)],
          _ => [child.copy()],
        },
      ),
      element.isSelfClosing,
    );

    List<Verse> parseVerses(
      XmlNode node, {
      bool redLetters = false,
      bool italic = false,
      bool uppercase = false,
      InterlinearData? interlinearData,
    }) => node.children.isEmpty && interlinearData != null && lastVerseNum != null
        ? [
            Verse(
              verseNum: lastVerseNum!,
              words: [Word(data: interlinearData, redLetters: redLetters, italic: italic)],
            ),
          ]
        : node.children
              .expand<Verse>(
                (child) => switch (child) {
                  XmlText(:final value) when lastVerseNum != null => [
                    Verse(
                      verseNum: lastVerseNum!,
                      words: [
                        Word(
                          text: buildText(uppercase ? value.toUpperCase() : value),
                          data: interlinearData,
                          redLetters: redLetters,
                          italic: italic,
                        ),
                      ],
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
                      uppercase: uppercase || isUppercase(child),
                      interlinearData: getInterlinearData?.call(child) ?? interlinearData,
                    );
                  }(),
                  _ => [],
                },
              )
              .withSameVersesCombined()
              .toList();

    Iterable<XmlElement> splitInlineParagraph(XmlElement element) {
      final inlineParagraphIndex = element.children.indexWhereOrNull(
        (child) => child is XmlElement && getParagraphStyle(child) == 'qs',
      );
      if (inlineParagraphIndex == null) return [element];

      return [
        XmlElement(
          element.name,
          element.attributes.map((attribute) => attribute.copy()),
          element.children.take(inlineParagraphIndex).map((child) => child.copy()),
          element.isSelfClosing,
        ),
        XmlElement.tag(
          'p',
          attributes: [XmlAttribute(XmlName.parts('class'), 'qs')],
          children: element.children.skip(inlineParagraphIndex).map((child) => child.copy()),
          isSelfClosing: false,
        ),
      ];
    }

    final paragraphs = elements.expand(splitInlineParagraph).fold(<Paragraph>[], (paragraphs, element) {
      SectionParagraph sectionParagraph(SectionType sectionType) {
        parseVerses(element);
        return SectionParagraph(text: buildSectionText(sectionWithoutNotes(element)), type: sectionType);
      }

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
        final verses = element.descendants
            .whereType<XmlElement>()
            .where((element) => {'tr', 'row'}.has(element.localName))
            .expandIndexed<Verse>((rowIndex, row) {
              final cells = row.childElements.where((cell) => {'td', 'cell'}.has(cell.localName)).toList();
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
              'ms' || 'ms1' || 'ms2' || 'ms3' => sectionParagraph(.ms),
              's' || 's1' || 'cl' => sectionParagraph(.s1),
              's2' => sectionParagraph(.s2),
              'd' || 'qd' => sectionParagraph(.d),
              'p' || 'pmo' || 'pmc' => versesParagraph(.p),
              'pm' => versesParagraph(.pm),
              'pc' => versesParagraph(.pc),
              'nb' => versesParagraph(.nb),
              'pr' || 'pmr' || 'cls' => versesParagraph(.pr),
              'pi' || 'pi1' => versesParagraph(.pi),
              'm' || 'mi' => versesParagraph(.m),
              'q' || 'q1' || 'qm' || 'qm1' => versesParagraph(.q1),
              'q2' || 'qm2' => versesParagraph(.q2),
              'qr' => versesParagraph(.qr),
              'qs' => versesParagraph(.qs),
              'qc' => versesParagraph(.qc),
              'qa' => sectionParagraph(.qa),
              'sp' => sectionParagraph(.sp),
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
