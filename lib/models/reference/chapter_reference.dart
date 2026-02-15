import 'package:bible/models/book_type.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/reference/verse_span_reference.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter_reference.freezed.dart';
part 'chapter_reference.g.dart';

@freezed
sealed class ChapterReference with _$ChapterReference implements ReferencesRegion {
  const ChapterReference._();

  const factory ChapterReference({required BookType book, required int chapterNum}) = _ChapterReference;

  static ChapterReference fromOsisId(String key) {
    final items = key.split('.');
    return ChapterReference(
      book: BookType.values.firstWhere((book) => book.osisId() == items[0]),
      chapterNum: int.parse(items[1]),
    );
  }

  factory ChapterReference.fromJson(Map<String, dynamic> json) => _$ChapterReferenceFromJson(json);

  Reference getReference(int verseNum) => Reference(book: book, chapterNum: chapterNum, verseNum: verseNum);

  Passage toPassage() => Passage(spans: [VerseSpanReference(start: asPointer())]);

  String osisId() => '${book.osisId()}.$chapterNum';

  String format() => '${book.title()} $chapterNum';

  @override
  List<Reference> get references => List.generate(numVerses, (i) => getReference(i + 1));

  int get numVerses => book.bookInfo.getNumVerses(chapterNum);

  BiblePointer asPointer() => ChapterBiblePointer(reference: this);
}
