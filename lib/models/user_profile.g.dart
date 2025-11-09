// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
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
      'tabs': instance.tabs,
      'previouslyViewed': instance.previouslyViewed,
    };
