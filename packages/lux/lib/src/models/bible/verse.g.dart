// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Verse _$VerseFromJson(Map<String, dynamic> json) => _Verse(
  verseNum: (json['n'] as num).toInt(),
  endVerseNum: (json['e'] as num?)?.toInt(),
  words: (json['w'] as List<dynamic>)
      .map((e) => Word.fromJson(e as Map<String, dynamic>))
      .toList(),
  originalVerse: json['o'] == null
      ? null
      : Reference.fromJson(json['o'] as String),
  footnotes: (json['f'] as List<dynamic>?)
      ?.map((e) => Footnote.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$VerseToJson(_Verse instance) => <String, dynamic>{
  'n': instance.verseNum,
  'e': ?instance.endVerseNum,
  'w': instance.words,
  'o': ?instance.originalVerse,
  'f': ?instance.footnotes,
};
