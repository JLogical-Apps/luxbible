enum BibleTranslation {
  kjv,
  asv;

  String title() => switch (this) {
    kjv => 'KJV',
    asv => 'ASV',
  };
}
