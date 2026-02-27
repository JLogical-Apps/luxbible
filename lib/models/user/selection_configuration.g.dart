// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selection_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SelectionConfiguration _$SelectionConfigurationFromJson(
  Map<String, dynamic> json,
) => _SelectionConfiguration(
  pinnedShortcut1:
      $enumDecodeNullable(
        _$SelectionShortcutEnumMap,
        json['pinnedShortcut1'],
      ) ??
      SelectionShortcut.annotate,
  pinnedShortcut2:
      $enumDecodeNullable(
        _$SelectionShortcutEnumMap,
        json['pinnedShortcut2'],
      ) ??
      SelectionShortcut.copy,
);

Map<String, dynamic> _$SelectionConfigurationToJson(
  _SelectionConfiguration instance,
) => <String, dynamic>{
  'pinnedShortcut1': _$SelectionShortcutEnumMap[instance.pinnedShortcut1]!,
  'pinnedShortcut2': _$SelectionShortcutEnumMap[instance.pinnedShortcut2]!,
};

const _$SelectionShortcutEnumMap = {
  SelectionShortcut.annotate: 'annotate',
  SelectionShortcut.copy: 'copy',
};
