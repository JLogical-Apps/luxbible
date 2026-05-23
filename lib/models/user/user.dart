import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/display/bible.dart';
import 'package:bible/models/bible/study/bible.dart';
import 'package:bible/models/bookmark.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/models/user/main_toolbar_configuration.dart';
import 'package:bible/models/user/text_selection_configuration.dart';
import 'package:bible/models/user/verse_selection_configuration.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
sealed class User with _$User {
  const User._();

  const factory User({
    @Default(BibleTranslation.bsb) BibleTranslation translation,
    @Default(ChapterReference(chapterNum: 1, book: BookType.genesis)) ChapterReference lastReference,
    String? currentBookmarkId,
    @Default([]) List<ChapterReference> viewHistory,
    @Default(ColorEnum.yellow) ColorEnum highlightColor,
    @Default({}) Map<String, Bookmark> bookmarkById,
    @Default([]) List<Annotation> annotations,
    @Default(MainToolbarConfiguration()) MainToolbarConfiguration mainToolbar,
    @Default(VerseSelectionConfiguration()) VerseSelectionConfiguration verseSelection,
    @Default(TextSelectionConfiguration()) TextSelectionConfiguration textSelection,
    @Default([]) List<String> searchHistory,
    @Default(InterlinearDirection.reverse) InterlinearDirection interlinearDirection,
    @Default(ThemeMode.system) ThemeMode theme,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  DisplayBible getDisplayBible(List<DisplayBible> bibles) =>
      bibles.firstWhere((bible) => bible.translation == translation);

  StudyBible getStudyBible(List<StudyBible> bibles) => bibles.firstWhere((bible) => bible.translation == translation);

  Bookmark? get currentBookmark => bookmarkById[currentBookmarkId];

  List<Annotation> getVerseSelectionAnnotations(VerseSelection verseSelection) =>
      annotations.where((annotation) => annotation.verseSelections.any((vs) => vs.hasAnyOf(verseSelection))).toList();
  bool isVerseSelectionAnnotated(VerseSelection verseSelection) =>
      getVerseSelectionAnnotations(verseSelection).isNotEmpty;

  List<(Annotation, BibleTextSelection)> getTextSelectionAnnotationsInVerseSelection(
    VerseSelection verseSelection, {
    required BibleTranslation translation,
  }) => annotations
      .expand(
        (annotation) => annotation.textSelections
            .where((ts) => ts.translation == translation && ts.isInVerseSelection(verseSelection))
            .map((ts) => (annotation, ts)),
      )
      .toList();

  List<Annotation> getTextSelectionAnnotations(BibleTextSelection textSelection) => annotations
      .where(
        (annotation) => annotation.textSelections.any(
          (ts) => ts.translation == textSelection.translation && ts.intersects(textSelection),
        ),
      )
      .toList();
  bool isTextSelectionAnnotated(BibleTextSelection textSelection) =>
      getTextSelectionAnnotations(textSelection).isNotEmpty;

  Map<int, List<Annotation>> getTextSelectionAnnotationsWithNotesByOffset({
    required Reference reference,
    required BibleTranslation translation,
  }) => annotations
      .where((annotation) => annotation.note != null)
      .expand(
        (annotation) => annotation.textSelections
            .where((textSelection) => textSelection.translation == translation)
            .where((textSelection) => textSelection.start.toReference() == reference)
            .map((textSelection) => (annotation, textSelection)),
      )
      .groupListsBy((records) => records.$2.start.characterOffset)
      .map((offset, records) => MapEntry(offset, records.map((record) => record.$1).toList()));

  List<Reference> getExpandedReferences(Reference reference) =>
      annotations
          .expand((annotation) => annotation.verseSelections.where((vs) => vs.references.contains(reference)))
          .lastOrNull
          ?.references ??
      [reference];

  BibleTextSelection getExpandedTextSelection(BibleTextSelection textSelection) =>
      annotations
          .expand((annotation) => annotation.textSelections.where((ts) => ts.intersects(textSelection)))
          .lastOrNull ??
      textSelection;

  User withNewBookmark(Bookmark bookmark) {
    final newId = Uuid().v4();
    return copyWith(bookmarkById: {...bookmarkById, newId: bookmark}, currentBookmarkId: newId);
  }

  User withEditedBookmark({required String bookmarkId, required Bookmark bookmark}) =>
      copyWith(bookmarkById: {...bookmarkById}..[bookmarkId] = bookmark);

  User withRemovedBookmark(String bookmarkId) =>
      copyWith(bookmarkById: {...bookmarkById}..remove(bookmarkId), currentBookmarkId: null);

  User withAnnotation(Annotation annotation) =>
      copyWith(annotations: [...annotations, annotation], highlightColor: annotation.color);

  User withRemovedRegionAnnotations(Region region) => region.when(
    verseSelection: (verseSelection) => withRemovedVerseSelectionAnnotations(verseSelection),
    textSelection: (textSelection) => withRemovedTextSelectionAnnotations(textSelection),
    chapterReference: (reference) => throw UnimplementedError(),
  );

  User withRemovedVerseSelectionAnnotations(VerseSelection verseSelection) => copyWith(
    annotations: annotations
        .map(
          (annotation) => annotation.copyWith(
            verseSelections: annotation.verseSelections.where((vs) => !vs.hasAnyOf(verseSelection)).toList(),
          ),
        )
        .where((annotation) => annotation.isNotEmpty)
        .toList(),
  );
  User withRemovedTextSelectionAnnotations(BibleTextSelection textSelection) => copyWith(
    annotations: annotations
        .map(
          (annotation) => annotation.copyWith(
            textSelections: annotation.textSelections.where((ts) => !textSelection.intersects(ts)).toList(),
          ),
        )
        .where((annotation) => annotation.isNotEmpty)
        .toList(),
  );
  User withRemovedAnnotation(Annotation annotation) => copyWith(annotations: annotations.withRemoved(annotation));

  User withHardNavigation(ChapterReference reference, {String? bookmarkId}) => copyWith(
    lastReference: reference,
    currentBookmarkId: bookmarkId,
    viewHistory: [reference, lastReference, ...viewHistory].distinct.take(5).toList(),
  );

  User withSoftNavigation(ChapterReference reference) {
    final currentBookmarkId = this.currentBookmarkId;
    final currentBookmark = this.currentBookmark;
    return copyWith(
      lastReference: reference,
      bookmarkById: currentBookmarkId == null || currentBookmark == null
          ? {...bookmarkById}
          : ({...bookmarkById}..[currentBookmarkId] = currentBookmark.copyWith(chapter: reference)),
    );
  }

  User withSearchHistory(String search) =>
      copyWith(searchHistory: [search, ...searchHistory].distinct.take(5).toList());
}
