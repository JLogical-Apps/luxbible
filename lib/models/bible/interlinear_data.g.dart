// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interlinear_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InterlinearData _$InterlinearDataFromJson(Map<String, dynamic> json) =>
    _InterlinearData(
      originalPosition: (json['o'] as num).toInt(),
      inflection: json['i'] as String?,
      strongId: json['s'] as String?,
      morphology: json['m'] as String?,
    );

Map<String, dynamic> _$InterlinearDataToJson(_InterlinearData instance) =>
    <String, dynamic>{
      'o': instance.originalPosition,
      'i': ?instance.inflection,
      's': ?instance.strongId,
      'm': ?instance.morphology,
    };
