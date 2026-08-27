import 'package:collection/collection.dart';
import 'package:lux/lux_core.dart';
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

  late final Map<Reference, Verse> verseByReference = references
      .mapToMap(
        (reference) => MapEntry(
          reference,
          getBookByType(reference.book).chapters[reference.chapterNum - 1].verses[reference.verseNum],
        ),
      )
      .withoutNullValues;

  Chapter getChapterByReference(ChapterReference reference) =>
      getBookByType(reference.book).chapters[reference.chapterNum - 1];

  Verse? getVerseByReference(Reference reference) => verseByReference[reference];

  late final Map<BookType, Book> _bookByType = BookType.values
      .mapToMap((bookType) => MapEntry(bookType, books.firstWhereOrNull((book) => book.bookType == bookType)))
      .withoutNullValues;
  Book getBookByType(BookType bookType) => _bookByType[bookType]!;

  String getTextSelectionText(BibleTextSelection selection) =>
      getPassageVerses(selection.toVerseSelection()).getTextSelectionText(selection);

  List<Word> getTextSelectionWords(BibleTextSelection selection) =>
      getPassageVerses(selection.toVerseSelection()).getTextSelectionWords(selection);

  List<Verse> getVersesBySpan(VerseSpanReference reference) =>
      reference.references.map((reference) => getVerseByReference(reference)).nonNulls.toList();

  List<Verse> getPassageVerses(VerseSelection selection) =>
      selection.references.map((reference) => getVerseByReference(reference)).nonNulls.toList();
}
