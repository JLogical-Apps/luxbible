import 'dart:convert';

import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/bible/verse_fragment.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:utils_core/utils_core.dart';
import 'package:xml/xml.dart';

class BibleImporter {
  Future<Bible> import({required BibleTranslation translation}) {
    return switch (translation) {
      .kjv || .asv => parseJsonBible(translation: translation),
      .bsb => parseUsxBible(translation: translation),
    };
  }

  Future<Bible> parseUsxBible({required BibleTranslation translation}) async {
    return Bible(
      translation: translation,
      books: await BookType.values.map((type) async {
        final rawXml = await rootBundle.loadString('assets/translations/${translation.name}/${type.usxCode()}.usx');
        final doc = XmlDocument.parse(rawXml);

        return Book(
          bookType: type,
          chapters: doc.findAllElements('chapter').mapIndexed((chapterIndex, div) {
            int? lastVerseNum;

            List<Verse> parseUsxVerses(XmlElement element) => element.children
                .map(
                  (node) => switch (node) {
                    XmlText(:final value) when value.trim().isNotEmpty && lastVerseNum != null => Verse(
                      verseNum: lastVerseNum!,
                      fragments: [VerseFragment(text: value.trim(), strongIds: const [])],
                    ),
                    XmlElement node when node.localName == 'verse' => () {
                      lastVerseNum = int.parse(node.getAttribute('number')!);
                      return null;
                    }(),
                    _ => null,
                  },
                )
                .nonNulls
                .toList();

            return Chapter(
              chapterNum: chapterIndex + 1,
              paragraphs: div.nextElementSiblings
                  .takeWhile((div) => div.localName != 'chapter')
                  .map(
                    (div) => switch (div.getAttribute('style')) {
                      's1' => SectionParagraph(type: .s1, text: div.innerText),
                      's2' => SectionParagraph(type: .s2, text: div.innerText),
                      'p' || 'pmo' || 'pc' => VersesParagraph(type: .p, verses: parseUsxVerses(div)),
                      'd' => VersesParagraph(type: .d, verses: parseUsxVerses(div)),
                      'q1' => VersesParagraph(type: .q1, verses: parseUsxVerses(div)),
                      'q2' => VersesParagraph(type: .q2, verses: parseUsxVerses(div)),
                      'qr' => VersesParagraph(type: .qr, verses: parseUsxVerses(div)),
                      'b' => BreakParagraph(),
                      'li1' => VersesParagraph(type: .li1, verses: parseUsxVerses(div)),
                      'li2' => VersesParagraph(type: .li2, verses: parseUsxVerses(div)),
                      _ => null,
                    },
                  )
                  .nonNulls
                  .where((paragraph) => paragraph.isNotEmpty)
                  .toList(),
            );
          }).toList(),
        );
      }).wait,
    );
  }

  Future<Bible> parseJsonBible({required BibleTranslation translation}) async {
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
                    (chapter, verses) => Chapter.verses(
                      chapterNum: chapter,
                      verses: verses.map((verse) => parseVerse(verseNum: verse.verseNum, raw: verse.text)).toList(),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }

  Verse parseVerse({required int verseNum, required String raw}) {
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

    return Verse(verseNum: verseNum, fragments: fragments);
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
