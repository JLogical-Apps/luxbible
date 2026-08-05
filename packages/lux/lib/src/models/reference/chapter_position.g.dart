// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChapterPosition _$ChapterPositionFromJson(Map<String, dynamic> json) => _ChapterPosition(
  reference: ChapterReference.fromJson(json['reference'] as String),
  scrollPercent: (json['scrollPercent'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$ChapterPositionToJson(_ChapterPosition instance) => <String, dynamic>{
  'reference': instance.reference,
  'scrollPercent': instance.scrollPercent,
};
