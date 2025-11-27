// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Selection _$SelectionFromJson(Map<String, dynamic> json) => _Selection(
  start: SelectionWordAnchor.fromJson(json['start'] as String),
  end: SelectionWordAnchor.fromJson(json['end'] as String),
  translation: $enumDecode(_$BibleTranslationEnumMap, json['translation']),
);

Map<String, dynamic> _$SelectionToJson(_Selection instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'translation': _$BibleTranslationEnumMap[instance.translation]!,
    };

const _$BibleTranslationEnumMap = {
  BibleTranslation.kjv: 'kjv',
  BibleTranslation.asv: 'asv',
};
