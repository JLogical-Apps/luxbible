import 'dart:convert';

import 'package:bible/models/bible.dart';
import 'package:bible/models/bible_translation.dart';
import 'package:bible/models/book.dart';
import 'package:bible/models/book_type.dart';
import 'package:bible/models/chapter.dart';
import 'package:bible/models/verse.dart';
import 'package:bible/models/verse_fragment.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';

class BibleImporter {
  Future<Bible> import({required BibleTranslation translation}) async {
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

    return Bible(
      translation: translation,
      books: verses
          .groupListsBy((verse) => verse.book)
          .mapToIterable(
            (book, verses) => Book(
              bookType: BookType.values[book - 1],
              chapters: verses
                  .groupListsBy((verse) => verse.chapterNum)
                  .mapToIterable(
                    (chapter, verses) =>
                        Chapter(verses: verses.mapToMap((verse) => MapEntry(verse.verseNum, parseVerse(verse.text)))),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}

Verse parseVerse(String raw) {
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
      fragments.add(VerseFragment(text: token, strongIds: const []));
    }
  }

  return Verse(fragments: fragments);
}
