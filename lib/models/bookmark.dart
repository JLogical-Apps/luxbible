import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark.freezed.dart';
part 'bookmark.g.dart';

@freezed
sealed class Bookmark with _$Bookmark {
  const Bookmark._();

  const factory Bookmark({required ChapterReference chapter, @Default(ColorEnum.red) ColorEnum color}) = _Bookmark;

  factory Bookmark.fromJson(Map<String, dynamic> json) => _$BookmarkFromJson(json);
}
