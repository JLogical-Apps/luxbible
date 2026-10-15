import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/src/utils/extensions/date_time_extensions.dart';

const jsonIgnore = JsonKey(includeToJson: false, includeFromJson: false);
const isoDate = JsonKey(fromJson: decodeIsoDate, toJson: encodeIsoDate);

// A JsonKey subclass rather than a constant so it can carry a key name, since json_serializable reads only one JsonKey.
// `toJson` is redeclared because json_serializable reads it without looking at superclass fields.
class IgnoreIfEmpty extends JsonKey {
  @override
  // ignore: overridden_fields
  final toJson = nullIfEmpty;

  const IgnoreIfEmpty({super.name}) : super(includeIfNull: false);
}

// Unknown names are dropped instead of failing, since a failed decode of saved user data would reset it.
// json_serializable only matches converters with concrete type arguments and no constructor arguments, so each enum
// gets a small subclass like `class KnownTutorials extends KnownEnumSet<Tutorial>`.
abstract class KnownEnumList<T extends Enum> implements JsonConverter<List<T>, List<Object?>> {
  final List<T> values;

  const KnownEnumList(this.values);

  @override
  List<T> fromJson(List<Object?> json) => decodeKnownEnums(values, json).toList();

  @override
  List<Object?> toJson(List<T> list) => list.map((value) => value.name).toList();
}

abstract class KnownEnumSet<T extends Enum> implements JsonConverter<Set<T>, List<Object?>> {
  final List<T> values;

  const KnownEnumSet(this.values);

  @override
  Set<T> fromJson(List<Object?> json) => decodeKnownEnums(values, json).toSet();

  @override
  List<Object?> toJson(Set<T> set) => set.map((value) => value.name).toList();
}

Iterable<T> decodeKnownEnums<T extends Enum>(List<T> values, List<Object?> json) =>
    json.map((name) => values.asNameMap()[name]).nonNulls;

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
