import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';

enum HighlightIcon {
  heart,
  star,
  lightbulb,
  question,
  exclamation,
  key,
  flag,
  quote,
  command,
  prayer,
  crown,
  church,
  fire,
  water,
  leaf,
  sun,
  music,
  person,
  place,
  time;

  IconData get icon => switch (this) {
    heart => Symbols.favorite,
    star => Symbols.star,
    lightbulb => Symbols.lightbulb,
    question => Symbols.question_mark,
    exclamation => Symbols.priority_high,
    key => Symbols.key,
    flag => Symbols.flag,
    quote => Symbols.format_quote,
    command => Symbols.gavel,
    prayer => Symbols.folded_hands,
    crown => Symbols.crown,
    church => Symbols.church,
    fire => Symbols.local_fire_department,
    water => Symbols.water_drop,
    leaf => Symbols.eco,
    sun => Symbols.sunny,
    music => Symbols.music_note,
    person => Symbols.person,
    place => Symbols.location_on,
    time => Symbols.schedule,
  };
}
