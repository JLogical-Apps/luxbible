import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intersperse/intersperse.dart';
import 'package:lux/lux_core.dart';
import 'package:utils_core/utils_core.dart';

part 'chapter.freezed.dart';
part 'chapter.g.dart';

@freezed
sealed class Chapter with _$Chapter {
  Chapter._();

  factory Chapter({@JsonKey(name: 'p') required List<Paragraph> paragraphs}) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) => _$ChapterFromJson(json);

  factory Chapter.verses({required List<Verse> verses}) => Chapter(
    paragraphs: verses
        .map((verse) => Paragraph.verses(verses: [verse], type: ParagraphType.p, firstVerseOffset: 0))
        .toList(),
  );

  @override
  late final Map<int, Verse> verses = paragraphs
      .whereType<VersesParagraph>()
      .expand((paragraph) => paragraph.verses)
      .groupListsBy((verse) => verse.verseNum)
      .mapValues(
        (verseNum, verses) => Verse(
          verseNum: verseNum,
          words: verses.map((word) => word.words).intersperse([Word(text: ' ', data: null)]).flattenedToList,
          originalVerse: verses.map((verse) => verse.originalVerse).nonNulls.firstOrNull,
        ),
      );

  Verse? getVerseByReference(Reference reference) => verses[reference.verseNum];

  BibleTextSelection getWordsSelection(BibleTextSelection selection) {
    final startVerseText = getVerseByReference(selection.start.toReference())!.text;
    final endVerseText = getVerseByReference(selection.end.toReference())!.text;
    return BibleTextSelection(
      translation: selection.translation,
      start: BibleTextSelectionWordAnchor.fromReference(
        reference: selection.start.toReference(),
        characterOffset:
            List.generate(
              selection.start.characterOffset,
              (i) => i,
            ).where((offset) => startVerseText[offset] == ' ').lastOrNull?.mapIfNonNull((offset) => offset + 1) ??
            0,
      ),
      end: BibleTextSelectionWordAnchor.fromReference(
        reference: selection.end.toReference(),
        characterOffset:
            Range.generate(
              selection.end.characterOffset,
              endVerseText.length - 1,
            ).where((offset) => endVerseText[offset].isLetterOnly).firstOrNull?.mapIfNonNull((offset) => offset - 1) ??
            endVerseText.length - 1,
      ),
    );
  }
}
