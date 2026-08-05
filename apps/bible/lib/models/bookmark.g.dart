// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Bookmark _$BookmarkFromJson(Map<String, dynamic> json) => _Bookmark(
  position: ChapterPosition.fromJson(ChapterPositionFromReference.read(json, 'chapter') as Map<String, dynamic>),
  name: json['name'] as String,
  color: $enumDecodeNullable(_$ColorEnumEnumMap, json['color']) ?? ColorEnum.red,
);

Map<String, dynamic> _$BookmarkToJson(_Bookmark instance) => <String, dynamic>{
  'chapter': instance.position.toJson(),
  'name': instance.name,
  'color': _$ColorEnumEnumMap[instance.color]!,
};

const _$ColorEnumEnumMap = {
  ColorEnum.red: 'red',
  ColorEnum.orange: 'orange',
  ColorEnum.yellow: 'yellow',
  ColorEnum.green: 'green',
  ColorEnum.blue: 'blue',
  ColorEnum.violet: 'violet',
  ColorEnum.stone: 'stone',
};
