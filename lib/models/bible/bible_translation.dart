import 'package:bible/functions/youversion.dart';
import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/testament.dart';

enum BibleTranslation {
  bsb,
  nasb95,
  niv11,
  kjv,
  asv,
  lxx,
  tr,
  byz,
  statresgnt,
  oshb,
  sv;

  static List<BibleTranslation> get defaultTranslations =>
      values.where((translation) => translation.language == .english).toList();

  String title() => switch (this) {
    bsb => 'BSB',
    nasb95 => 'NASB',
    niv11 => 'NIV',
    kjv => 'KJV',
    asv => 'ASV',
    oshb => 'OSHB',
    lxx => 'LXX',
    tr => 'TR',
    byz => 'BYZ',
    statresgnt => 'SR',
    sv => 'SV',
  };

  String fullName() => switch (this) {
    bsb => 'Berean Standard Bible',
    nasb95 => 'New American Standard Bible 1995',
    niv11 => 'New International Version 2011',
    kjv => 'King James Version',
    asv => 'American Standard Version',
    oshb => 'Open Scriptures Hebrew Bible',
    lxx => 'Septuagint (Rahlfs)',
    tr => 'Textus Receptus (1550/1894)',
    byz => 'Byzantine Textform 2013',
    statresgnt => 'Statistical Restoration Greek New Testament',
    sv => 'Statenvertaling',
  };

  BibleTranslationSource get source => switch (this) {
    bsb || asv || kjv || oshb || lxx || tr || byz || statresgnt || sv => .local,
    nasb95 => .youVersion(100),
    niv11 => .youVersion(111),
  };

  BibleLanguage get language => switch (this) {
    lxx || tr || byz || statresgnt => .greek,
    oshb => .hebrew,
    sv => .dutch,
    _ => .english,
  };

  String? get copyright => switch (this) {
    nasb95 =>
      'NEW AMERICAN STANDARD BIBLE®\nCopyright © 1960, 1962, 1963, 1968, 1971, 1972, 1973, 1975, 1977, 1995 by THE LOCKMAN FOUNDATION\nA Corporation Not for Profit\nLA HABRA, CA\nAll Rights Reserved\nhttp://www.lockman.org',
    niv11 =>
      'The Holy Bible, New International Version® NIV®\nCopyright © 1973, 1978, 1984, 2011 by Biblica, Inc.®\nUsed by Permission of Biblica, Inc.® All rights reserved worldwide.',
    oshb =>
      'Open Scriptures Hebrew Bible\nText is Public Domain; Strong\'s and morphology tagging is Creative Commons: BY 4.0\nhttp://openscriptures.org',
    lxx =>
      'Septuagint, Morphologically Tagged Rahlfs\'\nCopyrighted; free non-commercial distribution\nhttp://ccat.sas.upenn.edu',
    tr => 'Textus Receptus (1550/1894)\nCreative Commons: BY-NC-SA 4.0',
    byz =>
      'The New Testament in the Original Greek: Byzantine Textform 2013\nby Maurice A. Robinson and William G. Pierpont\nCreative Commons: BY-NC-SA 4.0',
    statresgnt =>
      'Statistical Restoration Greek New Testament\nby Alan Bunning, Center for New Testament Restoration\nCreative Commons: BY 4.0',
    sv => 'Statenvertaling (1637)\nPublic Domain\nhttps://bijbel.coas.nl/bijbel/',
    _ => null,
  };

  Testament? get testament => switch (this) {
    oshb || lxx => .oldTestament,
    tr || byz || statresgnt => .newTestament,
    _ => null,
  };

  bool get isRtl => this == oshb;

  bool containsBook(BookType book) => testament == null || book.testament == testament;

  BibleTranslation effectiveFor(BookType book) =>
      containsBook(book) ? this : (book.testament == .oldTestament ? oshb : statresgnt);

  bool get isLocal => source == .local;
  bool get isOnline => !isLocal;
}

sealed class BibleTranslationSource {
  static BibleTranslationSource local = LocalTranslationSource();
  factory BibleTranslationSource.youVersion(int bibleId) => YouVersionTranslationSource(bibleId);

  const BibleTranslationSource();

  Future<Chapter> getChapter({
    required ChapterReference chapterReference,
    required BibleTranslation translation,
    required List<Bible> localBibles,
  });
}

class LocalTranslationSource implements BibleTranslationSource {
  @override
  Future<Chapter> getChapter({
    required ChapterReference chapterReference,
    required BibleTranslation translation,
    required List<Bible> localBibles,
  }) async =>
      localBibles.firstWhere((bible) => bible.translation == translation).getChapterByReference(chapterReference);
}

class YouVersionTranslationSource implements BibleTranslationSource {
  final int bibleId;

  const YouVersionTranslationSource(this.bibleId);

  @override
  Future<Chapter> getChapter({
    required ChapterReference chapterReference,
    required BibleTranslation translation,
    required List<Bible> localBibles,
  }) => YouVersion.fetchChapter(bibleId: bibleId, chapterReference: chapterReference);
}

enum BibleLanguage {
  english,
  greek,
  hebrew,
  dutch;

  String title() => switch (this) {
    english => 'English',
    greek => 'Greek',
    hebrew => 'Hebrew',
    dutch => 'Dutch',
  };
}
