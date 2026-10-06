// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Video _$VideoFromJson(Map<String, dynamic> json) => _Video(
  id: json['i'] as String,
  title: json['t'] as String,
  durationSeconds: (json['d'] as num).toInt(),
  muxPlaybackId: json['m'] as String,
  thumbnailUrl: json['u'] as String,
  passages:
      (json['p'] as List<dynamic>?)
          ?.map((e) => VerseSelection.fromJson(e as String))
          .toList() ??
      const [],
);

Map<String, dynamic> _$VideoToJson(_Video instance) => <String, dynamic>{
  'i': instance.id,
  't': instance.title,
  'd': instance.durationSeconds,
  'm': instance.muxPlaybackId,
  'u': instance.thumbnailUrl,
  'p': ?nullIfEmpty(instance.passages),
};

_VideoCollection _$VideoCollectionFromJson(Map<String, dynamic> json) =>
    _VideoCollection(
      title: json['t'] as String,
      videos: (json['v'] as List<dynamic>)
          .map((e) => Video.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VideoCollectionToJson(_VideoCollection instance) =>
    <String, dynamic>{
      't': instance.title,
      'v': instance.videos.map((e) => e.toJson()).toList(),
    };
