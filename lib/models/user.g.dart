// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  translation: $enumDecodeNullable(_$BibleTranslationEnumMap, json['translation']) ?? BibleTranslation.asv,
  tabs:
      (json['tabs'] as List<dynamic>?)?.map((e) => ChapterReference.fromJson(e as Map<String, dynamic>)).toList() ??
      const [],
  previouslyViewed:
      (json['previouslyViewed'] as List<dynamic>?)
          ?.map((e) => ChapterReference.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  highlightByKey:
      (json['highlightByKey'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, $enumDecode(_$ColorEnumEnumMap, e)),
      ) ??
      const {},
  highlightColor: $enumDecodeNullable(_$ColorEnumEnumMap, json['highlightColor']) ?? ColorEnum.yellow,
  bookmarks:
      (json['bookmarks'] as List<dynamic>?)?.map((e) => Bookmark.fromJson(e as Map<String, dynamic>)).toList() ??
      const [],
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'translation': _$BibleTranslationEnumMap[instance.translation]!,
  'tabs': instance.tabs,
  'previouslyViewed': instance.previouslyViewed,
  'highlightByKey': instance.highlightByKey.map((k, e) => MapEntry(k, _$ColorEnumEnumMap[e]!)),
  'highlightColor': _$ColorEnumEnumMap[instance.highlightColor]!,
  'bookmarks': instance.bookmarks,
};

const _$BibleTranslationEnumMap = {BibleTranslation.kjv: 'kjv', BibleTranslation.asv: 'asv'};

const _$ColorEnumEnumMap = {
  ColorEnum.red: 'red',
  ColorEnum.orange: 'orange',
  ColorEnum.yellow: 'yellow',
  ColorEnum.green: 'green',
  ColorEnum.blue: 'blue',
  ColorEnum.violet: 'violet',
  ColorEnum.stone: 'stone',
};
