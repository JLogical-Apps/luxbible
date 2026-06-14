import 'dart:convert';

import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/bible/word.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:intersperse/intersperse.dart';
import 'package:utils_core/utils_core.dart';

class BibleImporter {
  Future<Bible> importBible({required BibleTranslation translation, required Bible bsb}) async => switch (translation) {
    .kjv || .asv => await parseJsonBible(translation: translation),
    .bsb => bsb,
    .original => parseOriginalLanguagesBible(bsb: bsb),
    _ => throw UnimplementedError(),
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

  Future<Bible> parseBsbJsonBible() async {
    final rawBsb = await rootBundle.loadString('assets/translations/bsb.json');
    return Bible(
      translation: .bsb,
      books: (jsonDecode(rawBsb) as List).map((bookJson) => Book.fromJson(bookJson)).toList(),
    );
  }

  Bible parseOriginalLanguagesBible({required Bible bsb}) => Bible(
    translation: .original,
    books: bsb.books
        .map(
          (book) => book.copyWith(
            chapters: book.chapters
                .map(
                  (chapter) => Chapter.verses(
                    verses: chapter.verses.values
                        .map(
                          (verse) => Verse(
                            verseNum: verse.verseNum,
                            words: verse.words
                                .where((word) => word.data?.inflection != null)
                                .sortedBy((a) => a.data!.originalPosition)
                                .map((word) => word.copyWith(text: word.data!.inflection))
                                .intersperse(Word(text: ' '))
                                .toList(),
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
