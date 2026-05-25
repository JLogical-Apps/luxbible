// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Annotation _$AnnotationFromJson(Map<String, dynamic> json) => _Annotation(
  selection: AnnotationSelection.fromJson(
    _annotationSelectionFromAnnotation(json, 'selection')
        as Map<String, dynamic>,
  ),
  color:
      $enumDecodeNullable(_$ColorEnumEnumMap, json['color']) ?? ColorEnum.stone,
  note: json['note'] as String? ?? '',
);

Map<String, dynamic> _$AnnotationToJson(_Annotation instance) =>
    <String, dynamic>{
      'selection': instance.selection.toJson(),
      'color': _$ColorEnumEnumMap[instance.color]!,
      'note': instance.note,
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

VersesAnnotationSelection _$VersesAnnotationSelectionFromJson(
  Map<String, dynamic> json,
) => VersesAnnotationSelection(
  verseSelection: VerseSelection.fromJson(json['verseSelection'] as String),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$VersesAnnotationSelectionToJson(
  VersesAnnotationSelection instance,
) => <String, dynamic>{
  'verseSelection': instance.verseSelection.toJson(),
  'runtimeType': instance.$type,
};

TextAnnotationSelection _$TextAnnotationSelectionFromJson(
  Map<String, dynamic> json,
) => TextAnnotationSelection(
  textSelection: BibleTextSelection.fromJson(
    json['textSelection'] as Map<String, dynamic>,
  ),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$TextAnnotationSelectionToJson(
  TextAnnotationSelection instance,
) => <String, dynamic>{
  'textSelection': instance.textSelection.toJson(),
  'runtimeType': instance.$type,
};
