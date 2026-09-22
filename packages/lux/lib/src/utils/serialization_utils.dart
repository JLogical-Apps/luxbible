import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/src/utils/extensions/date_time_extensions.dart';

const jsonIgnore = JsonKey(includeToJson: false, includeFromJson: false);
const nullUnknownEnum = JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue);
const isoDate = JsonKey(fromJson: decodeIsoDate, toJson: encodeIsoDate);

String encodeIsoDate(DateTime date) => date.isoDate;

DateTime decodeIsoDate(String value) =>
    tryDecodeIsoDate(value) ?? (throw FormatException('Expected a yyyy-MM-dd date.', value));

// Round-trips the result so partial or overflowing dates like `2026-02-30` are rejected.
DateTime? tryDecodeIsoDate(String value) {
  final date = DateTime.tryParse(value);
  return date?.isoDate == value ? date : null;
}
