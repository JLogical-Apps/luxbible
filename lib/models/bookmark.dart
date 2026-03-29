import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'bookmark.freezed.dart';
part 'bookmark.g.dart';

@freezed
sealed class Bookmark with _$Bookmark {
  Bookmark._({String? id}) : id = id ?? Uuid().v4();

  factory Bookmark({String? id, required ChapterReference chapter, @Default(ColorEnum.red) ColorEnum color}) =
      _Bookmark;

  @override
  final String id;

  factory Bookmark.fromJson(Map<String, dynamic> json) => _$BookmarkFromJson(json);
}
