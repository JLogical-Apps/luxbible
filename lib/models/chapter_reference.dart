import 'package:bible/models/book_type.dart';
import 'package:bible/models/reference.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter_reference.freezed.dart';
part 'chapter_reference.g.dart';

@freezed
sealed class ChapterReference with _$ChapterReference {
  const ChapterReference._();

  const factory ChapterReference({required BookType book, required int chapterNum}) = _ChapterReference;

  static ChapterReference fromKey(String key) {
    final items = key.split('.');
    return ChapterReference(
      book: BookType.values.firstWhere((book) => book.osisId() == items[0]),
      chapterNum: int.parse(items[1]),
    );
  }

  factory ChapterReference.fromJson(Map<String, dynamic> json) => _$ChapterReferenceFromJson(json);

  Reference getReference(int verseNum) => Reference(book: book, chapterNum: chapterNum, verseNum: verseNum);

  String toKey() => '${book.osisId()}.$chapterNum';

  String format() => '${book.title()} $chapterNum';
}
