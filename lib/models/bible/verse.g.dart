// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Verse _$VerseFromJson(Map<String, dynamic> json) => _Verse(
  verseNum: (json['n'] as num).toInt(),
  words: (json['w'] as List<dynamic>)
      .map((e) => Word.fromJson(e as Map<String, dynamic>))
      .toList(),
  originalVerse: json['o'] == null
      ? null
      : Reference.fromJson(json['o'] as String),
);

Map<String, dynamic> _$VerseToJson(_Verse instance) => <String, dynamic>{
  'n': instance.verseNum,
  'w': instance.words.map((e) => e.toJson()).toList(),
  'o': ?instance.originalVerse?.toJson(),
};
