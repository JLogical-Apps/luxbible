// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notebook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Notebook _$NotebookFromJson(Map<String, dynamic> json) => _Notebook(
  id: json['id'] as String,
  name: json['name'] as String,
  color:
      $enumDecodeNullable(_$ColorEnumEnumMap, json['color']) ?? ColorEnum.stone,
);

Map<String, dynamic> _$NotebookToJson(_Notebook instance) => <String, dynamic>{
  'id': instance.id,
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
