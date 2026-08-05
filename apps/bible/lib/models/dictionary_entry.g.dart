// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DictionaryEntry _$DictionaryEntryFromJson(Map<String, dynamic> json) =>
    _DictionaryEntry(title: json['t'] as String, definitions: Markdown.fromJsonList(json['d'] as List));

Map<String, dynamic> _$DictionaryEntryToJson(_DictionaryEntry instance) => <String, dynamic>{
  't': instance.title,
  'd': Markdown.toJsonList(instance.definitions),
};
