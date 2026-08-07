import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/src/models/reference/chapter_reference.dart';

part 'chapter_position.freezed.dart';
part 'chapter_position.g.dart';

@freezed
sealed class ChapterPosition with _$ChapterPosition {
  const factory ChapterPosition({required ChapterReference reference, int? verseNum}) = _ChapterPosition;

  factory ChapterPosition.fromJson(Map<String, dynamic> json) => _$ChapterPositionFromJson(json);
}

class ChapterPositionFromReference extends JsonKey {
  const ChapterPositionFromReference(String name) : super(name: name, readValue: read);

  static Object? _migrate(Object? value) => value is String ? {'reference': value} : value;

  static Object? read(Map<dynamic, dynamic> json, String key) {
    final value = json[key];
    return value is List ? value.map(_migrate).toList() : _migrate(value);
  }
}
