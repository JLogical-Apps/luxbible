// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlight_style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HighlightStyle _$HighlightStyleFromJson(Map<String, dynamic> json) => _HighlightStyle(
  color: $enumDecode(_$ColorEnumEnumMap, json['color']),
  type: $enumDecode(_$HighlightStyleTypeEnumMap, json['type']),
);

Map<String, dynamic> _$HighlightStyleToJson(_HighlightStyle instance) => <String, dynamic>{
  'color': _$ColorEnumEnumMap[instance.color]!,
  'type': _$HighlightStyleTypeEnumMap[instance.type]!,
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
