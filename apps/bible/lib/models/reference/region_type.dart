import 'package:lux/i18n.dart';

enum RegionType {
  chapter,
  passage,
  verses,
  visibleVerses,
  text;

  String formatThis() => switch (this) {
    chapter => t.regionTypes.chapter,
    passage => t.regionTypes.passage,
    verses => t.regionTypes.verses,
    visibleVerses => t.regionTypes.visibleVerses,
    text => t.regionTypes.text,
  };
}
