// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassageSelection _$PassageSelectionFromJson(Map<String, dynamic> json) =>
    PassageSelection(
      passage: Passage.fromJson(json['passage'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$PassageSelectionToJson(PassageSelection instance) =>
    <String, dynamic>{
      'passage': instance.passage,
      'runtimeType': instance.$type,
    };

WordsSelection _$WordsSelectionFromJson(Map<String, dynamic> json) =>
    WordsSelection(
      start: SelectionWordAnchor.fromJson(json['start'] as String),
      end: SelectionWordAnchor.fromJson(json['end'] as String),
      translation: $enumDecode(_$BibleTranslationEnumMap, json['translation']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$WordsSelectionToJson(WordsSelection instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'translation': _$BibleTranslationEnumMap[instance.translation]!,
      'runtimeType': instance.$type,
    };

const _$BibleTranslationEnumMap = {
  BibleTranslation.kjv: 'kjv',
  BibleTranslation.asv: 'asv',
};
