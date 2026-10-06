// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Creed _$CreedFromJson(Map<String, dynamic> json) => _Creed(
  id: json['i'] as String,
  title: json['t'] as String,
  year: json['y'] as String,
  authors:
      (json['a'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  type: $enumDecode(_$CreedTypeEnumMap, json['k']),
  chapters: (json['c'] as List<dynamic>)
      .map((e) => CreedChapter.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CreedToJson(_Creed instance) => <String, dynamic>{
  'i': instance.id,
  't': instance.title,
  'y': instance.year,
  'a': ?nullIfEmpty(instance.authors),
  'k': _$CreedTypeEnumMap[instance.type]!,
  'c': instance.chapters.map((e) => e.toJson()).toList(),
};

const _$CreedTypeEnumMap = {
  CreedType.creed: 'creed',
  CreedType.confession: 'confession',
  CreedType.catechism: 'catechism',
};

_CreedChapter _$CreedChapterFromJson(Map<String, dynamic> json) =>
    _CreedChapter(
      number: json['n'] as String?,
      title: json['t'] as String?,
      items: (json['i'] as List<dynamic>)
          .map((e) => CreedItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreedChapterToJson(_CreedChapter instance) =>
    <String, dynamic>{
      'n': ?instance.number,
      't': ?instance.title,
      'i': instance.items.map((e) => e.toJson()).toList(),
    };

_CreedItem _$CreedItemFromJson(Map<String, dynamic> json) => _CreedItem(
  number: json['n'] as String?,
  title: json['t'] as String?,
  body: (json['b'] as List<dynamic>)
      .map((e) => RichContent.fromJson(e as Map<String, dynamic>))
      .toList(),
  passages:
      (json['p'] as List<dynamic>?)
          ?.map((e) => VerseSelection.fromJson(e as String))
          .toList() ??
      const [],
);

Map<String, dynamic> _$CreedItemToJson(_CreedItem instance) =>
    <String, dynamic>{
      'n': ?instance.number,
      't': ?instance.title,
      'b': instance.body.map((e) => e.toJson()).toList(),
      'p': ?nullIfEmpty(instance.passages),
    };
