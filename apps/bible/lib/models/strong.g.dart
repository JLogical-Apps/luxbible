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
  usage: Markdown.fromJson(json['d'] as String),
  definition: Markdown.fromJson(json['s'] as String),
  derivation: Markdown.fromJsonNullable(json['o'] as String?),
  partOfSpeech: json['t'] as String?,
  relatedStrongIds: (json['g'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$StrongToJson(_Strong instance) => <String, dynamic>{
  'i': instance.id,
  'l': instance.languageText,
  'p': instance.pronunciation,
  'x': instance.transliteration,
  'd': Markdown.toJson(instance.usage),
  's': Markdown.toJson(instance.definition),
  'o': ?Markdown.toJsonNullable(instance.derivation),
  't': ?instance.partOfSpeech,
  'g': instance.relatedStrongIds,
};
