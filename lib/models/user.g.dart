// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  translation:
      $enumDecodeNullable(_$BibleTranslationEnumMap, json['translation']) ??
      BibleTranslation.asv,
  tabs:
      (json['tabs'] as List<dynamic>?)
          ?.map((e) => ChapterReference.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  previouslyViewed:
      (json['previouslyViewed'] as List<dynamic>?)
          ?.map((e) => ChapterReference.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  highlightedReferences:
      (json['highlightedReferences'] as List<dynamic>?)
          ?.map((e) => Reference.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'translation': _$BibleTranslationEnumMap[instance.translation]!,
  'tabs': instance.tabs,
  'previouslyViewed': instance.previouslyViewed,
  'highlightedReferences': instance.highlightedReferences,
};

const _$BibleTranslationEnumMap = {
  BibleTranslation.kjv: 'kjv',
  BibleTranslation.asv: 'asv',
};
