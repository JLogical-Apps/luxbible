// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_toolbar_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MainToolbarConfiguration _$MainToolbarConfigurationFromJson(
  Map<String, dynamic> json,
) => _MainToolbarConfiguration(
  pinnedShortcut1:
      $enumDecodeNullable(
        _$MainToolbarShortcutEnumMap,
        json['pinnedShortcut1'],
      ) ??
      MainToolbarShortcut.bookmark,
  pinnedShortcut2:
      $enumDecodeNullable(
        _$MainToolbarShortcutEnumMap,
        json['pinnedShortcut2'],
      ) ??
      MainToolbarShortcut.search,
  longPressShortcut:
      $enumDecodeNullable(
        _$MainToolbarShortcutEnumMap,
        json['longPressShortcut'],
      ) ??
      MainToolbarShortcut.studyPanel,
  swipeToUndo: json['swipeToUndo'] as bool? ?? true,
  pinToBottom: json['pinToBottom'] as bool? ?? false,
);

Map<String, dynamic> _$MainToolbarConfigurationToJson(
  _MainToolbarConfiguration instance,
) => <String, dynamic>{
  'pinnedShortcut1': _$MainToolbarShortcutEnumMap[instance.pinnedShortcut1]!,
  'pinnedShortcut2': _$MainToolbarShortcutEnumMap[instance.pinnedShortcut2]!,
  'longPressShortcut':
      _$MainToolbarShortcutEnumMap[instance.longPressShortcut]!,
  'swipeToUndo': instance.swipeToUndo,
  'pinToBottom': instance.pinToBottom,
};

const _$MainToolbarShortcutEnumMap = {
  MainToolbarShortcut.bookmark: 'bookmark',
  MainToolbarShortcut.study: 'study',
  MainToolbarShortcut.compare: 'compare',
  MainToolbarShortcut.interlinear: 'interlinear',
  MainToolbarShortcut.commentary: 'commentary',
  MainToolbarShortcut.crossReferences: 'crossReferences',
  MainToolbarShortcut.studyPanel: 'studyPanel',
  MainToolbarShortcut.switchBible: 'switchBible',
  MainToolbarShortcut.search: 'search',
  MainToolbarShortcut.resources: 'resources',
  MainToolbarShortcut.dictionary: 'dictionary',
  MainToolbarShortcut.lexicon: 'lexicon',
  MainToolbarShortcut.themeAndLayout: 'themeAndLayout',
};
