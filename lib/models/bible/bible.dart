import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/models/reference/verse_span_reference.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:bible/utils/range.dart';

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
  late final List<Verse> verses = references.map((reference) => getVerseByReference(reference)).nonNulls.toList();

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

  List<Verse> getVersesBySpan(VerseSpanReference reference) =>
      reference.references.map((reference) => getVerseByReference(reference)).nonNulls.toList();

  ChapterReference getChapterReferenceByPageIndex(int pageIndex) => chapterReferences[pageIndex];

  int getPageIndexByChapterReference(ChapterReference reference) =>
      chapterReferences.indexWhere((r) => r.book == reference.book && r.chapterNum == reference.chapterNum);

  late final Map<BookType, Book> _bookByType = BookType.values.mapToMap(
    (bookType) => MapEntry(bookType, books.firstWhere((book) => book.bookType == bookType)),
  );
  Book getBookByType(BookType bookType) => _bookByType[bookType]!;

  String getSelectionText(Selection selection) {
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

  Selection getWordsSelection(Selection selection) {
    final startVerseText = getVerseByReference(selection.start.toReference())!.text;
    final endVerseText = getVerseByReference(selection.end.toReference())!.text;
    return Selection(
      translation: translation,
      start: SelectionWordAnchor.fromReference(
        reference: selection.start.toReference(),
        characterOffset:
            List.generate(
              selection.start.characterOffset,
              (i) => i,
            ).where((offset) => startVerseText[offset] == ' ').lastOrNull?.mapIfNonNull((offset) => offset + 1) ??
            0,
      ),
      end: SelectionWordAnchor.fromReference(
        reference: selection.end.toReference(),
        characterOffset:
            Range.generate(
              selection.end.characterOffset,
              endVerseText.length - 1,
            ).where((offset) => endVerseText[offset].isLetterOnly).firstOrNull?.mapIfNonNull((offset) => offset - 1) ??
            endVerseText.length - 1,
      ),
    );
  }
}
