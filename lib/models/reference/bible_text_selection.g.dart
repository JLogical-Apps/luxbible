// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_text_selection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BibleTextSelection _$BibleTextSelectionFromJson(Map<String, dynamic> json) =>
    _BibleTextSelection(
      start: BibleTextSelectionWordAnchor.fromJson(json['start'] as String),
      end: BibleTextSelectionWordAnchor.fromJson(json['end'] as String),
      translation: $enumDecode(_$BibleTranslationEnumMap, json['translation']),
    );

Map<String, dynamic> _$BibleTextSelectionToJson(_BibleTextSelection instance) =>
    <String, dynamic>{
      'start': instance.start.toJson(),
      'end': instance.end.toJson(),
      'translation': _$BibleTranslationEnumMap[instance.translation]!,
    };

const _$BibleTranslationEnumMap = {
  BibleTranslation.bsb: 'bsb',
  BibleTranslation.nasb95: 'nasb95',
  BibleTranslation.niv: 'niv',
  BibleTranslation.kjv: 'kjv',
  BibleTranslation.asv: 'asv',
};
