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
  fontSizeSpacing: FontSizeSpacing.fromJsonNullable(json['fontSizeSpacing']),
  hebrewFontSizeSpacing: FontSizeSpacing.fromJsonNullable(
    json['hebrewFontSizeSpacing'],
  ),
  greekFontSizeSpacing: FontSizeSpacing.fromJsonNullable(
    json['greekFontSizeSpacing'],
  ),
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
  'fontSizeSpacing': _$FontSizeSpacingEnumMap[instance.fontSizeSpacing],
  'hebrewFontSizeSpacing':
      _$FontSizeSpacingEnumMap[instance.hebrewFontSizeSpacing],
  'greekFontSizeSpacing':
      _$FontSizeSpacingEnumMap[instance.greekFontSizeSpacing],
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
  FontSizeSpacing.extraTiny: 'extraTiny',
  FontSizeSpacing.tiny: 'tiny',
  FontSizeSpacing.small: 'small',
  FontSizeSpacing.standard: 'standard',
  FontSizeSpacing.large: 'large',
  FontSizeSpacing.huge: 'huge',
  FontSizeSpacing.extraHuge: 'extraHuge',
};

const _$SectionHeadingsEnumMap = {
  SectionHeadings.all: 'all',
  SectionHeadings.native: 'native',
  SectionHeadings.none: 'none',
};
