import 'package:bible/models/bible_translation.dart';
import 'package:bible/models/book.dart';
import 'package:bible/models/book_type.dart';
import 'package:bible/models/chapter.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/models/verse.dart';

class Bible {
  final BibleTranslation translation;
  final List<Book> books;

  const Bible({required this.translation, required this.books});

  List<ChapterReference> get chapterReferences => books
      .expand(
        (book) => List.generate(book.chapters.length, (i) => ChapterReference(book: book.bookType, chapterNum: i + 1)),
      )
      .toList();

  Chapter getChapterByReference(ChapterReference reference) =>
      getBookByType(reference.book).chapters[reference.chapterNum - 1];

  Verse? getVerseByReference(Reference reference) =>
      getBookByType(reference.book).chapters[reference.chapterNum - 1].verses[reference.verseNum];

  ChapterReference getChapterReferenceByPageIndex(int pageIndex) => chapterReferences[pageIndex];

  int getPageIndexByChapterReference(ChapterReference reference) =>
      chapterReferences.indexWhere((r) => r.book == reference.book && r.chapterNum == reference.chapterNum);

  Book getBookByType(BookType bookType) => books.firstWhere((book) => book.bookType == bookType);

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
}
