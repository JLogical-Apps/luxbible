// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Annotation _$AnnotationFromJson(Map<String, dynamic> json) => _Annotation(
  selections:
      (json['selections'] as List<dynamic>?)
          ?.map((e) => Selection.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  passages:
      (json['passages'] as List<dynamic>?)
          ?.map((e) => Passage.fromJson(e as String))
          .toList() ??
      const [],
  color:
      $enumDecodeNullable(_$ColorEnumEnumMap, json['color']) ?? ColorEnum.stone,
  note: json['note'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$AnnotationToJson(_Annotation instance) =>
    <String, dynamic>{
      'selections': instance.selections,
      'passages': instance.passages,
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
