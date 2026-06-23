import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/utils/comparable_operators.dart';
import 'package:bible/utils/extensions/num_extensions.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class Reference extends Equatable with ComparableOperators<Reference> {
  final BookType book;
  final int chapterNum;
  final int verseNum;

  Reference({required this.book, required this.chapterNum, required this.verseNum});

  factory Reference.fromOsisId(String key) {
    final items = key.split('.');
    return Reference(
      book: BookType.fromOsisId(items[0]),
      chapterNum: int.parse(items[1]),
      verseNum: int.parse(items[2]),
    );
  }

  static List<Reference> get values => BookType.values
      .expand(
        (book) => book.bookInfo.chapterVerseLengths.mapIndexed(
          (chapterIndex, chapterVerseLength) =>
              Reference(book: book, chapterNum: chapterIndex + 1, verseNum: chapterVerseLength),
        ),
      )
      .toList();

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

  static Iterable<Reference> getReferencesBetween(Reference start, Reference end) sync* {
    var reference = start;
    yield reference;
    while (reference != end) {
      reference = reference.next;
      yield reference;
    }
  }

  @override
  late final List<Object?> props = [book, chapterNum, verseNum];

  @override
  int compareTo(Reference other) =>
      book.index.compareTo(other.book.index).nullIfZero ??
      chapterNum.compareTo(other.chapterNum).nullIfZero ??
      verseNum.compareTo(other.verseNum);

  ChapterReference toChapterReference() => ChapterReference(book: book, chapterNum: chapterNum);
}
