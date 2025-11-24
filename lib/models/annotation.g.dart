// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Annotation _$AnnotationFromJson(Map<String, dynamic> json) => _Annotation(
  selection: Selection.fromJson(json['selection'] as Map<String, dynamic>),
  color:
      $enumDecodeNullable(_$ColorEnumEnumMap, json['color']) ?? ColorEnum.stone,
  note: json['note'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$AnnotationToJson(_Annotation instance) =>
    <String, dynamic>{
      'selection': instance.selection,
      'color': _$ColorEnumEnumMap[instance.color]!,
      'note': instance.note,
      'createdAt': instance.createdAt.toIso8601String(),
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
