import 'package:bible/models/bible_translation.dart';
import 'package:bible/models/book.dart';
import 'package:bible/models/book_type.dart';
import 'package:bible/models/chapter.dart';
import 'package:bible/models/chapter_reference.dart';

class Bible {
  final BibleTranslation translation;
  final List<Book> books;

  const Bible({required this.translation, required this.books});

  List<ChapterReference> get chapterReferences => books
      .expand(
        (book) => List.generate(
          book.chapters.length,
          (i) => ChapterReference(book: book.bookType, chapterNum: i + 1),
        ),
      )
      .toList();

  Chapter getChapterByReference(ChapterReference reference) =>
      getBookByType(reference.book).chapters[reference.chapterNum - 1];

  ChapterReference getChapterReferenceByPageIndex(int pageIndex) =>
      chapterReferences[pageIndex];

  int getPageIndexByChapterReference(ChapterReference reference) =>
      chapterReferences.indexWhere(
        (r) => r.book == reference.book && r.chapterNum == reference.chapterNum,
      );

  Book getBookByType(BookType bookType) =>
      books.firstWhere((book) => book.bookType == bookType);
}
