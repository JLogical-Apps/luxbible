import 'package:bible/models/bible.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/selection.dart';

abstract class Region {}

abstract class ReferencesRegion extends Region {
  List<Reference> get references;
}

extension RegionExtensions on Region {
  T when<T>({
    required T Function(Passage) passage,
    required T Function(Selection) selection,
    required T Function(ChapterReference) chapterReference,
  }) => switch (this) {
    Passage p => passage(p),
    Selection s => selection(s),
    ChapterReference cr => chapterReference(cr),
    _ => throw UnimplementedError(),
  };

  String format(Bible bible) => when(
    passage: (passage) => passage.format(),
    selection: (selection) => '"${bible.getSelectionText(selection)}"',
    chapterReference: (reference) => reference.format(),
  );
}

extension ReferencesRegionExtensions on ReferencesRegion {
  T when<T>({required T Function(Passage) passage, required T Function(ChapterReference) chapterReference}) =>
      switch (this) {
        Passage p => passage(p),
        ChapterReference cr => chapterReference(cr),
        _ => throw UnimplementedError(),
      };

  Passage toPassage() => when(passage: (passage) => passage, chapterReference: (reference) => reference.toPassage());

  String format() => when(passage: (passage) => passage.format(), chapterReference: (reference) => reference.format());
}

enum RegionType {
  chapter,
  passage,
  selection;

  String formatThis() => switch (this) {
    chapter => 'this chapter',
    passage => 'this passage',
    selection => 'this selection',
  };
}
