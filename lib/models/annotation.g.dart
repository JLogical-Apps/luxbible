// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Annotation _$AnnotationFromJson(Map<String, dynamic> json) => _Annotation(
  textSelections:
      (json['textSelections'] as List<dynamic>?)
          ?.map((e) => BibleTextSelection.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  verseSelections:
      (json['verseSelections'] as List<dynamic>?)
          ?.map((e) => VerseSelection.fromJson(e as String))
          .toList() ??
      const [],
  color:
      $enumDecodeNullable(_$ColorEnumEnumMap, json['color']) ?? ColorEnum.stone,
  note: json['note'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$AnnotationToJson(_Annotation instance) =>
    <String, dynamic>{
      'textSelections': instance.textSelections,
      'verseSelections': instance.verseSelections,
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
