// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  translation:
      $enumDecodeNullable(_$BibleTranslationEnumMap, json['translation']) ??
      BibleTranslation.asv,
  lastReference: json['lastReference'] == null
      ? const ChapterReference(chapterNum: 1, book: BookType.genesis)
      : ChapterReference.fromJson(json['lastReference'] as String),
  previouslyViewed:
      (json['previouslyViewed'] as List<dynamic>?)
          ?.map((e) => ChapterReference.fromJson(e as String))
          .toList() ??
      const [],
  highlightColor:
      $enumDecodeNullable(_$ColorEnumEnumMap, json['highlightColor']) ??
      ColorEnum.yellow,
  bookmarks:
      (json['bookmarks'] as List<dynamic>?)
          ?.map((e) => Bookmark.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  annotations:
      (json['annotations'] as List<dynamic>?)
          ?.map((e) => Annotation.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  toolbar: json['toolbar'] == null
      ? const ToolbarConfiguration()
      : ToolbarConfiguration.fromJson(json['toolbar'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'translation': _$BibleTranslationEnumMap[instance.translation]!,
  'lastReference': instance.lastReference,
  'previouslyViewed': instance.previouslyViewed,
  'highlightColor': _$ColorEnumEnumMap[instance.highlightColor]!,
  'bookmarks': instance.bookmarks,
  'annotations': instance.annotations,
  'toolbar': instance.toolbar,
};

const _$BibleTranslationEnumMap = {
  BibleTranslation.kjv: 'kjv',
  BibleTranslation.asv: 'asv',
};

const _$ColorEnumEnumMap = {
  ColorEnum.red: 'red',
  ColorEnum.orange: 'orange',
  ColorEnum.yellow: 'yellow',
  ColorEnum.green: 'green',
  ColorEnum.blue: 'blue',
  ColorEnum.violet: 'violet',
  ColorEnum.stone: 'stone',
};
