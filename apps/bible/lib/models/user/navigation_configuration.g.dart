// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NavigationConfiguration _$NavigationConfigurationFromJson(
  Map<String, dynamic> json,
) => _NavigationConfiguration(
  layout:
      $enumDecodeNullable(_$NavigationLayoutEnumMap, json['layout']) ??
      NavigationLayout.list,
  showsRecents: json['showsRecents'] as bool? ?? true,
  opensKeyboard: json['opensKeyboard'] as bool? ?? true,
);

Map<String, dynamic> _$NavigationConfigurationToJson(
  _NavigationConfiguration instance,
) => <String, dynamic>{
  'layout': _$NavigationLayoutEnumMap[instance.layout]!,
  'showsRecents': instance.showsRecents,
  'opensKeyboard': instance.opensKeyboard,
};

const _$NavigationLayoutEnumMap = {
  NavigationLayout.list: 'list',
  NavigationLayout.grid: 'grid',
};
