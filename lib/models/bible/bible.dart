import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/bible/word.dart';
import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/reference/verse_span_reference.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:collection/collection.dart';
import 'package:utils_core/utils_core.dart';

class Bible {
  final BibleTranslation translation;
  final List<Book> books;

  Bible({required this.translation, required this.books});

  List<ChapterReference> get chapterReferences => books
      .expand(
        (book) => List.generate(book.chapters.length, (i) => ChapterReference(book: book.bookType, chapterNum: i + 1)),
      )
      .toList();

  late final List<Reference> references = chapterReferences.expand((chapter) => chapter.references).toList();

  late final Map<Reference, Verse> _verseByReference = references
      .mapToMap(
        (reference) => MapEntry(
          reference,
          getBookByType(reference.book).chapters[reference.chapterNum - 1].verses[reference.verseNum],
        ),
      )
      .withoutNullValues;

  Chapter getChapterByReference(ChapterReference reference) =>
      getBookByType(reference.book).chapters[reference.chapterNum - 1];

  Verse? getVerseByReference(Reference reference) => _verseByReference[reference];

  late final Map<BookType, Book> _bookByType = BookType.values
      .mapToMap((bookType) => MapEntry(bookType, books.firstWhereOrNull((book) => book.bookType == bookType)))
      .withoutNullValues;
  Book getBookByType(BookType bookType) => _bookByType[bookType]!;

  String getVerseSelectionText(VerseSelection selection) =>
      selection.references.map((reference) => getVerseByReference(reference)?.text).nonNulls.join(' ');

  String getTextSelectionText(BibleTextSelection selection) {
    final verseTexts = Reference.getReferencesBetween(
      selection.start.toReference(),
      selection.end.toReference(),
    ).map((reference) => getVerseByReference(reference)?.text).nonNulls.toList();
    verseTexts[verseTexts.length - 1] = verseTexts[verseTexts.length - 1].substring(
      0,
      selection.end.characterOffset + 1,
    );
    verseTexts[0] = verseTexts[0].substring(selection.start.characterOffset);

    return verseTexts.join(' ');
  }

  List<Word> getTextSelectionWords(BibleTextSelection selection) {
    final verses = Reference.getReferencesBetween(
      selection.start.toReference(),
      selection.end.toReference(),
    ).map((reference) => getVerseByReference(reference)).nonNulls.toList();

    return verses.expandIndexed((i, verse) {
      var words = verse.words;
      if (i + 1 == verses.length) {
        words = words
            .mapWithPrevious<(int, Word)>(
              (previousOffsetAndWord, word) =>
                  ((previousOffsetAndWord?.$1 ?? 0) + (previousOffsetAndWord?.$2.text?.length ?? 0), word),
            )
            .where((offsetAndWord) => offsetAndWord.$1 <= selection.end.characterOffset + 1)
            .map((offsetAndWord) => offsetAndWord.$2)
            .toList();
      }
      if (i == 0) {
        words = words
            .mapWithPrevious<(int, Word)>(
              (previousOffsetAndWord, word) =>
                  ((previousOffsetAndWord?.$1 ?? 0) + (previousOffsetAndWord?.$2.text?.length ?? 0), word),
            )
            .where(
              (offsetAndWord) =>
                  offsetAndWord.$1 + (offsetAndWord.$2.text?.length ?? 0) >= selection.start.characterOffset,
            )
            .map((offsetAndWord) => offsetAndWord.$2)
            .toList();
      }
      return words;
    }).toList();
  }

  List<Verse> getVersesBySpan(VerseSpanReference reference) =>
      reference.references.map((reference) => getVerseByReference(reference)).nonNulls.toList();
}
