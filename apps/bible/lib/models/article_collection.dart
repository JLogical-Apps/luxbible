import 'package:flutter/widgets.dart';
import 'package:lux/i18n.dart';
import 'package:material_symbols_icons/symbols.dart';

enum ArticleCollection {
  people,
  themes;

  String title() => switch (this) {
    people => t.labels.people,
    themes => t.labels.themes,
  };

  String description() => switch (this) {
    people => t.toolbarShortcuts.peopleDescription,
    themes => t.toolbarShortcuts.themesDescription,
  };

  String searchHint() => switch (this) {
    people => t.articles.personHint,
    themes => t.articles.themeHint,
  };

  String noMatchesMessage() => switch (this) {
    people => t.articles.noMatchingPeople,
    themes => t.articles.noMatchingThemes,
  };

  IconData get icon => switch (this) {
    people => Symbols.groups,
    themes => Symbols.category,
  };

  String get assetPath => 'assets/$name/tyndale.json';
}
