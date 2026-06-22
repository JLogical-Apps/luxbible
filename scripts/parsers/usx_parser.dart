import 'package:bible/models/bible/book.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/interlinear_data.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/bible/word.dart';
import 'package:collection/collection.dart';
import 'package:utils_core/utils_core.dart';
import 'package:xml/xml.dart';

Book parseUsxBook(BookType type, String rawXml) {
  final doc = XmlDocument.parse(rawXml);
  return Book(
    bookType: type,
    chapters: doc.findAllElements('chapter').mapIndexed((chapterIndex, div) {
      int? lastVerseNum;
      return Chapter(
        paragraphs: div.nextElementSiblings
            .takeWhile((div) => div.localName != 'chapter')
            .fold(<Paragraph?>[], (paragraphs, div) {
              List<Verse> parseUsxVerses(
                XmlElement element, {
                InterlinearData? data,
                bool isRedLetters = false,
                bool onlyIfValidVerse = true,
              }) {
                bool canParseVerse() => !onlyIfValidVerse || lastVerseNum != null;
                return element.children.isEmpty && data != null && canParseVerse()
                    ? [
                        Verse(
                          verseNum: lastVerseNum ?? 0,
                          words: [Word(data: data, redLetters: isRedLetters)],
                        ),
                      ]
                    : element.children
                          .expand<Verse>(
                            (node) => switch (node) {
                              XmlText(:final value) when canParseVerse() => [
                                Verse(
                                  verseNum: lastVerseNum ?? 0,
                                  words: [Word(text: value, data: data, redLetters: isRedLetters)],
                                ),
                              ],
                              XmlElement node when node.localName == 'verse' => () {
                                lastVerseNum = int.parse(node.getAttribute('number')!);
                                return <Verse>[];
                              }(),
                              XmlElement node when node.localName == 'char' && canParseVerse() => parseUsxVerses(
                                node,
                                data: node.getAttribute('style') == 'w'
                                    ? InterlinearData(
                                        originalPosition: int.parse(node.getAttribute('x-position')!),
                                        inflection: node.getAttribute('x-lemma'),
                                        morphology: node.getAttribute('x-morph'),
                                        strongId: node.getAttribute('strong')?.nullIfBlank,
                                        transliteration: node.getAttribute('x-translit'),
                                      )
                                    : null,
                                isRedLetters: node.getAttribute('style') == 'wj' || isRedLetters,
                              ),
                              _ => [],
                            },
                          )
                          .withSameVersesCombined()
                          .toList();
              }

              SectionParagraph sectionParagraph(SectionType sectionType) =>
                  SectionParagraph(text: div.innerText, type: sectionType);

              VersesParagraph? versesParagraph(ParagraphType paragraphType, {bool onlyIfValidVerse = true}) {
                final previousLastVerseNum = lastVerseNum;
                final verses = parseUsxVerses(div, onlyIfValidVerse: onlyIfValidVerse).trim();
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

              return paragraphs..add(switch (div.getAttribute('style')) {
                's1' => sectionParagraph(.s1),
                's2' => sectionParagraph(.s2),
                'ms' => sectionParagraph(.ms),
                'd' => versesParagraph(.p, onlyIfValidVerse: false)?.toSectionParagraph(.d),
                'p' || 'pmo' || 'pc' => versesParagraph(.p),
                'q1' => versesParagraph(.q1),
                'q2' => versesParagraph(.q2),
                'qr' => versesParagraph(.qr),
                'li1' => versesParagraph(.li1),
                'li2' => versesParagraph(.li2),
                'b' => BreakParagraph(),
                _ => null,
              });
            })
            .nonNulls
            .toList(),
      );
    }).toList(),
  );
}

extension on XmlElement {
  Iterable<XmlElement> get nextElementSiblings sync* {
    var lastChild = nextElementSibling;
    while (lastChild != null) {
      yield lastChild;
      lastChild = lastChild.nextElementSibling;
    }
  }
}

extension on VersesParagraph {
  SectionParagraph toSectionParagraph(SectionType type) =>
      SectionParagraph(text: verses.map((verse) => verse.text).join(' '), type: type);
}
