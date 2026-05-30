import 'dart:convert';

import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/interlinear_data.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/bible/word.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:utils_core/utils_core.dart';
import 'package:xml/xml.dart';

class BibleImporter {
  Future<Bible> importBible({required BibleTranslation translation}) async => switch (translation) {
    .kjv || .asv => await parseJsonBible(translation: translation),
    .bsb => await parseUsxBible(translation: translation),
  };

  Future<Bible> parseJsonBible({required BibleTranslation translation}) async {
    final json =
        jsonDecode(await rootBundle.loadString('assets/translations/${translation.name}.json')) as Map<String, dynamic>;
    return Bible(
      translation: translation,
      books: json
          .mapToIterable(
            (bookCode, book) => Book(
              bookType: BookType.fromJsonKey(bookCode),
              chapters: (book as Map<String, dynamic>)
                  .mapToIterable(
                    (chapterNum, chapter) => Chapter(
                      paragraphs: (chapter as Map<String, dynamic>)
                          .mapToIterable(
                            (verseNum, verse) => VersesParagraph(
                              type: .p,
                              verses: [
                                Verse(
                                  verseNum: int.parse(verseNum),
                                  words: [Word(text: verse)],
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }

  Future<Bible> parseUsxBible({required BibleTranslation translation}) async => Bible(
    translation: translation,
    books: await BookType.values.map((type) async {
      final rawXml = await rootBundle.loadString('assets/translations/${translation.name}/${type.usxCode()}.usx');
      final doc = XmlDocument.parse(rawXml);

      return Book(
        bookType: type,
        chapters: doc.findAllElements('chapter').mapIndexed((chapterIndex, div) {
          int? lastVerseNum;
          return Chapter(
            paragraphs: div.nextElementSiblings
                .takeWhile((div) => div.localName != 'chapter')
                .fold(<Paragraph?>[], (paragraphs, div) {
                  List<Verse> parseUsxVerses(XmlElement element, {InterlinearData? data}) =>
                      element.children.isEmpty && data != null && lastVerseNum != null
                      ? [
                          Verse(
                            verseNum: lastVerseNum!,
                            words: [Word(data: data)],
                          ),
                        ]
                      : element.children
                            .expand<Verse>(
                              (node) => switch (node) {
                                XmlText(:final value) when lastVerseNum != null => [
                                  Verse(
                                    verseNum: lastVerseNum!,
                                    words: [Word(text: value, data: data)],
                                  ),
                                ],
                                XmlElement node when node.localName == 'verse' => () {
                                  lastVerseNum = int.parse(node.getAttribute('number')!);
                                  return <Verse>[];
                                }(),
                                XmlElement node when node.localName == 'char' && lastVerseNum != null => parseUsxVerses(
                                  node,
                                  data: node.getAttribute('style') == 'w'
                                      ? InterlinearData(
                                          originalPosition: int.parse(node.getAttribute('x-position')!),
                                          inflection: node.getAttribute('x-lemma'),
                                          morphology: node.getAttribute('x-morph'),
                                          strongId: node.getAttribute('strong'),
                                        )
                                      : null,
                                ),
                                _ => [],
                              },
                            )
                            .withSameVersesCombined()
                            .trim()
                            .toList();

                  VersesParagraph? versesParagraph(ParagraphType paragraphType) {
                    final previousLastVerseNum = lastVerseNum;
                    final verses = parseUsxVerses(div);
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
                    's1' => SectionParagraph(type: .s1, text: div.innerText),
                    's2' => SectionParagraph(type: .s2, text: div.innerText),
                    'p' || 'pmo' || 'pc' => versesParagraph(.p),
                    'd' => versesParagraph(.d),
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
    }).wait,
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

extension on Iterable<Verse> {
  Iterable<Verse> trim() {
    if (isEmpty) {
      return this;
    }

    final list = toList();
    list[0] = list[0].trimStart();
    return list;
  }

  Iterable<Verse> withSameVersesCombined() => isEmpty
      ? this
      : fold<List<Verse>>([], (verses, verse) {
          final lastVerse = verses.lastOrNull;
          if (lastVerse == null) {
            return verses..add(verse);
          }

          return lastVerse.verseNum == verse.verseNum
              ? (verses..[verses.length - 1] = Verse(verseNum: verse.verseNum, words: lastVerse.words + verse.words))
              : (verses..add(verse));
        });
}
