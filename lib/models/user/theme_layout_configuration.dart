import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_layout_configuration.freezed.dart';
part 'theme_layout_configuration.g.dart';

@freezed
sealed class ThemeLayoutConfiguration with _$ThemeLayoutConfiguration {
  const ThemeLayoutConfiguration._();

  const factory ThemeLayoutConfiguration({
    @Default(ThemeFont.inter) ThemeFont font,
    @Default(FontSizeSpacing.standard) @JsonKey(fromJson: FontSizeSpacing.fromJson) FontSizeSpacing fontSizeSpacing,
    @JsonKey(fromJson: FontSizeSpacing.fromJsonNullable) FontSizeSpacing? hebrewFontSizeSpacing,
    @JsonKey(fromJson: FontSizeSpacing.fromJsonNullable) FontSizeSpacing? greekFontSizeSpacing,
    @Default(true) bool redLetters,
    @Default(SectionHeadings.all) @JsonKey(fromJson: _sectionHeadingsFromJson) SectionHeadings sections,
    @Default(true) bool verseNumbers,
    @Default(true) bool paragraphs,
    @Default(true) bool footnotes,
  }) = _ThemeLayoutConfiguration;

  factory ThemeLayoutConfiguration.fromJson(Map<String, dynamic> json) => _$ThemeLayoutConfigurationFromJson(json);

  FontSizeSpacing getFontSizeSpacingFor(BibleLanguage language) => switch (language) {
    .greek => greekFontSizeSpacing ?? fontSizeSpacing,
    .hebrew => hebrewFontSizeSpacing ?? fontSizeSpacing,
    _ => fontSizeSpacing,
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

  String title() => switch (this) {
    extraTiny => 'Extra Tiny',
    tiny => 'Tiny',
    small => 'Small',
    standard => 'Standard',
    large => 'Large',
    huge => 'Huge',
    extraHuge => 'Extra Huge',
  };

  double get multiplier => switch (this) {
    extraTiny => 0.8,
    tiny => 0.85,
    small => 0.9,
    standard => 0.95,
    large => 1.025,
    huge => 1.1,
    extraHuge => 1.175,
  };

  FontSizeSpacing? get previous => this == extraTiny ? null : values[index - 1];
  FontSizeSpacing? get next => this == extraHuge ? null : values[index + 1];
}

enum SectionHeadings {
  all,
  native,
  none;

  String title() => switch (this) {
    all => 'Native & Synthetic',
    native => 'Native',
    none => 'None',
  };

  String description() => switch (this) {
    all =>
      'Show headings in translations that support them, and synthetically insert BSB\'s section headings into English translations without them natively.',
    native => 'Show headings in translations that support them.',
    none => 'Do not show section headings',
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
