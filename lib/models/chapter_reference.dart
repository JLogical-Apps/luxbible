import 'package:bible/models/book_type.dart';
import 'package:bible/models/reference.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter_reference.freezed.dart';
part 'chapter_reference.g.dart';

@freezed
sealed class ChapterReference with _$ChapterReference {
  const ChapterReference._();

  const factory ChapterReference({required BookType book, required int chapterNum}) =
      _ChapterReference;

  factory ChapterReference.fromJson(Map<String, dynamic> json) =>
      _$ChapterReferenceFromJson(json);

  Reference getReference(int verseNum) =>
      Reference(book: book, chapterNum: chapterNum, verseNum: verseNum);

  String format() => '${book.title()} $chapterNum';
}
