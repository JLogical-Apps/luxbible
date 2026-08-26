import 'package:lux/i18n.dart';
import 'package:lux/src/models/bible/book_type.dart';
import 'package:lux/src/models/reference/chapter_reference.dart';
import 'package:lux/src/models/testament.dart';

enum BibleTranslation {
  bsb,
  csb,
  nasb95,
  niv11,
  nlt,
  nkjv,
  kjv,
  asv,
  lxx,
  tr,
  byz,
  statresgnt,
  oshb,
  sv,
  nrt,
  fob,
  martin1744,
  rvg,
  nld1939,
  htb;

  String title() => switch (this) {
    bsb => 'BSB',
    nasb95 => 'NASB95',
    niv11 => 'NIV',
    csb => 'CSB',
    nlt => 'NLT',
    nkjv => 'NKJV',
    kjv => 'KJV',
    asv => 'ASV',
    oshb => 'OSHB',
    lxx => 'LXX',
    tr => 'TR',
    byz => 'BYZ',
    statresgnt => 'SR',
    sv => 'SV',
    nrt => 'NRT',
    fob => 'FOB',
    martin1744 => 'Martin',
    rvg => 'RVG',
    nld1939 => 'NLD1939',
    htb => 'HTB',
  };

  String fullName() => switch (this) {
    bsb => 'Berean Standard Bible',
    nasb95 => 'New American Standard Bible 1995',
    niv11 => 'New International Version 2011',
    csb => 'Christian Standard Bible',
    nlt => 'New Living Translation',
    nkjv => 'New King James Version',
    kjv => 'King James Version',
    asv => 'American Standard Version',
    oshb => 'Open Scriptures Hebrew Bible',
    lxx => 'Septuagint (Rahlfs)',
    tr => 'Textus Receptus (Stephens 1550)',
    byz => 'Byzantine Textform 2005',
    statresgnt => 'Statistical Restoration Greek New Testament',
    sv => 'Statenvertaling',
    nrt => 'New Russian Translation 2010',
    fob => 'La Sainte Bible (Ostervald 1744)',
    martin1744 => 'Bible David Martin 1744',
    rvg => 'Reina Valera Gómez 2010',
    nld1939 => 'De Heilige Schrift, Petrus Canisiusvertaling, 1939',
    htb => 'Het Boek 2007',
  };

  BibleTranslationSource get source => switch (this) {
    bsb ||
    csb ||
    asv ||
    kjv ||
    oshb ||
    lxx ||
    tr ||
    byz ||
    statresgnt ||
    sv ||
    fob ||
    martin1744 ||
    rvg ||
    nld1939 => .local,
    nasb95 => .youVersion(100),
    niv11 => .youVersion(111),
    nrt => .youVersion(143),
    htb => .youVersion(75),
    nlt || nkjv => .apiBible(),
  };

  BibleLanguage get bibleLanguage => switch (this) {
    lxx || tr || byz || statresgnt => .greek,
    oshb => .hebrew,
    sv || nld1939 || htb => .dutch,
    nrt => .russian,
    fob || martin1744 => .french,
    rvg => .spanish,
    _ => .english,
  };

  String? get copyright => switch (this) {
    nasb95 =>
      'NEW AMERICAN STANDARD BIBLE®\nCopyright © 1960, 1962, 1963, 1968, 1971, 1972, 1973, 1975, 1977, 1995 by THE LOCKMAN FOUNDATION\nA Corporation Not for Profit\nLA HABRA, CA\nAll Rights Reserved\nhttp://www.lockman.org',
    niv11 =>
      'The Holy Bible, New International Version® NIV®\nCopyright © 1973, 1978, 1984, 2011 by Biblica, Inc.®\nUsed by Permission of Biblica, Inc.® All rights reserved worldwide.',
    csb =>
      'Scripture quotations marked CSB®, are taken from the Christian Standard Bible®,\nCopyright © 2017 by Holman Bible Publishers. Used by permission. Christian Standard\nBible®, and CSB® are federally registered trademarks of Holman Bible Publishers.',
    nlt =>
      'Holy Bible, New Living Translation, copyright © 1996, 2004, 2015 by Tyndale House Foundation. All rights reserved. Used by permission of Tyndale House Publishers, Carol Stream, Illinois 60188. All rights reserved.',
    nkjv => 'New King James Version®, Copyright© 1982, Thomas Nelson. All rights reserved.',
    nrt =>
      'Святая Библия, Новый русский перевод™ НРП™\n© Biblica, Inc., 2006, 2010, 2012, 2014, 2023\nИспользуется с разрешения. Все права защищены по всему миру.\nThe Holy Bible, New Russian Translation™ NRT™\nCopyright © 2006, 2010, 2012, 2014, 2023 by Biblica, Inc.\nUsed with permission. All rights reserved worldwide.',
    rvg => 'Copyright © 2004, 2010, 2023 Dr. Humberto Gómez Caballero',
    htb =>
      'Het Boek™\nCopyright © 1979, 1988, 1998, 2007 by Biblica, Inc.\nUsed by permission. All rights reserved worldwide.',
    _ => null,
  };

  Testament? get testament => switch (this) {
    oshb || lxx => .oldTestament,
    tr || byz || statresgnt => .newTestament,
    _ => null,
  };

  DateTime? get expirationDate => switch (this) {
    csb => DateTime(2028, 8, 24),
    _ => null,
  };

  void throwIfLicenseExpired({DateTime? date}) {
    if (expirationDate case final expirationDate?) {
      final requestedAt = date ?? DateTime.now();
      final requestedDate = DateTime(requestedAt.year, requestedAt.month, requestedAt.day);
      if (requestedDate.isAfter(expirationDate)) {
        throw StateError('${title()} license expired on ${expirationDate.toIso8601String().split('T').first}');
      }
    }
  }

  bool get isRtl => this == oshb;

  bool containsBook(BookType book) => testament == null || book.testament == testament;

  bool get isLocal => source == .local;
  bool get isOnline => !isLocal;

  String get onlineSourceName => switch (source) {
    YouVersionTranslationSource() => 'YouVersion Platform',
    ApiBibleTranslationSource() => 'API.Bible',
    _ => throw StateError('$this is not an online translation'),
  };

  bool get isStudy => this == bsb || this == kjv;
  bool get hasAudioBible => this == bsb || this == kjv;

  Uri? getAudioAssetUri(ChapterReference reference) => hasAudioBible
      ? Uri.https(
          'audio.luxbible.app',
          'bible/${title().toLowerCase()}/${reference.book.osisId()}_${reference.chapterNum}.mp3',
        )
      : null;

  bool get hasRedLetters => switch (this) {
    bsb || kjv || nasb95 || niv11 || csb || nlt || nkjv => true,
    _ => false,
  };

  bool get hasNativeHeadings => switch (this) {
    bsb || nasb95 || niv11 || csb || nlt || nkjv || nrt || martin1744 => true,
    _ => false,
  };

  bool get hasSyntheticHeadings => switch (this) {
    kjv || asv => true,
    _ => false,
  };

  bool get hasFootnotes => switch (this) {
    bsb || kjv || nasb95 || niv11 || csb || nlt || nkjv || asv => true,
    _ => false,
  };

  bool get hasParagraphs => switch (this) {
    oshb || sv || nrt || martin1744 => false,
    _ => true,
  };

  String getTestamentTitle() => switch (testament) {
    .oldTestament => t.testaments.oldOnly,
    .newTestament => t.testaments.newOnly,
    null => t.testaments.wholeBible,
  };

  String getTestamentDescription() => switch (testament) {
    .oldTestament => t.testaments.oldOnlyDescription,
    .newTestament => t.testaments.newOnlyDescription,
    null => t.testaments.wholeBibleDescription,
  };
}

sealed class BibleTranslationSource {
  static BibleTranslationSource local = LocalTranslationSource();
  factory BibleTranslationSource.youVersion(int bibleId) => YouVersionTranslationSource(bibleId);
  factory BibleTranslationSource.apiBible() => ApiBibleTranslationSource();

  const BibleTranslationSource();
}

class LocalTranslationSource implements BibleTranslationSource {}

class YouVersionTranslationSource implements BibleTranslationSource {
  final int bibleId;

  const YouVersionTranslationSource(this.bibleId);
}

class ApiBibleTranslationSource implements BibleTranslationSource {}

enum BibleLanguage {
  english,
  greek,
  hebrew,
  dutch,
  russian,
  french,
  spanish;

  String title() => switch (this) {
    english => t.languages.english,
    greek => t.languages.greek,
    hebrew => t.languages.hebrew,
    dutch => t.languages.dutch,
    russian => t.languages.russian,
    french => t.languages.french,
    spanish => t.languages.spanish,
  };
}
