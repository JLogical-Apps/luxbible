import 'package:bible/models/book_type.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/region.dart';
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
    return ChapterReference(
      book: BookType.values.firstWhere((book) => book.osisId() == items[0]),
      chapterNum: int.parse(items[1]),
    );
  }

  factory ChapterReference.fromJson(String json) = ChapterReference.fromOsisId;
  String toJson() => osisId();

  @override
  List<Object> get props => [book, chapterNum];

  @override
  int compareTo(ChapterReference other) =>
      book.index.compareTo(other.book.index).nullIfZero ?? chapterNum.compareTo(other.chapterNum).nullIfZero ?? 0;

  Reference getReference(int verseNum) => Reference(book: book, chapterNum: chapterNum, verseNum: verseNum);

  Passage toPassage() => Passage(spans: [VerseSpanReference(start: asPointer())]);

  String osisId() => '${book.osisId()}.$chapterNum';

  String format() => '${book.title()} $chapterNum';

  @override
  List<Reference> get references => List.generate(numVerses, (i) => getReference(i + 1));

  int get numVerses => book.bookInfo.getNumVerses(chapterNum);

  BiblePointer asPointer() => ChapterBiblePointer(reference: this);
}
