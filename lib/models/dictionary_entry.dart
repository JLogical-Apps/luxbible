import 'package:freezed_annotation/freezed_annotation.dart';

part 'dictionary_entry.freezed.dart';
part 'dictionary_entry.g.dart';

@freezed
sealed class DictionaryEntry with _$DictionaryEntry {
  const factory DictionaryEntry({
    @JsonKey(name: 't') required String title,
    @JsonKey(name: 'd') required String definition,
  }) = _DictionaryEntry;

  factory DictionaryEntry.fromJson(Map<String, dynamic> json) => _$DictionaryEntryFromJson(json);
}
