// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlight_style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HighlightStyle _$HighlightStyleFromJson(Map<String, dynamic> json) =>
    _HighlightStyle(
      color: $enumDecode(_$ColorEnumEnumMap, json['color']),
      type: $enumDecode(_$HighlightStyleTypeEnumMap, json['type']),
      icon: $enumDecodeNullable(_$HighlightIconEnumMap, json['icon']),
    );

Map<String, dynamic> _$HighlightStyleToJson(_HighlightStyle instance) =>
    <String, dynamic>{
      'color': _$ColorEnumEnumMap[instance.color]!,
      'type': _$HighlightStyleTypeEnumMap[instance.type]!,
      'icon': _$HighlightIconEnumMap[instance.icon],
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

const _$HighlightStyleTypeEnumMap = {
  HighlightStyleType.highlight: 'highlight',
  HighlightStyleType.straightUnderline: 'straightUnderline',
  HighlightStyleType.wavyUnderline: 'wavyUnderline',
};

const _$HighlightIconEnumMap = {
  HighlightIcon.heart: 'heart',
  HighlightIcon.star: 'star',
  HighlightIcon.lightbulb: 'lightbulb',
  HighlightIcon.question: 'question',
  HighlightIcon.exclamation: 'exclamation',
  HighlightIcon.key: 'key',
  HighlightIcon.flag: 'flag',
  HighlightIcon.quote: 'quote',
  HighlightIcon.command: 'command',
  HighlightIcon.prayer: 'prayer',
  HighlightIcon.crown: 'crown',
  HighlightIcon.church: 'church',
  HighlightIcon.fire: 'fire',
  HighlightIcon.water: 'water',
  HighlightIcon.leaf: 'leaf',
  HighlightIcon.sun: 'sun',
  HighlightIcon.music: 'music',
  HighlightIcon.person: 'person',
  HighlightIcon.place: 'place',
  HighlightIcon.time: 'time',
};
