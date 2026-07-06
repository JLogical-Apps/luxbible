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
    @Default(FontSizeSpacing.standard) FontSizeSpacing fontSizeSpacing,
    @Default(true) bool redLetters,
    @Default(SectionHeadings.all) @JsonKey(fromJson: _sectionHeadingsFromJson) SectionHeadings sections,
    @Default(true) bool verseNumbers,
    @Default(true) bool paragraphs,
    @Default(true) bool footnotes,
  }) = _ThemeLayoutConfiguration;

  factory ThemeLayoutConfiguration.fromJson(Map<String, dynamic> json) => _$ThemeLayoutConfigurationFromJson(json);
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
  dense,
  standard,
  comfort;

  String title() => switch (this) {
    dense => 'Dense',
    standard => 'Standard',
    comfort => 'Comfort',
  };

  String description() => switch (this) {
    dense => 'Smaller font size and spacing so more text can fit on your screen.',
    standard => 'Font size and spacing balanced for legibility and spacing.',
    comfort => 'Larger font size and spacing for enhanced legibility.',
  };

  double get multiplier => switch (this) {
    dense => 0.85,
    standard => 0.95,
    comfort => 1.1,
  };
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
