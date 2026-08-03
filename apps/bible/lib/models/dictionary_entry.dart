import 'package:lux/lux.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dictionary_entry.freezed.dart';
part 'dictionary_entry.g.dart';

@freezed
sealed class DictionaryEntry with _$DictionaryEntry {
  const DictionaryEntry._();

  const factory DictionaryEntry({
    @JsonKey(name: 't') required String title,
    @JsonKey(name: 'd', toJson: Markdown.toJsonList, fromJson: Markdown.fromJsonList)
    required List<Markdown> definitions,
  }) = _DictionaryEntry;

  factory DictionaryEntry.fromJson(Map<String, dynamic> json) => _$DictionaryEntryFromJson(json);
}
