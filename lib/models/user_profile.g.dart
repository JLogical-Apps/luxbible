// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
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
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'translation': _$BibleTranslationEnumMap[instance.translation]!,
      'tabs': instance.tabs,
      'previouslyViewed': instance.previouslyViewed,
    };

const _$BibleTranslationEnumMap = {
  BibleTranslation.kjv: 'kjv',
  BibleTranslation.asv: 'asv',
};
