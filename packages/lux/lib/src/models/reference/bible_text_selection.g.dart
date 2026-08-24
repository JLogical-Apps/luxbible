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
      'start': instance.start,
      'end': instance.end,
      'translation': _$BibleTranslationEnumMap[instance.translation]!,
    };

const _$BibleTranslationEnumMap = {
  BibleTranslation.bsb: 'bsb',
  BibleTranslation.nasb95: 'nasb95',
  BibleTranslation.niv11: 'niv11',
  BibleTranslation.csb: 'csb',
  BibleTranslation.nlt: 'nlt',
  BibleTranslation.nkjv: 'nkjv',
  BibleTranslation.kjv: 'kjv',
  BibleTranslation.asv: 'asv',
  BibleTranslation.lxx: 'lxx',
  BibleTranslation.tr: 'tr',
  BibleTranslation.byz: 'byz',
  BibleTranslation.statresgnt: 'statresgnt',
  BibleTranslation.oshb: 'oshb',
  BibleTranslation.sv: 'sv',
  BibleTranslation.nrt: 'nrt',
  BibleTranslation.fob: 'fob',
  BibleTranslation.martin1744: 'martin1744',
  BibleTranslation.rvg: 'rvg',
};
