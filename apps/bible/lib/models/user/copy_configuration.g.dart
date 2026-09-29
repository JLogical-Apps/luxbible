// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'copy_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CopyConfiguration _$CopyConfigurationFromJson(Map<String, dynamic> json) =>
    _CopyConfiguration(
      includesReference: json['includesReference'] as bool? ?? false,
      includesTranslation: json['includesTranslation'] as bool? ?? false,
    );

Map<String, dynamic> _$CopyConfigurationToJson(_CopyConfiguration instance) =>
    <String, dynamic>{
      'includesReference': instance.includesReference,
      'includesTranslation': instance.includesTranslation,
    };
