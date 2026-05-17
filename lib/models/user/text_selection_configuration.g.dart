// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_selection_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TextSelectionConfiguration _$TextSelectionConfigurationFromJson(
  Map<String, dynamic> json,
) => _TextSelectionConfiguration(
  pinnedShortcut1:
      $enumDecodeNullable(
        _$TextSelectionShortcutEnumMap,
        json['pinnedShortcut1'],
      ) ??
      TextSelectionShortcut.annotate,
  pinnedShortcut2:
      $enumDecodeNullable(
        _$TextSelectionShortcutEnumMap,
        json['pinnedShortcut2'],
      ) ??
      TextSelectionShortcut.search,
  pinnedShortcut3:
      $enumDecodeNullable(
        _$TextSelectionShortcutEnumMap,
        json['pinnedShortcut3'],
      ) ??
      TextSelectionShortcut.copy,
  expandToAnnotation: json['expandToAnnotation'] as bool? ?? false,
);

Map<String, dynamic> _$TextSelectionConfigurationToJson(
  _TextSelectionConfiguration instance,
) => <String, dynamic>{
  'pinnedShortcut1': _$TextSelectionShortcutEnumMap[instance.pinnedShortcut1]!,
  'pinnedShortcut2': _$TextSelectionShortcutEnumMap[instance.pinnedShortcut2]!,
  'pinnedShortcut3': _$TextSelectionShortcutEnumMap[instance.pinnedShortcut3]!,
  'expandToAnnotation': instance.expandToAnnotation,
};

const _$TextSelectionShortcutEnumMap = {
  TextSelectionShortcut.annotate: 'annotate',
  TextSelectionShortcut.highlight: 'highlight',
  TextSelectionShortcut.search: 'search',
  TextSelectionShortcut.copy: 'copy',
};
