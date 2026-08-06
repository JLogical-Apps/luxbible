// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  theme:
      $enumDecodeNullable(_$ThemeModeEnumMap, json['theme']) ??
      ThemeMode.system,
  passages:
      (json['passages'] as List<dynamic>?)
          ?.map((e) => VerseSelection.fromJson(e as String))
          .toList() ??
      const [],
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'theme': _$ThemeModeEnumMap[instance.theme]!,
  'passages': instance.passages.map((e) => e.toJson()).toList(),
};

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
