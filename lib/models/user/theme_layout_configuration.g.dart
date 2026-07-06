// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_layout_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ThemeLayoutConfiguration _$ThemeLayoutConfigurationFromJson(
  Map<String, dynamic> json,
) => _ThemeLayoutConfiguration(
  font:
      $enumDecodeNullable(_$ThemeFontEnumMap, json['font']) ?? ThemeFont.inter,
  fontSizeSpacing:
      $enumDecodeNullable(_$FontSizeSpacingEnumMap, json['fontSizeSpacing']) ??
      FontSizeSpacing.standard,
  redLetters: json['redLetters'] as bool? ?? true,
  sections: json['sections'] == null
      ? SectionHeadings.all
      : _sectionHeadingsFromJson(json['sections']),
  verseNumbers: json['verseNumbers'] as bool? ?? true,
  paragraphs: json['paragraphs'] as bool? ?? true,
  footnotes: json['footnotes'] as bool? ?? true,
);

Map<String, dynamic> _$ThemeLayoutConfigurationToJson(
  _ThemeLayoutConfiguration instance,
) => <String, dynamic>{
  'font': _$ThemeFontEnumMap[instance.font]!,
  'fontSizeSpacing': _$FontSizeSpacingEnumMap[instance.fontSizeSpacing]!,
  'redLetters': instance.redLetters,
  'sections': _$SectionHeadingsEnumMap[instance.sections]!,
  'verseNumbers': instance.verseNumbers,
  'paragraphs': instance.paragraphs,
  'footnotes': instance.footnotes,
};

const _$ThemeFontEnumMap = {
  ThemeFont.inter: 'inter',
  ThemeFont.lora: 'lora',
  ThemeFont.merriweather: 'merriweather',
  ThemeFont.ptSerif: 'ptSerif',
  ThemeFont.openSans: 'openSans',
  ThemeFont.lato: 'lato',
  ThemeFont.openDyslexic: 'openDyslexic',
};

const _$FontSizeSpacingEnumMap = {
  FontSizeSpacing.dense: 'dense',
  FontSizeSpacing.standard: 'standard',
  FontSizeSpacing.comfort: 'comfort',
};

const _$SectionHeadingsEnumMap = {
  SectionHeadings.all: 'all',
  SectionHeadings.native: 'native',
  SectionHeadings.none: 'none',
};
