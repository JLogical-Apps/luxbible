enum RegionType {
  chapter,
  verses,
  visibleVerses,
  text;

  String formatThis() => switch (this) {
    chapter => 'this chapter',
    verses => 'these verses',
    visibleVerses => 'visible verses',
    text => 'this text',
  };
}
