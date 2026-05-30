// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strong.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Strong _$StrongFromJson(Map<String, dynamic> json) => _Strong(
  id: json['i'] as String,
  languageText: json['l'] as String,
  pronunciation: json['p'] as String,
  transliteration: json['x'] as String,
  definition: json['d'] as String,
  glossary: (json['g'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$StrongToJson(_Strong instance) => <String, dynamic>{
  'i': instance.id,
  'l': instance.languageText,
  'p': instance.pronunciation,
  'x': instance.transliteration,
  'd': instance.definition,
  'g': instance.glossary,
};
