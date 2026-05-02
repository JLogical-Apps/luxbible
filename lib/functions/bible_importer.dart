import 'dart:convert';

import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/display/bible.dart';
import 'package:bible/models/bible/display/book.dart';
import 'package:bible/models/bible/display/chapter.dart';
import 'package:bible/models/bible/display/paragraph.dart';
import 'package:bible/models/bible/display/verse.dart';
import 'package:bible/models/bible/study/bible.dart';
import 'package:bible/models/bible/study/book.dart';
import 'package:bible/models/bible/study/chapter.dart';
import 'package:bible/models/bible/study/study_verse.dart';
import 'package:bible/models/bible/study/verse_fragment.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:utils_core/utils_core.dart';
import 'package:xml/xml.dart';

class BibleImporter {
  Future<DisplayBible> importDisplay({required BibleTranslation translation}) async {
    return switch (translation) {
      .kjv || .asv => DisplayBible.fromStudy(await parseJsonBible(translation: translation)),
      .bsb => await parseUsxBible(translation: translation),
    };
  }

  Future<StudyBible> importStudy({required BibleTranslation translation}) async {
    return switch (translation) {
      .kjv || .asv => await parseJsonBible(translation: translation),
      .bsb => StudyBible.fromDisplay(await parseUsxBible(translation: translation)),
    };
  }

  Future<DisplayBible> parseUsxBible({required BibleTranslation translation}) async {
    return DisplayBible(
      translation: translation,
      books: await BookType.values.map((type) async {
        final rawXml = await rootBundle.loadString('assets/translations/${translation.name}/${type.usxCode()}.usx');
        final doc = XmlDocument.parse(rawXml);

        return DisplayBook(
          bookType: type,
          chapters: doc.findAllElements('chapter').mapIndexed((chapterIndex, div) {
            int? lastVerseNum;
            return DisplayChapter(
              chapterNum: chapterIndex + 1,
              paragraphs: div.nextElementSiblings
                  .takeWhile((div) => div.localName != 'chapter')
                  .fold(<Paragraph?>[], (paragraphs, div) {
                    List<DisplayVerse> parseUsxVerses(XmlElement element) => element.children
                        .expand<DisplayVerse>(
                          (node) => switch (node) {
                            XmlText(:final value) when value.trim().isNotEmpty && lastVerseNum != null => [
                              DisplayVerse(verseNum: lastVerseNum!, text: value.trim()),
                            ],
                            XmlElement node when node.localName == 'verse' => () {
                              lastVerseNum = int.parse(node.getAttribute('number')!);
                              return <DisplayVerse>[];
                            }(),
                            XmlElement node when node.localName == 'char' && lastVerseNum != null => parseUsxVerses(
                              node,
                            ),
                            _ => [],
                          },
                        )
                        .withSameVersesCombined()
                        .toList();

                    VersesParagraph? versesParagraph(ParagraphType type) {
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
                        type: type,
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

  Future<StudyBible> parseJsonBible({required BibleTranslation translation}) async {
    final rawJson = await rootBundle.loadString('assets/translations/${translation.name}.json');
    final json = jsonDecode(rawJson);

    final verses = (json['verses'] as Iterable)
        .map(
          (verse) => (
            book: verse['book'] as int,
            chapterNum: verse['chapter'] as int,
            verseNum: verse['verse'] as int,
            text: verse['text'],
          ),
        )
        .toList();

    return StudyBible(
      translation: translation,
      books: verses
          .groupListsBy((verse) => verse.book)
          .mapToIterable(
            (book, verses) => StudyBook(
              bookType: BookType.values[book - 1],
              chapters: verses
                  .groupListsBy((verse) => verse.chapterNum)
                  .mapToIterable(
                    (chapter, verses) => StudyChapter(
                      chapterNum: chapter,
                      verses: verses.mapToMap(
                        (verse) => MapEntry(verse.verseNum, parseVerse(verseNum: verse.verseNum, raw: verse.text)),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }

  StudyVerse parseVerse({required int verseNum, required String raw}) {
    final tokenRegExp = RegExp(r'\{.*?\}'); // minimally match {...}

    // 1) Tokenize into text and {...} strongs chunks
    final tokens = <String>[];
    int lastEnd = 0;

    for (final match in tokenRegExp.allMatches(raw)) {
      if (match.start > lastEnd) {
        tokens.add(raw.substring(lastEnd, match.start)); // text chunk
      }
      tokens.add(raw.substring(match.start, match.end)); // strongs chunk
      lastEnd = match.end;
    }
    if (lastEnd < raw.length) {
      tokens.add(raw.substring(lastEnd)); // trailing text
    }

    // 2) Now fold tokens into fragments.
    //    Each time we hit text, start a new fragment.
    //    Each time we hit {H...}, append to the last fragment’s strongs.
    final fragments = <VerseFragment>[];
    for (final token in tokens) {
      if (token.startsWith('{') && token.endsWith('}')) {
        final code = token.substring(1, token.length - 1);
        if (fragments.isEmpty) {
          // If doc starts with a strongs tag, inject empty text
          fragments.add(VerseFragment(text: '', strongIds: [code]));
        } else {
          // Add to the last fragment's strongs
          final last = fragments.last;
          fragments[fragments.length - 1] = VerseFragment(text: last.text, strongIds: [...last.strongIds, code]);
        }
      } else {
        // Plain text → start a fresh fragment
        fragments.add(VerseFragment(text: token));
      }
    }

    return StudyVerse(fragments: fragments);
  }
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

extension on Iterable<DisplayVerse> {
  Iterable<DisplayVerse> withSameVersesCombined() {
    if (isEmpty) {
      return this;
    }

    return fold<List<DisplayVerse>>(<DisplayVerse>[], (verses, verse) {
      final lastVerse = verses.lastOrNull;
      if (lastVerse == null) {
        return verses..add(verse);
      }

      return lastVerse.verseNum == verse.verseNum
          ? (verses
              ..[verses.length - 1] = DisplayVerse(verseNum: verse.verseNum, text: '${lastVerse.text} ${verse.text}'))
          : (verses..add(verse));
    });
  }
}
