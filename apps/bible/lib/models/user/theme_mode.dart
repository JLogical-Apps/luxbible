import 'package:lux/i18n.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

extension ThemeModeExtensions on ThemeMode {
  String title() => switch (this) {
    .system => t.themeOptions.auto,
    .light => t.themeOptions.light,
    .dark => t.themeOptions.dark,
  };

  IconData get icon => switch (this) {
    .system => Symbols.brightness_6,
    .light => Symbols.light_mode,
    .dark => Symbols.dark_mode,
  };
}
