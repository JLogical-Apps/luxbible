import 'dart:convert';

import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/bible/word.dart';
import 'package:flutter/services.dart';
import 'package:utils_core/utils_core.dart';

class BibleImporter {
  Future<Bible> importBible({required BibleTranslation translation}) async => switch (translation) {
    .kjv || .asv => await parseJsonBible(translation: translation),
    .bsb => await parseBsbJsonBible(translation: translation),
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

  Future<Bible> parseBsbJsonBible({required BibleTranslation translation}) async {
    final rawBsb = await rootBundle.loadString('assets/translations/bsb.json');
    return Bible(
      translation: translation,
      books: (jsonDecode(rawBsb) as List).map((bookJson) => Book.fromJson(bookJson)).toList(),
    );
  }
}
