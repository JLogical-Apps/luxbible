import 'dart:ui';

import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';

enum Language {
  english,
  dutch,
  russian;

  static Language fromLocale(Locale locale) => switch (locale.languageCode.toLowerCase()) {
    'nl' => .dutch,
    'ru' => .russian,
    _ => .english,
  };

  static Language get device => fromLocale(PlatformDispatcher.instance.locale);

  AppLocale get appLocale => switch (this) {
    english => .en,
    dutch => .nl,
    russian => .ru,
  };

  String get code => appLocale.languageCode;

  String get nativeTitle => switch (this) {
    english => 'English',
    dutch => 'Nederlands',
    russian => 'Русский',
  };

  String title() => switch (this) {
    english => t.languages.english,
    dutch => t.languages.dutch,
    russian => t.languages.russian,
  };
}

List<BibleTranslation> getDefaultBibleTranslations(Language language) => switch (language) {
  .english => [
    .bsb,
    ...BibleTranslation.values.where(
      (translation) => translation != .bsb && translation.bibleLanguage.appLanguage == language,
    ),
  ],
  .dutch => [.sv, .bsb],
  .russian => [.nrt, .bsb],
};

extension BibleLanguageAppExtensions on BibleLanguage {
  Language? get appLanguage => switch (this) {
    .english => .english,
    .dutch => .dutch,
    .russian => .russian,
    _ => null,
  };
}
