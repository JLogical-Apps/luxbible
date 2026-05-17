import 'package:bible/models/bible/display/bible.dart';
import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_selection.dart';

abstract class Region {}

abstract class ReferencesRegion extends Region {
  List<Reference> get references;
}

extension RegionExtensions on Region {
  T when<T>({
    required T Function(VerseSelection) verseSelection,
    required T Function(BibleTextSelection) textSelection,
    required T Function(ChapterReference) chapterReference,
  }) => switch (this) {
    VerseSelection vs => verseSelection(vs),
    BibleTextSelection ts => textSelection(ts),
    ChapterReference cr => chapterReference(cr),
    _ => throw UnimplementedError(),
  };

  String format(DisplayBible bible) => when(
    verseSelection: (verseSelection) => verseSelection.format(),
    textSelection: (textSelection) => '"${bible.getSelectionText(textSelection)}"',
    chapterReference: (reference) => reference.format(),
  );
}

extension ReferencesRegionExtensions on ReferencesRegion {
  T when<T>({
    required T Function(VerseSelection) verseSelection,
    required T Function(ChapterReference) chapterReference,
  }) => switch (this) {
    VerseSelection vs => verseSelection(vs),
    ChapterReference cr => chapterReference(cr),
    _ => throw UnimplementedError(),
  };

  VerseSelection toVerseSelection() => when(
    verseSelection: (verseSelection) => verseSelection,
    chapterReference: (reference) => reference.toVerseSelection(),
  );

  String format() => when(
    verseSelection: (verseSelection) => verseSelection.format(),
    chapterReference: (reference) => reference.format(),
  );
}

enum RegionType {
  chapter,
  verses,
  text;

  String formatThis() => switch (this) {
    chapter => 'this chapter',
    verses => 'these verses',
    text => 'this text',
  };
}
