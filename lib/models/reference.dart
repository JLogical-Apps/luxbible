import 'package:bible/models/book_type.dart';

class Reference implements Comparable<Reference> {
  final BookType book;
  final int chapterNum;
  final int verseNum;

  const Reference({required this.book, required this.chapterNum, required this.verseNum});

  String format() => '${book.title()} $chapterNum:$verseNum';

  @override
  int compareTo(Reference other) {
    final byBook = book.index.compareTo(other.book.index);
    if (byBook != 0) return byBook;

    final byChapter = chapterNum.compareTo(other.chapterNum);
    if (byChapter != 0) return byChapter;

    return verseNum.compareTo(other.verseNum);
  }
}
