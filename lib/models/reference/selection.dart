import 'package:bible/models/bible_translation.dart';
import 'package:bible/models/book_type.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/utils/comparable_operators.dart';
import 'package:bible/utils/extensions/num_extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'selection.freezed.dart';
part 'selection.g.dart';

@freezed
sealed class Selection with _$Selection implements Region {
  const Selection._();

  const factory Selection({
    required SelectionWordAnchor start,
    required SelectionWordAnchor end,
    required BibleTranslation translation,
  }) = _Selection;

  factory Selection.character({required SelectionWordAnchor anchor, required BibleTranslation translation}) =>
      Selection(start: anchor, end: anchor, translation: translation);

  factory Selection.fromJson(Map<String, dynamic> json) => _$SelectionFromJson(json);

  bool intersects(Selection selection) => end >= selection.start && selection.end >= start;
  bool isInReference(Reference reference) => reference >= start.toReference() && reference <= end.toReference();
  bool isInPassage(Passage passage) => passage.references.any((reference) => isInReference(reference));
}

class SelectionWordAnchor extends Equatable with ComparableOperators<SelectionWordAnchor> {
  final BookType book;
  final int chapterNum;
  final int verseNum;
  final int characterOffset;

  const SelectionWordAnchor({
    required this.book,
    required this.chapterNum,
    required this.verseNum,
    required this.characterOffset,
  });

  factory SelectionWordAnchor.fromReference({required Reference reference, required int characterOffset}) =>
      SelectionWordAnchor(
        book: reference.book,
        chapterNum: reference.chapterNum,
        verseNum: reference.verseNum,
        characterOffset: characterOffset,
      );

  factory SelectionWordAnchor.fromKey(String key) {
    final items = key.split('.');
    return SelectionWordAnchor(
      book: BookType.values.firstWhere((book) => book.osisId() == items[0]),
      chapterNum: int.parse(items[1]),
      verseNum: int.parse(items[2]),
      characterOffset: int.parse(items[3]),
    );
  }

  factory SelectionWordAnchor.fromJson(String json) = SelectionWordAnchor.fromKey;
  String toJson() => toKey();

  @override
  List<Object> get props => [book, chapterNum, verseNum, characterOffset];

  String toKey() => [book.osisId(), chapterNum, verseNum, characterOffset].join('.');

  Reference toReference() => Reference(book: book, chapterNum: chapterNum, verseNum: verseNum);

  @override
  int compareTo(SelectionWordAnchor other) =>
      book.index.compareTo(other.book.index).nullIfZero ??
      chapterNum.compareTo(other.chapterNum).nullIfZero ??
      verseNum.compareTo(other.verseNum).nullIfZero ??
      characterOffset.compareTo(other.characterOffset);
}
