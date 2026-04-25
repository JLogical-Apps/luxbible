import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/bible/verse_fragment.dart';
import 'package:collection/collection.dart';
import 'package:intersperse/intersperse.dart';
import 'package:utils_core/utils_core.dart';

class Chapter {
  final int chapterNum;
  final List<Paragraph> paragraphs;

  const Chapter({required this.chapterNum, required this.paragraphs});

  factory Chapter.verses({required int chapterNum, required List<Verse> verses}) => Chapter(
    chapterNum: chapterNum,
    paragraphs: verses.map((verse) => VersesParagraph(verses: [verse], type: .p, firstVerseOffset: 0)).toList(),
  );

  Map<int, Verse> get verses => paragraphs
      .whereType<VersesParagraph>()
      .expand((paragraph) => paragraph.verses)
      .groupListsBy((verse) => verse.verseNum)
      .mapValues(
        (verseNum, verses) => Verse(
          verseNum: verseNum,
          fragments: verses.map((verse) => verse.fragments).intersperse([VerseFragment(text: ' ')]).flattenedToList,
        ),
      );
}
