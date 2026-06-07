import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/reference/verse_span_reference.dart';
import 'package:bible/utils/comparable_operators.dart';
import 'package:bible/utils/extensions/num_extensions.dart';
import 'package:equatable/equatable.dart';

class ChapterReference extends Equatable with ComparableOperators<ChapterReference> implements ReferencesRegion {
  final BookType book;
  final int chapterNum;

  const ChapterReference({required this.book, required this.chapterNum});

  factory ChapterReference.fromOsisId(String key) {
    final items = key.split('.');
    return ChapterReference(book: BookType.fromOsisId(items[0]), chapterNum: int.parse(items[1]));
  }

  factory ChapterReference.fromBibleChapterIndex(int index) => values[index];

  factory ChapterReference.fromJson(String json) = ChapterReference.fromOsisId;
  String toJson() => osisId();

  @override
  List<Object> get props => [book, chapterNum];

  @override
  int compareTo(ChapterReference other) =>
      book.index.compareTo(other.book.index).nullIfZero ?? chapterNum.compareTo(other.chapterNum).nullIfZero ?? 0;

  Reference getReference(int verseNum) => Reference(book: book, chapterNum: chapterNum, verseNum: verseNum);

  VerseSelection toVerseSelection() => VerseSelection(spans: [VerseSpanReference(start: asPointer())]);

  String osisId() => '${book.osisId()}.$chapterNum';
  String usxId() => '${book.usxCode()}.$chapterNum';

  String format() => '${book.title()} $chapterNum';

  @override
  List<Reference> get references => List.generate(numVerses, (i) => getReference(i + 1));

  int get numVerses => book.bookInfo.getNumVerses(chapterNum);

  static final List<ChapterReference> values = BookType.values
      .expand(
        (book) => List.generate(book.bookInfo.numChapters, (i) => ChapterReference(book: book, chapterNum: i + 1)),
      )
      .toList();

  int get bibleChapterIndex => values.indexOf(this);

  BiblePointer asPointer() => ChapterBiblePointer(reference: this);

  ChapterReference? get next => values.elementAtOrNull(bibleChapterIndex + 1);
  ChapterReference? get previous => bibleChapterIndex == 0 ? null : values[bibleChapterIndex - 1];
}
