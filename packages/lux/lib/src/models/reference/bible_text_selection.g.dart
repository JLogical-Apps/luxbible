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
  BibleTranslation.htb: 'htb',
  BibleTranslation.nld1939: 'nld1939',
  BibleTranslation.sv: 'sv',
  BibleTranslation.amp: 'amp',
  BibleTranslation.asv: 'asv',
  BibleTranslation.bsb: 'bsb',
  BibleTranslation.csb: 'csb',
  BibleTranslation.kjv: 'kjv',
  BibleTranslation.msb: 'msb',
  BibleTranslation.nasb95: 'nasb95',
  BibleTranslation.niv11: 'niv11',
  BibleTranslation.nkjv: 'nkjv',
  BibleTranslation.nlt: 'nlt',
  BibleTranslation.web: 'web',
  BibleTranslation.fob: 'fob',
  BibleTranslation.martin1744: 'martin1744',
  BibleTranslation.elb1905: 'elb1905',
  BibleTranslation.hfa: 'hfa',
  BibleTranslation.lut1912: 'lut1912',
  BibleTranslation.byz: 'byz',
  BibleTranslation.lxx: 'lxx',
  BibleTranslation.statresgnt: 'statresgnt',
  BibleTranslation.tr: 'tr',
  BibleTranslation.oshb: 'oshb',
  BibleTranslation.ntr: 'ntr',
  BibleTranslation.nrt: 'nrt',
  BibleTranslation.synodal: 'synodal',
  BibleTranslation.rvg: 'rvg',
  BibleTranslation.tglulb: 'tglulb',
};
