// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annotation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Annotation _$AnnotationFromJson(Map<String, dynamic> json) => _Annotation(
  selection: AnnotationSelection.fromJson(_readAnnotationSelection(json, 'selection') as Map<String, dynamic>),
  style: _readHighlightStyle(json, 'style') == null
      ? HighlightStyle.fallback
      : HighlightStyle.fromJson(_readHighlightStyle(json, 'style') as Map<String, dynamic>),
  note: json['note'] as String? ?? '',
  notebookId: json['notebookId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$AnnotationToJson(_Annotation instance) => <String, dynamic>{
  'selection': instance.selection.toJson(),
  'style': instance.style.toJson(),
  'note': instance.note,
  'notebookId': instance.notebookId,
  'createdAt': instance.createdAt.toIso8601String(),
};

VersesAnnotationSelection _$VersesAnnotationSelectionFromJson(Map<String, dynamic> json) => VersesAnnotationSelection(
  verseSelection: VerseSelection.fromJson(json['verseSelection'] as String),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$VersesAnnotationSelectionToJson(VersesAnnotationSelection instance) => <String, dynamic>{
  'verseSelection': instance.verseSelection.toJson(),
  'runtimeType': instance.$type,
};

TextAnnotationSelection _$TextAnnotationSelectionFromJson(Map<String, dynamic> json) => TextAnnotationSelection(
  textSelection: BibleTextSelection.fromJson(json['textSelection'] as Map<String, dynamic>),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$TextAnnotationSelectionToJson(TextAnnotationSelection instance) => <String, dynamic>{
  'textSelection': instance.textSelection.toJson(),
  'runtimeType': instance.$type,
};
