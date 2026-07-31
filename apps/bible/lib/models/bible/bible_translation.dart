import 'package:bible/i18n/strings.g.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/testament.dart';
import 'package:bible/models/user/language.dart';

enum BibleTranslation {
  bsb,
  nasb95,
  niv11,
  csb,
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
  nrt;

  static List<BibleTranslation> defaultsFor(Language language) => switch (language) {
    .english => [bsb, ...values.where((translation) => translation != bsb && translation.language == language)],
    .dutch => [sv, bsb],
    .russian => [nrt, bsb],
  };

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
    tr => 'Textus Receptus (1550/1894)',
    byz => 'Byzantine Textform 2013',
    statresgnt => 'Statistical Restoration Greek New Testament',
    sv => 'Statenvertaling',
    nrt => 'New Russian Translation 2010',
  };

  BibleTranslationSource get source => switch (this) {
    bsb || asv || kjv || oshb || lxx || tr || byz || statresgnt || sv || nrt => .local,
    nasb95 => .youVersion(100),
    niv11 => .youVersion(111),
    csb || nlt || nkjv => .apiBible(),
  };

  BibleLanguage get bibleLanguage => switch (this) {
    lxx || tr || byz || statresgnt => .greek,
    oshb => .hebrew,
    sv => .dutch,
    nrt => .russian,
    _ => .english,
  };

  Language? get language => bibleLanguage.language;

  String? get copyright => switch (this) {
    nasb95 =>
      'NEW AMERICAN STANDARD BIBLE®\nCopyright © 1960, 1962, 1963, 1968, 1971, 1972, 1973, 1975, 1977, 1995 by THE LOCKMAN FOUNDATION\nA Corporation Not for Profit\nLA HABRA, CA\nAll Rights Reserved\nhttp://www.lockman.org',
    niv11 =>
      'The Holy Bible, New International Version® NIV®\nCopyright © 1973, 1978, 1984, 2011 by Biblica, Inc.®\nUsed by Permission of Biblica, Inc.® All rights reserved worldwide.',
    csb => '© 2017 Holman Bible Publishers',
    nlt =>
      'Holy Bible, New Living Translation, copyright © 1996, 2004, 2015 by Tyndale House Foundation. All rights reserved. Used by permission of Tyndale House Publishers, Carol Stream, Illinois 60188. All rights reserved.',
    nkjv => 'New King James Version®, Copyright© 1982, Thomas Nelson. All rights reserved.',
    lxx =>
      'Septuagint, Morphologically Tagged Rahlfs\'\nCopyrighted; free non-commercial distribution\nhttp://ccat.sas.upenn.edu',
    tr => 'Textus Receptus (1550/1894)\nCreative Commons: BY-NC-SA 4.0',
    byz =>
      'The New Testament in the Original Greek: Byzantine Textform 2013\nby Maurice A. Robinson and William G. Pierpont\nCreative Commons: BY-NC-SA 4.0',
    statresgnt =>
      'Statistical Restoration Greek New Testament\nby Alan Bunning, Center for New Testament Restoration\nCreative Commons: BY 4.0',
    nrt => 'New Russian Translation NRT\nIBS, 2010',
    _ => null,
  };

  Testament? get testament => switch (this) {
    oshb || lxx => .oldTestament,
    tr || byz || statresgnt => .newTestament,
    _ => null,
  };

  bool get isRtl => this == oshb;

  bool containsBook(BookType book) => testament == null || book.testament == testament;

  BibleTranslation effectiveFor(
    BookType book, {
    BibleTranslation oldTestamentTranslation = .oshb,
    BibleTranslation newTestamentTranslation = .statresgnt,
  }) =>
      containsBook(book) ? this : (book.testament == .oldTestament ? oldTestamentTranslation : newTestamentTranslation);

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
    bsb || nasb95 || niv11 || csb || nlt || nkjv || nrt => true,
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
    oshb || sv || nrt => false,
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
  russian;

  String title() => switch (this) {
    english => t.languages.english,
    greek => t.languages.greek,
    hebrew => t.languages.hebrew,
    dutch => t.languages.dutch,
    russian => t.languages.russian,
  };

  Language? get language => switch (this) {
    english => .english,
    dutch => .dutch,
    .russian => .russian,
    _ => null,
  };
}
