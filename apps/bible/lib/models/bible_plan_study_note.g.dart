// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_plan_study_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BiblePlanStudyNote _$BiblePlanStudyNoteFromJson(Map<String, dynamic> json) =>
    _BiblePlanStudyNote(
      title: json['t'] as String,
      body: (json['b'] as List<dynamic>)
          .map((e) => RichContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BiblePlanStudyNoteToJson(_BiblePlanStudyNote instance) =>
    <String, dynamic>{
      't': instance.title,
      'b': instance.body.map((e) => e.toJson()).toList(),
    };
