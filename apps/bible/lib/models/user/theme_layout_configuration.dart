import 'dart:math';

import 'package:lux/lux.dart';
import 'package:lux/i18n.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_layout_configuration.freezed.dart';
part 'theme_layout_configuration.g.dart';

@freezed
sealed class ThemeLayoutConfiguration with _$ThemeLayoutConfiguration {
  const ThemeLayoutConfiguration._();

  const factory ThemeLayoutConfiguration({
    @Default(ThemeFont.inter) ThemeFont font,
    @JsonKey(fromJson: FontSizeSpacing.fromJsonNullable) FontSizeSpacing? fontSizeSpacing,
    @JsonKey(fromJson: FontSizeSpacing.fromJsonNullable) FontSizeSpacing? hebrewFontSizeSpacing,
    @JsonKey(fromJson: FontSizeSpacing.fromJsonNullable) FontSizeSpacing? greekFontSizeSpacing,
    @Default(true) bool redLetters,
    @Default(SectionHeadings.all) @JsonKey(fromJson: _sectionHeadingsFromJson) SectionHeadings sections,
    @Default(true) bool verseNumbers,
    @Default(true) bool paragraphs,
    @Default(true) bool footnotes,
  }) = _ThemeLayoutConfiguration;

  factory ThemeLayoutConfiguration.fromJson(Map<String, dynamic> json) => _$ThemeLayoutConfigurationFromJson(json);

  FontSizeSpacing getFontSizeSpacingOrSystem(double textScaling) =>
      fontSizeSpacing ?? FontSizeSpacing.closestTo(textScaling);

  FontSizeSpacing getFontSizeSpacingFor(BibleLanguage language, double textScaling) => switch (language) {
    .greek => greekFontSizeSpacing ?? getFontSizeSpacingOrSystem(textScaling),
    .hebrew => hebrewFontSizeSpacing ?? getFontSizeSpacingOrSystem(textScaling),
    _ => getFontSizeSpacingOrSystem(textScaling),
  };
}

enum ThemeFont {
  inter,
  lora,
  merriweather,
  ptSerif,
  openSans,
  lato,
  openDyslexic;

  String title() => switch (this) {
    inter => 'Inter',
    lora => 'Lora',
    merriweather => 'Merriweather',
    ptSerif => 'PT Serif',
    openSans => 'Open Sans',
    lato => 'Lato',
    openDyslexic => 'OpenDyslexic',
  };

  String get fontFamily => switch (this) {
    inter => 'Inter',
    lora => 'Lora',
    merriweather => 'Merriweather',
    ptSerif => 'PTSerif',
    openSans => 'OpenSans',
    lato => 'Lato',
    openDyslexic => 'OpenDyslexic',
  };
}

enum FontSizeSpacing {
  extraTiny,
  tiny,
  small,
  standard,
  large,
  huge,
  extraHuge;

  static FontSizeSpacing fromJson(Object? json) => switch (json) {
    'dense' => .tiny,
    'comfort' => .huge,
    String value => values.byName(value),
    _ => .standard,
  };

  static FontSizeSpacing? fromJsonNullable(Object? json) => json == null ? null : fromJson(json);

  static FontSizeSpacing closestTo(double multiplier) => values.minBy((value) => (value.multiplier - multiplier).abs());

  String title() => switch (this) {
    extraTiny => t.themeOptions.extraTiny,
    tiny => t.themeOptions.tiny,
    small => t.themeOptions.small,
    standard => t.themeOptions.standard,
    large => t.themeOptions.large,
    huge => t.themeOptions.huge,
    extraHuge => t.themeOptions.extraHuge,
  };

  double get multiplier => pow(1.09, index - standard.index).toDouble();

  FontSizeSpacing? get previous => this == extraTiny ? null : values[index - 1];
  FontSizeSpacing? get next => this == extraHuge ? null : values[index + 1];
}

enum SectionHeadings {
  all,
  native,
  none;

  String title() => switch (this) {
    all => t.themeOptions.nativeAndSynthetic,
    native => t.themeOptions.native,
    none => t.themeOptions.none,
  };

  String description() => switch (this) {
    all => t.themeOptions.allHeadingsDescription,
    native => t.themeOptions.nativeHeadingsDescription,
    none => t.themeOptions.noHeadingsDescription,
  };

  bool showFor({required BibleTranslation translation, required SectionType sectionType}) =>
      sectionType == .s1 || sectionType == .s2
      ? switch (this) {
          all => true,
          native => translation.hasNativeHeadings,
          none => false,
        }
      : true;
}

SectionHeadings _sectionHeadingsFromJson(dynamic json) {
  if (json is bool) {
    return json ? .all : .none;
  } else if (json is SectionHeadings) {
    return json;
  } else {
    return .all;
  }
}
