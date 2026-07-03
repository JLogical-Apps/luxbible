// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_selection_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VerseSelectionConfiguration _$VerseSelectionConfigurationFromJson(
  Map<String, dynamic> json,
) => _VerseSelectionConfiguration(
  pinnedShortcut1:
      $enumDecodeNullable(
        _$VerseSelectionShortcutEnumMap,
        json['pinnedShortcut1'],
      ) ??
      VerseSelectionShortcut.annotate,
  pinnedShortcut2:
      $enumDecodeNullable(
        _$VerseSelectionShortcutEnumMap,
        json['pinnedShortcut2'],
      ) ??
      VerseSelectionShortcut.commentary,
  pinnedShortcut3:
      $enumDecodeNullable(
        _$VerseSelectionShortcutEnumMap,
        json['pinnedShortcut3'],
      ) ??
      VerseSelectionShortcut.compare,
  longPressShortcut:
      $enumDecodeNullable(
        _$VerseSelectionShortcutEnumMap,
        json['longPressShortcut'],
      ) ??
      VerseSelectionShortcut.highlight,
  expandToAnnotation: json['expandToAnnotation'] as bool? ?? false,
  rangeSelection: json['rangeSelection'] as bool? ?? true,
);

Map<String, dynamic> _$VerseSelectionConfigurationToJson(
  _VerseSelectionConfiguration instance,
) => <String, dynamic>{
  'pinnedShortcut1': _$VerseSelectionShortcutEnumMap[instance.pinnedShortcut1]!,
  'pinnedShortcut2': _$VerseSelectionShortcutEnumMap[instance.pinnedShortcut2]!,
  'pinnedShortcut3': _$VerseSelectionShortcutEnumMap[instance.pinnedShortcut3]!,
  'longPressShortcut':
      _$VerseSelectionShortcutEnumMap[instance.longPressShortcut]!,
  'expandToAnnotation': instance.expandToAnnotation,
  'rangeSelection': instance.rangeSelection,
};

const _$VerseSelectionShortcutEnumMap = {
  VerseSelectionShortcut.study: 'study',
  VerseSelectionShortcut.compare: 'compare',
  VerseSelectionShortcut.interlinear: 'interlinear',
  VerseSelectionShortcut.commentary: 'commentary',
  VerseSelectionShortcut.crossReferences: 'crossReferences',
  VerseSelectionShortcut.annotate: 'annotate',
  VerseSelectionShortcut.highlight: 'highlight',
  VerseSelectionShortcut.copy: 'copy',
};
