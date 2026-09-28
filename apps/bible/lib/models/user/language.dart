import 'dart:ui';

import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';

enum Language {
  english,
  dutch,
  german,
  russian;

  static Language fromLocale(Locale locale) => switch (locale.languageCode.toLowerCase()) {
    'nl' => .dutch,
    'de' => .german,
    'ru' => .russian,
    _ => .english,
  };

  static Language get device => fromLocale(PlatformDispatcher.instance.locale);

  AppLocale get appLocale => switch (this) {
    english => .en,
    dutch => .nl,
    german => .de,
    russian => .ru,
  };

  String get code => appLocale.languageCode;

  String get nativeTitle => switch (this) {
    english => 'English',
    dutch => 'Nederlands',
    german => 'Deutsch',
    russian => 'Русский',
  };

  String title() => switch (this) {
    english => t.languages.english,
    dutch => t.languages.dutch,
    german => t.languages.german,
    russian => t.languages.russian,
  };
}

List<BibleTranslation> getDefaultBibleTranslations(Language language) => switch (language) {
  .english => [
    .bsb,
    ...BibleTranslation.values.where((translation) => translation != .bsb && translation.bibleLanguage == .english),
  ],
  .dutch => [
    .sv,
    ...BibleTranslation.values.where((translation) => translation != .sv && translation.bibleLanguage == .dutch),
    .bsb,
  ],
  .german => [
    .hfa,
    ...BibleTranslation.values.where((translation) => translation != .hfa && translation.bibleLanguage == .german),
    .bsb,
  ],
  .russian => [.nrt, .synodal, .bsb],
};

extension BibleLanguageAppExtensions on BibleLanguage {
  Language? get appLanguage => switch (this) {
    .english => .english,
    .dutch => .dutch,
    .german => .german,
    .russian => .russian,
    _ => null,
  };
}
