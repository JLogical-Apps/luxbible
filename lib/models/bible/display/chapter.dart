import 'package:bible/models/bible/display/paragraph.dart';
import 'package:bible/models/bible/display/verse.dart';
import 'package:collection/collection.dart';
import 'package:utils_core/utils_core.dart';

class DisplayChapter {
  final int chapterNum;
  final List<Paragraph> paragraphs;

  const DisplayChapter({required this.chapterNum, required this.paragraphs});

  factory DisplayChapter.verses({required int chapterNum, required List<DisplayVerse> verses}) => DisplayChapter(
    chapterNum: chapterNum,
    paragraphs: verses.map((verse) => VersesParagraph(verses: [verse], type: .p, firstVerseOffset: 0)).toList(),
  );

  Map<int, DisplayVerse> get verses => paragraphs
      .whereType<VersesParagraph>()
      .expand((paragraph) => paragraph.verses)
      .groupListsBy((verse) => verse.verseNum)
      .mapValues((verseNum, verses) => DisplayVerse(verseNum: verseNum, text: verses.join(' ')));
}
