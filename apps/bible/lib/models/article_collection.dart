import 'package:bible/models/commentary_type.dart';
import 'package:flutter/widgets.dart';
import 'package:lux/i18n.dart';
import 'package:material_symbols_icons/symbols.dart';

enum ArticleCollection {
  dictionary,
  people,
  themes;

  String title() => switch (this) {
    dictionary => t.labels.dictionary,
    people => t.labels.people,
    themes => t.labels.themes,
  };

  String description() => switch (this) {
    dictionary => t.toolbarShortcuts.dictionaryDescription,
    people => t.toolbarShortcuts.peopleDescription,
    themes => t.toolbarShortcuts.themesDescription,
  };

  String source() => switch (this) {
    dictionary => t.dictionary.tyndale,
    people || themes => CommentaryType.tyndale.title(),
  };

  String searchHint() => switch (this) {
    dictionary => t.searchUi.wordHint,
    people => t.articles.personHint,
    themes => t.articles.themeHint,
  };

  String noMatchesMessage() => switch (this) {
    dictionary => t.emptyStates.noMatchingWords,
    people => t.articles.noMatchingPeople,
    themes => t.articles.noMatchingThemes,
  };

  IconData get icon => switch (this) {
    dictionary => Symbols.menu_book,
    people => Symbols.groups,
    themes => Symbols.category,
  };

  // Dictionary entries have no passages, so Linked Resources skips loading them.
  bool get hasPassages => switch (this) {
    dictionary => false,
    people || themes => true,
  };

  String get assetPath => 'assets/$name/tyndale.json';
}
