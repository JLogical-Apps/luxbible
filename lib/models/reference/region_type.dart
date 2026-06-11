enum RegionType {
  chapter,
  verses,
  text;

  String formatThis() => switch (this) {
    chapter => 'this chapter',
    verses => 'these verses',
    text => 'this text',
  };
}
