import 'package:bible/models/bible_translation.dart';
import 'package:bible/models/book_type.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'selection.freezed.dart';
part 'selection.g.dart';

@freezed
sealed class Selection with _$Selection {
  const Selection._();

  const factory Selection.passage({required Passage passage}) = PassageSelection;
  const factory Selection.words({
    required SelectionWordAnchor start,
    required SelectionWordAnchor end,
    required BibleTranslation translation,
  }) = WordsSelection;

  factory Selection.fromJson(Map<String, dynamic> json) => _$SelectionFromJson(json);
}

class SelectionWordAnchor {
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

  String toKey() => [book.osisId(), chapterNum, verseNum, characterOffset].join('.');
}
