// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BibleMap _$BibleMapFromJson(Map<String, dynamic> json) => _BibleMap(
  id: json['i'] as String,
  title: json['t'] as String,
  caption: json['c'] as String?,
  passages: (json['p'] as List<dynamic>)
      .map((e) => VerseSelection.fromJson(e as String))
      .toList(),
);

Map<String, dynamic> _$BibleMapToJson(_BibleMap instance) => <String, dynamic>{
  'i': instance.id,
  't': instance.title,
  'c': ?instance.caption,
  'p': instance.passages.map((e) => e.toJson()).toList(),
};
