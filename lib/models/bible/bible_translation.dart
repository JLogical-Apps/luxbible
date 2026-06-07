import 'package:bible/functions/youversion.dart';
import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/reference/chapter_reference.dart';

enum BibleTranslation {
  bsb,
  nasb95,
  niv,
  kjv,
  asv;

  String title() => switch (this) {
    bsb => 'BSB',
    nasb95 => 'NASB',
    niv => 'NIV',
    kjv => 'KJV',
    asv => 'ASV',
  };

  String fullName() => switch (this) {
    bsb => 'Berean Standard Bible',
    nasb95 => 'New American Standard Bible 1995',
    niv => 'New International Version 2011',
    kjv => 'King James Version',
    asv => 'American Standard Version',
  };

  BibleTranslationSource get source => switch (this) {
    bsb || asv || kjv => .local,
    nasb95 => .youVersion(100),
    niv => .youVersion(111),
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
