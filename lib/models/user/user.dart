import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bookmark.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/chapter_position.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/study_panel.dart';
import 'package:bible/models/user/main_toolbar_configuration.dart';
import 'package:bible/models/user/text_selection_configuration.dart';
import 'package:bible/models/user/theme_layout_configuration.dart';
import 'package:bible/models/user/tutorial.dart';
import 'package:bible/models/user/verse_selection_configuration.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
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
    List<BibleTranslation>? bibles,
    @ChapterPositionFromReference('lastReference')
    @Default(ChapterPosition(reference: ChapterReference(chapterNum: 1, book: BookType.genesis)))
    ChapterPosition lastPosition,
    String? currentBookmarkId,
    @ChapterPositionFromReference('viewHistory') @Default([]) List<ChapterPosition> viewHistory,
    @Default(ColorEnum.yellow) ColorEnum highlightColor,
    @Default({}) Map<String, Bookmark> bookmarkById,
    @Default([]) List<Annotation> annotations,
    @Default(MainToolbarConfiguration()) MainToolbarConfiguration mainToolbar,
    @Default(VerseSelectionConfiguration()) VerseSelectionConfiguration verseSelection,
    @Default(TextSelectionConfiguration()) TextSelectionConfiguration textSelection,
    @Default([]) List<String> searchHistory,
    @Default(InterlinearDirection.reverse) InterlinearDirection interlinearDirection,
    @Default(ThemeMode.system) ThemeMode theme,
    @Default(ThemeLayoutConfiguration()) ThemeLayoutConfiguration themeLayout,
    @Default([]) List<StudyPanel> studyPanels,
    int? studyPanelIndex,
    @Default(0.5) double studyPanelBottomPosition,
    @Default([]) List<Tutorial> tutorials,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  List<BibleTranslation> get biblesOrDefault => bibles ?? BibleTranslation.defaultTranslations;

  ChapterReference get lastReference => lastPosition.reference;

  Bookmark? get currentBookmark => bookmarkById[currentBookmarkId];

  List<Annotation> getVerseSelectionAnnotations(VerseSelection verseSelection) =>
      annotations.where((annotation) => annotation.verseSelection?.hasAnyOf(verseSelection) == true).toList();

  bool isVerseSelectionAnnotated(VerseSelection verseSelection) =>
      getVerseSelectionAnnotations(verseSelection).isNotEmpty;

  List<(Annotation, BibleTextSelection)> getTextSelectionAnnotationsInVerseSelection(
    VerseSelection verseSelection, {
    required BibleTranslation translation,
  }) => annotations
      .map((annotation) => (annotation, annotation.textSelection))
      .whereType<(Annotation, BibleTextSelection)>()
      .where(
        (annotationAndSelection) =>
            annotationAndSelection.$2.translation == translation &&
            annotationAndSelection.$2.isInVerseSelection(verseSelection),
      )
      .toList();

  List<Annotation> getTextSelectionAnnotations(BibleTextSelection textSelection) => annotations.where((annotation) {
    final ts = annotation.textSelection;
    return ts != null && ts.translation == textSelection.translation && ts.intersects(textSelection);
  }).toList();

  bool isTextSelectionAnnotated(BibleTextSelection textSelection) =>
      getTextSelectionAnnotations(textSelection).isNotEmpty;

  Map<int, List<Annotation>> getTextSelectionAnnotationsWithNotesByOffset({
    required Reference reference,
    required BibleTranslation translation,
  }) => annotations
      .where((annotation) => annotation.note.isNotEmpty)
      .map((annotation) => (annotation, annotation.textSelection))
      .whereType<(Annotation, BibleTextSelection)>()
      .where(
        (annotationAndSelection) =>
            annotationAndSelection.$2.translation == translation &&
            annotationAndSelection.$2.start.toReference() == reference,
      )
      .groupListsBy((records) => records.$2.start.characterOffset)
      .map((offset, records) => MapEntry(offset, records.map((record) => record.$1).toList()));

  List<Reference> getExpandedReferences(Reference reference) =>
      annotations
          .map((annotation) => annotation.verseSelection)
          .nonNulls
          .where((verseSelection) => verseSelection.hasReference(reference))
          .lastOrNull
          ?.references ??
      [reference];

  BibleTextSelection getExpandedTextSelection(BibleTextSelection textSelection) =>
      annotations
          .map((annotation) => annotation.textSelection)
          .nonNulls
          .where((selection) => selection.intersects(textSelection))
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

  User withAnnotationUpdated(Annotation oldAnnotation, Annotation newAnnotation) =>
      copyWith(annotations: annotations.withRemoved(oldAnnotation) + [newAnnotation]);

  User withRemovedSelectionAnnotations(AnnotationSelection selection) => selection.when(
    verses: (verseSelection) => withRemovedVerseSelectionAnnotations(verseSelection),
    text: (textSelection) => withRemovedTextSelectionAnnotations(textSelection),
  );

  User withRemovedVerseSelectionAnnotations(VerseSelection verseSelection) => copyWith(
    annotations: annotations
        .where((annotation) => annotation.verseSelection?.hasAnyOf(verseSelection) != true)
        .toList(),
  );
  User withRemovedTextSelectionAnnotations(BibleTextSelection textSelection) => copyWith(
    annotations: annotations
        .where((annotation) => annotation.textSelection?.intersects(textSelection) != true)
        .toList(),
  );
  User withRemovedAnnotation(Annotation annotation) => copyWith(annotations: annotations.withRemoved(annotation));

  User withHardNavigation(ChapterPosition position, {String? bookmarkId}) {
    return copyWith(
      lastPosition: position,
      currentBookmarkId: bookmarkId,
      viewHistory: [
        position,
        lastPosition,
        ...viewHistory,
      ].distinctBy((position) => position.reference).take(5).toList(),
    );
  }

  User withSoftNavigation(ChapterPosition position) {
    final currentBookmarkId = this.currentBookmarkId;
    final currentBookmark = this.currentBookmark;
    return copyWith(
      lastPosition: position,
      bookmarkById: currentBookmarkId == null || currentBookmark == null
          ? {...bookmarkById}
          : ({...bookmarkById}..[currentBookmarkId] = currentBookmark.copyWith(position: position)),
    );
  }

  User withScrollPercent(double percent) {
    final updatedPosition = lastPosition.copyWith(scrollPercent: percent);
    final currentBookmarkId = this.currentBookmarkId;
    final currentBookmark = this.currentBookmark;
    return copyWith(
      lastPosition: updatedPosition,
      viewHistory: viewHistory.isNotEmpty && viewHistory.first.reference == lastPosition.reference
          ? [updatedPosition, ...viewHistory.skip(1)]
          : viewHistory,
      bookmarkById: currentBookmarkId == null || currentBookmark == null
          ? bookmarkById
          : ({...bookmarkById}
              ..[currentBookmarkId] = currentBookmark.copyWith(
                position: currentBookmark.position.copyWith(scrollPercent: percent),
              )),
    );
  }

  User withSearchHistory(String search) =>
      copyWith(searchHistory: [search, ...searchHistory].distinct.take(5).toList());

  User withStudyPanel(StudyPanel studyPanel) =>
      copyWith(studyPanels: [...studyPanels, studyPanel], studyPanelIndex: studyPanels.length);

  User withTutorial(Tutorial tutorial) => copyWith(tutorials: tutorials + [tutorial]);
}
