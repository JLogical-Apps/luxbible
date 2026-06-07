enum BibleTranslation {
  bsb,
  nasb95,
  niv,
  kjv,
  asv;

  String title() => switch (this) {
    bsb => 'BSB',
    niv => 'NIV',
    nasb95 => 'NASB',
    kjv => 'KJV',
    asv => 'ASV',
  };

  String fullName() => switch (this) {
    bsb => 'Berean Standard Bible',
    niv => 'New International Version 2011',
    nasb95 => 'New American Standard Bible 1995',
    kjv => 'King James Version',
    asv => 'American Standard Version',
  };

  BibleTranslationSource get source => switch (this) {
    bsb || asv || kjv => .local,
    _ => .youVersion,
  };

  bool get isLocal => source == .local;
  bool get isOnline => source == .youVersion;
}

enum BibleTranslationSource { local, youVersion }
