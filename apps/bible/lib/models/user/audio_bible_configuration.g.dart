// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_bible_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AudioBibleConfiguration _$AudioBibleConfigurationFromJson(
  Map<String, dynamic> json,
) => _AudioBibleConfiguration(
  isOpen: json['isOpen'] as bool? ?? false,
  speed: (json['speed'] as num?)?.toDouble() ?? 1,
  followAlong: json['followAlong'] as bool? ?? true,
  endTime: json['endTime'] == null
      ? null
      : DateTime.parse(json['endTime'] as String),
);

Map<String, dynamic> _$AudioBibleConfigurationToJson(
  _AudioBibleConfiguration instance,
) => <String, dynamic>{
  'isOpen': instance.isOpen,
  'speed': instance.speed,
  'followAlong': instance.followAlong,
  'endTime': instance.endTime?.toIso8601String(),
};
