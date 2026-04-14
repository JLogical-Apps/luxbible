enum BibleTranslation {
  kjv,
  asv,
  bsb;

  String title() => switch (this) {
    kjv => 'KJV',
    asv => 'ASV',
    bsb => 'BSB',
  };
}
