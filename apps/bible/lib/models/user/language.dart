import 'dart:ui';

import 'package:bible/i18n/strings.g.dart';

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
