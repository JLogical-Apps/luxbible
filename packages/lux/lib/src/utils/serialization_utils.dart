import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/src/utils/extensions/date_time_extensions.dart';

const jsonIgnore = JsonKey(includeToJson: false, includeFromJson: false);
const nullUnknownEnum = JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue);
const isoDate = JsonKey(fromJson: decodeIsoDate, toJson: encodeIsoDate);

// A JsonKey subclass rather than a constant so it can carry a key name, since json_serializable reads only one JsonKey.
// `toJson` is redeclared because json_serializable reads it without looking at superclass fields.
class IgnoreIfEmpty extends JsonKey {
  @override
  // ignore: overridden_fields
  final toJson = nullIfEmpty;

  const IgnoreIfEmpty({super.name}) : super(includeIfNull: false);
}

// Elements are left for `jsonEncode` to serialize, as json_serializable does without `explicit_to_json`.
List<Object?>? nullIfEmpty(List<Object?>? list) => list?.isEmpty == true ? null : list;

String encodeIsoDate(DateTime date) => date.isoDate;

DateTime decodeIsoDate(String value) =>
    tryDecodeIsoDate(value) ?? (throw FormatException('Expected a yyyy-MM-dd date.', value));

// Round-trips the result so partial or overflowing dates like `2026-02-30` are rejected.
DateTime? tryDecodeIsoDate(String value) {
  final date = DateTime.tryParse(value);
  return date?.isoDate == value ? date : null;
}
