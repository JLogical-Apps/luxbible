import 'package:bible/functions/youversion.dart';
import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/reference/chapter_reference.dart';

enum BibleTranslation {
  bsb,
  nasb95,
  niv11,
  kjv,
  asv;

  String title() => switch (this) {
    bsb => 'BSB',
    nasb95 => 'NASB',
    niv11 => 'NIV',
    kjv => 'KJV',
    asv => 'ASV',
  };

  String fullName() => switch (this) {
    bsb => 'Berean Standard Bible',
    nasb95 => 'New American Standard Bible 1995',
    niv11 => 'New International Version 2011',
    kjv => 'King James Version',
    asv => 'American Standard Version',
  };

  BibleTranslationSource get source => switch (this) {
    bsb || asv || kjv => .local,
    nasb95 => .youVersion(100),
    niv11 => .youVersion(111),
  };

  String? get copyright => switch (this) {
    nasb95 =>
      'NEW AMERICAN STANDARD BIBLE®\nCopyright © 1960, 1962, 1963, 1968, 1971, 1972, 1973, 1975, 1977, 1995 by THE LOCKMAN FOUNDATION\nA Corporation Not for Profit\nLA HABRA, CA\nAll Rights Reserved\nhttp://www.lockman.org',
    niv11 =>
      'The Holy Bible, New International Version® NIV®\nCopyright © 1973, 1978, 1984, 2011 by Biblica, Inc.®\nUsed by Permission of Biblica, Inc.® All rights reserved worldwide.',
    _ => null,
  };

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
