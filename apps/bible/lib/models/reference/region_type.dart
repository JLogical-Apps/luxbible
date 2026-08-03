import 'package:lux/i18n.dart';

enum RegionType {
  chapter,
  verses,
  visibleVerses,
  text;

  String formatThis() => switch (this) {
    chapter => t.regionTypes.chapter,
    verses => t.regionTypes.verses,
    visibleVerses => t.regionTypes.visibleVerses,
    text => t.regionTypes.text,
  };
}
