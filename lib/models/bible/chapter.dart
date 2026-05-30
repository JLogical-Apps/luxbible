import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/bible/word.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intersperse/intersperse.dart';
import 'package:utils_core/utils_core.dart';

part 'chapter.freezed.dart';
part 'chapter.g.dart';

@freezed
sealed class Chapter with _$Chapter {
  const Chapter._();

  const factory Chapter({@JsonKey(name: 'p') required List<Paragraph> paragraphs}) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) => _$ChapterFromJson(json);

  factory Chapter.verses({required List<Verse> verses}) => Chapter(
    paragraphs: verses
        .map((verse) => Paragraph.verses(verses: [verse], type: ParagraphType.p, firstVerseOffset: 0))
        .toList(),
  );

  Map<int, Verse> get verses => paragraphs
      .whereType<VersesParagraph>()
      .expand((paragraph) => paragraph.verses)
      .groupListsBy((verse) => verse.verseNum)
      .mapValues(
        (verseNum, verses) => Verse(
          verseNum: verseNum,
          words: verses.map((word) => word.words).intersperse([Word(text: ' ', data: null)]).flattenedToList,
        ),
      );
}
