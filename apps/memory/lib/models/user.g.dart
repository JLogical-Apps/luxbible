// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  theme:
      $enumDecodeNullable(_$ThemeModeEnumMap, json['theme']) ??
      ThemeMode.system,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'theme': _$ThemeModeEnumMap[instance.theme]!,
};

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
