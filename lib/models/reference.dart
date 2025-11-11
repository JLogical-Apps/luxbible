import 'package:bible/models/book_type.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reference.freezed.dart';
part 'reference.g.dart';

@freezed
sealed class Reference with _$Reference implements Comparable<Reference> {
  const Reference._();

  const factory Reference({
    required BookType book,
    required int chapterNum,
    required int verseNum,
  }) = _Reference;

  factory Reference.fromJson(Map<String, dynamic> json) => _$ReferenceFromJson(json);

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
