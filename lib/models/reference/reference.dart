import 'package:bible/models/book_type.dart';
import 'package:equatable/equatable.dart';

class Reference extends Equatable implements Comparable<Reference> {
  final BookType book;
  final int chapterNum;
  final int verseNum;

  const Reference({required this.book, required this.chapterNum, required this.verseNum});

  factory Reference.fromOsisId(String key) {
    final items = key.split('.');
    return Reference(
      book: BookType.values.firstWhere((book) => book.osisId() == items[0]),
      chapterNum: int.parse(items[1]),
      verseNum: int.parse(items[2]),
    );
  }

  factory Reference.fromJson(String json) = Reference.fromOsisId;
  String toJson() => osisId();

  String osisId() => [book.osisId(), chapterNum, verseNum].join('.');

  String format() => '${book.title()} $chapterNum:$verseNum';

  Reference get next {
    final nextVerseNum = verseNum + 1;
    if (nextVerseNum <= book.bookInfo.getNumVerses(chapterNum)) {
      return Reference(book: book, chapterNum: chapterNum, verseNum: nextVerseNum);
    }

    final nextChapterNum = chapterNum + 1;
    if (nextChapterNum <= book.bookInfo.numChapters) {
      return Reference(book: book, chapterNum: nextChapterNum, verseNum: 1);
    }

    return Reference(book: book.next, chapterNum: 1, verseNum: 1);
  }

  bool operator <(Reference reference) => compareTo(reference) < 0;

  @override
  List<Object?> get props => [book, chapterNum, verseNum];

  @override
  int compareTo(Reference other) {
    final byBook = book.index.compareTo(other.book.index);
    if (byBook != 0) return byBook;

    final byChapter = chapterNum.compareTo(other.chapterNum);
    if (byChapter != 0) return byChapter;

    return verseNum.compareTo(other.verseNum);
  }
}
