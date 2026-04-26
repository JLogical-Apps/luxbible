enum BibleTranslation {
  bsb,
  kjv,
  asv;

  String title() => switch (this) {
    bsb => 'BSB',
    kjv => 'KJV',
    asv => 'ASV',
  };
}
