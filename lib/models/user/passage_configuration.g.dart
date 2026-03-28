// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passage_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PassageConfiguration _$PassageConfigurationFromJson(
  Map<String, dynamic> json,
) => _PassageConfiguration(
  pinnedShortcut1:
      $enumDecodeNullable(_$PassageShortcutEnumMap, json['pinnedShortcut1']) ??
      PassageShortcut.annotate,
  pinnedShortcut2:
      $enumDecodeNullable(_$PassageShortcutEnumMap, json['pinnedShortcut2']) ??
      PassageShortcut.commentary,
  pinnedShortcut3:
      $enumDecodeNullable(_$PassageShortcutEnumMap, json['pinnedShortcut3']) ??
      PassageShortcut.interlinear,
  expandToAnnotation: json['expandToAnnotation'] as bool? ?? false,
);

Map<String, dynamic> _$PassageConfigurationToJson(
  _PassageConfiguration instance,
) => <String, dynamic>{
  'pinnedShortcut1': _$PassageShortcutEnumMap[instance.pinnedShortcut1]!,
  'pinnedShortcut2': _$PassageShortcutEnumMap[instance.pinnedShortcut2]!,
  'pinnedShortcut3': _$PassageShortcutEnumMap[instance.pinnedShortcut3]!,
  'expandToAnnotation': instance.expandToAnnotation,
};

const _$PassageShortcutEnumMap = {
  PassageShortcut.study: 'study',
  PassageShortcut.compare: 'compare',
  PassageShortcut.interlinear: 'interlinear',
  PassageShortcut.commentary: 'commentary',
  PassageShortcut.crossReferences: 'crossReferences',
  PassageShortcut.annotate: 'annotate',
  PassageShortcut.highlight: 'highlight',
  PassageShortcut.copy: 'copy',
};
