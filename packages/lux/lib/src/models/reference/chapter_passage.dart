import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:lux/lux_core.dart';
import 'package:utils_core/utils_core.dart';

class ChapterPassage extends Equatable {
  final VerseSelection verseSelection;

  const ChapterPassage._(this.verseSelection);

  factory ChapterPassage.chapter(ChapterReference chapter) => ChapterPassage._(chapter.toVerseSelection());

  static List<ChapterPassage> listFromVerseSelection(VerseSelection selection) => selection.references
      .groupListsBy((reference) => reference.toChapterReference())
      .mapToIterable(
        (chapter, references) => ChapterPassage._(
          chapter.numVerses == references.length
              ? chapter.toVerseSelection()
              : VerseSelection.fromReferences(references),
        ),
      )
      .toList();

  // Imported plans can hold passages that cross chapters. Single-chapter passages keep their exact form so stored
  // progress still matches, and invalid ones stay whole so plan validation can report them.
  static List<ChapterPassage> splitFromJson(String json) {
    final selection = VerseSelection.fromOsisId(json);
    return selection.isWithinChapter || !VerseSelection.isOsisId(json)
        ? [ChapterPassage._(selection)]
        : selection.splitByChapter();
  }

  static List<ChapterPassage> listFromJson(List<dynamic> json) =>
      json.cast<String>().expand(splitFromJson).distinct.toList();

  static Set<ChapterPassage> setFromJson(List<dynamic> json) => listFromJson(json).toSet();

  String toJson() => verseSelection.toJson();

  @override
  List<Object?> get props => [verseSelection];

  ChapterReference get chapter => verseSelection.startChapter;
  List<Reference> get references => verseSelection.references;
  bool get isWholeChapter => verseSelection.isChapter;

  String format() => verseSelection.format();
}
