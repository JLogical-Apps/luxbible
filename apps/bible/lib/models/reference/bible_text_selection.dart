import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/utils/comparable_operators.dart';
import 'package:bible/utils/extensions/num_extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bible_text_selection.freezed.dart';
part 'bible_text_selection.g.dart';

@freezed
sealed class BibleTextSelection with _$BibleTextSelection {
  const BibleTextSelection._();

  const factory BibleTextSelection({
    required BibleTextSelectionWordAnchor start,
    required BibleTextSelectionWordAnchor end,
    required BibleTranslation translation,
  }) = _BibleTextSelection;

  factory BibleTextSelection.character({
    required BibleTextSelectionWordAnchor anchor,
    required BibleTranslation translation,
  }) => BibleTextSelection(start: anchor, end: anchor, translation: translation);

  factory BibleTextSelection.fromJson(Map<String, dynamic> json) => _$BibleTextSelectionFromJson(json);

  bool intersects(BibleTextSelection textSelection) => end >= textSelection.start && textSelection.end >= start;
  bool isInReference(Reference reference) => reference >= start.toReference() && reference <= end.toReference();
  bool isInVerseSelection(VerseSelection verseSelection) =>
      verseSelection.references.any((reference) => isInReference(reference));

  VerseSelection toVerseSelection() =>
      VerseSelection.fromReferences(Reference.getReferencesBetween(start.toReference(), end.toReference()).toList());
}

class BibleTextSelectionWordAnchor extends Equatable with ComparableOperators<BibleTextSelectionWordAnchor> {
  final BookType book;
  final int chapterNum;
  final int verseNum;
  final int characterOffset;

  const BibleTextSelectionWordAnchor({
    required this.book,
    required this.chapterNum,
    required this.verseNum,
    required this.characterOffset,
  });

  factory BibleTextSelectionWordAnchor.fromReference({required Reference reference, required int characterOffset}) =>
      BibleTextSelectionWordAnchor(
        book: reference.book,
        chapterNum: reference.chapterNum,
        verseNum: reference.verseNum,
        characterOffset: characterOffset,
      );

  factory BibleTextSelectionWordAnchor.fromKey(String key) {
    final items = key.split('.');
    return BibleTextSelectionWordAnchor(
      book: BookType.fromOsisId(items[0]),
      chapterNum: int.parse(items[1]),
      verseNum: int.parse(items[2]),
      characterOffset: int.parse(items[3]),
    );
  }

  factory BibleTextSelectionWordAnchor.fromJson(String json) = BibleTextSelectionWordAnchor.fromKey;
  String toJson() => toKey();

  @override
  List<Object> get props => [book, chapterNum, verseNum, characterOffset];

  String toKey() => [book.osisId(), chapterNum, verseNum, characterOffset].join('.');

  Reference toReference() => Reference(book: book, chapterNum: chapterNum, verseNum: verseNum);
  ChapterReference toChapterReference() => toReference().toChapterReference();

  @override
  int compareTo(BibleTextSelectionWordAnchor other) =>
      book.index.compareTo(other.book.index).nullIfZero ??
      chapterNum.compareTo(other.chapterNum).nullIfZero ??
      verseNum.compareTo(other.verseNum).nullIfZero ??
      characterOffset.compareTo(other.characterOffset);

  BibleTextSelectionWordAnchor withCharactersAdded(int characters) =>
      copyWith(characterOffset: characterOffset + characters);

  BibleTextSelectionWordAnchor copyWith({BookType? book, int? chapterNum, int? verseNum, int? characterOffset}) =>
      BibleTextSelectionWordAnchor(
        book: book ?? this.book,
        chapterNum: chapterNum ?? this.chapterNum,
        verseNum: verseNum ?? this.verseNum,
        characterOffset: characterOffset ?? this.characterOffset,
      );
}
