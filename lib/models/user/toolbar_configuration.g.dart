// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toolbar_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ToolbarConfiguration _$ToolbarConfigurationFromJson(
  Map<String, dynamic> json,
) => _ToolbarConfiguration(
  pinnedShortcut1:
      $enumDecodeNullable(_$ToolbarShortcutEnumMap, json['pinnedShortcut1']) ??
      ToolbarShortcut.bookmark,
  pinnedShortcut2:
      $enumDecodeNullable(_$ToolbarShortcutEnumMap, json['pinnedShortcut2']) ??
      ToolbarShortcut.interlinear,
  longPressShortcut:
      $enumDecodeNullable(
        _$ToolbarShortcutEnumMap,
        json['longPressShortcut'],
      ) ??
      ToolbarShortcut.study,
);

Map<String, dynamic> _$ToolbarConfigurationToJson(
  _ToolbarConfiguration instance,
) => <String, dynamic>{
  'pinnedShortcut1': _$ToolbarShortcutEnumMap[instance.pinnedShortcut1]!,
  'pinnedShortcut2': _$ToolbarShortcutEnumMap[instance.pinnedShortcut2]!,
  'longPressShortcut': _$ToolbarShortcutEnumMap[instance.longPressShortcut]!,
};

const _$ToolbarShortcutEnumMap = {
  ToolbarShortcut.bookmark: 'bookmark',
  ToolbarShortcut.study: 'study',
  ToolbarShortcut.compare: 'compare',
  ToolbarShortcut.interlinear: 'interlinear',
  ToolbarShortcut.commentary: 'commentary',
};
