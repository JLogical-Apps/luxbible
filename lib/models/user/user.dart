import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible_plan.dart';
import 'package:bible/models/bookmark.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/models/commentary_type.dart';
import 'package:bible/models/highlight_style.dart';
import 'package:bible/models/hydrated_bible_plan_progress.dart';
import 'package:bible/models/notebook.dart';
import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/chapter_position.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/study_panel.dart';
import 'package:bible/models/user/audio_bible_configuration.dart';
import 'package:bible/models/user/main_toolbar_configuration.dart';
import 'package:bible/models/user/onboarding_step.dart';
import 'package:bible/models/user/text_selection_configuration.dart';
import 'package:bible/models/user/theme_layout_configuration.dart';
import 'package:bible/models/user/toolbar_preset.dart';
import 'package:bible/models/user/tutorial.dart';
import 'package:bible/models/user/verse_selection_configuration.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:bible/utils/serialization_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:utils_core/utils_core.dart';
import 'package:uuid/uuid.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
sealed class User with _$User {
  const User._();

  const factory User({
    @Default(BibleTranslation.bsb) BibleTranslation translation,
    @Default(BibleTranslation.bsb) BibleTranslation studyTranslation,
    @Default(BibleTranslation.oshb) BibleTranslation oldTestamentTranslation,
    @Default(BibleTranslation.statresgnt) BibleTranslation newTestamentTranslation,
    List<BibleTranslation>? bibles,
    List<CommentaryType>? commentaries,
    @ChapterPositionFromReference('lastReference')
    @Default(ChapterPosition(reference: ChapterReference(chapterNum: 1, book: BookType.genesis)))
    ChapterPosition lastPosition,
    String? currentBookmarkId,
    @ChapterPositionFromReference('viewHistory') @Default([]) List<ChapterPosition> viewHistory,
    @Default(HighlightStyle.fallback) @JsonKey(readValue: _readLastHighlightStyle) HighlightStyle lastHighlightStyle,
    @Default({}) Map<String, Bookmark> bookmarkById,
    @Default([]) List<Annotation> annotations,
    @Default([]) List<Notebook> notebooks,
    String? lastNotebookId,
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
    @Default({}) @nullUnknownEnum Set<Tutorial?> tutorials,
    List<OnboardingStep>? completedOnboardingSteps,
    @Default(HighlightStyle.defaultValues) List<(HighlightStyle, String label)> highlightStyles,
    @Default({}) Map<BiblePlanType, BiblePlanProgress> planProgressByType,
    @Default({}) Set<BiblePlanType> completedPlans,
    @Default(AudioBibleConfiguration()) AudioBibleConfiguration audio,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  List<BibleTranslation> get biblesOrDefault => bibles ?? BibleTranslation.defaultTranslations;

  BibleTranslation translationFor(BookType book) => translation.effectiveFor(
    book,
    oldTestamentTranslation: oldTestamentTranslation,
    newTestamentTranslation: newTestamentTranslation,
  );

  List<CommentaryType> get commentariesOrDefault => commentaries ?? CommentaryType.values;

  ChapterReference get lastReference => lastPosition.reference;

  Bookmark? get currentBookmark => bookmarkById[currentBookmarkId];

  List<Annotation> getVerseSelectionAnnotations(VerseSelection verseSelection) =>
      visibleAnnotations.where((annotation) => annotation.verseSelection?.hasAnyOf(verseSelection) == true).toList();

  bool isVerseSelectionAnnotated(VerseSelection verseSelection) =>
      getVerseSelectionAnnotations(verseSelection).isNotEmpty;

  List<(Annotation, BibleTextSelection)> getTextSelectionAnnotationsInVerseSelection(
    VerseSelection verseSelection, {
    required BibleTranslation translation,
  }) => visibleAnnotations
      .map((annotation) => (annotation, annotation.textSelection))
      .whereType<(Annotation, BibleTextSelection)>()
      .where(
        (annotationAndSelection) =>
            annotationAndSelection.$2.translation == translation &&
            annotationAndSelection.$2.isInVerseSelection(verseSelection),
      )
      .toList();

  List<Annotation> getTextSelectionAnnotations(BibleTextSelection textSelection) =>
      visibleAnnotations.where((annotation) {
        final ts = annotation.textSelection;
        return ts != null && ts.translation == textSelection.translation && ts.intersects(textSelection);
      }).toList();

  bool isTextSelectionAnnotated(BibleTextSelection textSelection) =>
      getTextSelectionAnnotations(textSelection).isNotEmpty;

  Map<int, List<Annotation>> getTextSelectionAnnotationsWithNotesByOffset({
    required Reference reference,
    required BibleTranslation translation,
  }) => visibleAnnotations
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
      visibleAnnotations
          .map((annotation) => annotation.verseSelection)
          .nonNulls
          .where((verseSelection) => verseSelection.hasReference(reference))
          .lastOrNull
          ?.references ??
      [reference];

  BibleTextSelection getExpandedTextSelection(BibleTextSelection textSelection) =>
      visibleAnnotations
          .map((annotation) => annotation.textSelection)
          .nonNulls
          .where((selection) => selection.intersects(textSelection))
          .lastOrNull ??
      textSelection;

  ToolbarPreset? get toolbarPreset => ToolbarPreset.values.firstWhereOrNull((preset) => preset.matches(this));

  bool get isOnboardingActive => completedOnboardingSteps != null;

  bool isOnboardingStepCompleted(OnboardingStep step) => completedOnboardingSteps?.contains(step) ?? false;

  int? get currentOnboardingStepIndex {
    final completedOnboardingSteps = this.completedOnboardingSteps;
    if (completedOnboardingSteps == null) return null;
    return OnboardingStep.values.indexWhereOrNull((step) => !completedOnboardingSteps.contains(step));
  }

  OnboardingStep? get currentOnboardingStep =>
      currentOnboardingStepIndex?.mapIfNonNull((stepIndex) => OnboardingStep.values[stepIndex]);

  User withNewBookmark(Bookmark bookmark) {
    final newId = Uuid().v4();
    return copyWith(bookmarkById: {...bookmarkById, newId: bookmark}, currentBookmarkId: newId);
  }

  User withEditedBookmark({required String bookmarkId, required Bookmark bookmark}) =>
      copyWith(bookmarkById: {...bookmarkById}..[bookmarkId] = bookmark);

  User withRemovedBookmark(String bookmarkId) =>
      copyWith(bookmarkById: {...bookmarkById}..remove(bookmarkId), currentBookmarkId: null);

  Notebook? getNotebookById(String? id) =>
      id == null ? null : notebooks.firstWhereOrNull((notebook) => notebook.id == id);

  Notebook? get lastNotebook => getNotebookById(lastNotebookId);

  List<Annotation> get visibleAnnotations =>
      annotations.where((annotation) => getNotebookById(annotation.notebookId)?.isVisible != false).toList();

  User withNewNotebook(Notebook notebook) => copyWith(notebooks: [notebook, ...notebooks], lastNotebookId: notebook.id);

  User withUpdatedNotebook(Notebook notebook) =>
      copyWith(notebooks: notebooks.map((n) => n.id == notebook.id ? notebook : n).toList());

  User withRemovedNotebook(String notebookId, {required bool deleteAnnotations}) => copyWith(
    notebooks: notebooks.where((notebook) => notebook.id != notebookId).toList(),
    annotations: deleteAnnotations
        ? annotations.where((annotation) => annotation.notebookId != notebookId).toList()
        : annotations,
    lastNotebookId: lastNotebookId == notebookId ? null : lastNotebookId,
  );

  User withReorderedNotebooks(int oldIndex, int newIndex) =>
      copyWith(notebooks: notebooks.withReorder(oldIndex, newIndex));

  bool hasHighlightStyle(HighlightStyle style) => highlightStyles.any((entry) => entry.$1 == style);

  String? labelForHighlightStyle(HighlightStyle style) =>
      highlightStyles.firstWhereOrNull((entry) => entry.$1 == style)?.$2;

  HighlightStyle get defaultAnnotationStyle =>
      hasHighlightStyle(lastHighlightStyle) ? lastHighlightStyle : highlightStyles.firstOrNull?.$1 ?? .fallback;

  User withNewHighlightStyle((HighlightStyle, String label) style) =>
      copyWith(highlightStyles: [style, ...highlightStyles]);

  User withUpdatedHighlightStyle(int index, (HighlightStyle, String label) style, {required bool updateAnnotations}) {
    final previousStyle = highlightStyles[index].$1;
    return copyWith(
      highlightStyles: highlightStyles.withSetAt(index, style),
      lastHighlightStyle: lastHighlightStyle == previousStyle ? style.$1 : lastHighlightStyle,
      annotations: updateAnnotations
          ? annotations
                .map(
                  (annotation) => annotation.style == previousStyle ? annotation.copyWith(style: style.$1) : annotation,
                )
                .toList()
          : annotations,
    );
  }

  User withRemovedHighlightStyle(int index, {required bool deleteAnnotations}) {
    final style = highlightStyles[index].$1;
    return copyWith(
      highlightStyles: highlightStyles.whereIndexed((i, _) => i != index).toList(),
      annotations: deleteAnnotations
          ? annotations.where((annotation) => annotation.style != style).toList()
          : annotations,
    );
  }

  User withReorderedHighlightStyles(int oldIndex, int newIndex) =>
      copyWith(highlightStyles: highlightStyles.withReorder(oldIndex, newIndex));

  User withAnnotation(Annotation annotation) => copyWith(
    annotations: [...annotations, annotation],
    lastHighlightStyle: annotation.style,
    lastNotebookId: annotation.notebookId,
  );

  User withAnnotationUpdated(Annotation oldAnnotation, Annotation newAnnotation) => copyWith(
    annotations: annotations.withRemoved(oldAnnotation) + [newAnnotation],
    lastHighlightStyle: newAnnotation.style,
    lastNotebookId: newAnnotation.notebookId,
  );

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

  User withTutorial(Tutorial tutorial) => copyWith(tutorials: {...tutorials, tutorial});

  User withTutorialsReset() => copyWith(tutorials: {});

  User withOnboardingStepCompleted(OnboardingStep step) {
    final completed = completedOnboardingSteps;
    return completed == null || completed.contains(step)
        ? this
        : copyWith(completedOnboardingSteps: [...completed, step]);
  }

  User withOnboardingReset() => copyWith(completedOnboardingSteps: []);

  User withOnboardingDismissed() => copyWith(completedOnboardingSteps: null);

  User withPreset(ToolbarPreset preset) => copyWith(
    mainToolbar: mainToolbar.copyWith(
      pinnedShortcut1: preset.mainPinnedShortcuts[0],
      pinnedShortcut2: preset.mainPinnedShortcuts[1],
      longPressShortcut: preset.mainLongPressShortcut,
    ),
    verseSelection: verseSelection.copyWith(
      pinnedShortcut1: preset.versePinnedShortcuts[0],
      pinnedShortcut2: preset.versePinnedShortcuts[1],
      pinnedShortcut3: preset.versePinnedShortcuts[2],
      longPressShortcut: preset.verseLongPressShortcut,
    ),
    textSelection: textSelection.copyWith(
      pinnedShortcut1: preset.textPinnedShortcuts[0],
      pinnedShortcut2: preset.textPinnedShortcuts[1],
      pinnedShortcut3: preset.textPinnedShortcuts[2],
      longPressShortcut: preset.textLongPressShortcut,
    ),
  );

  User withTranslation(BibleTranslation translation) => copyWith(
    translation: translation,
    studyTranslation: translation.isStudy ? translation : studyTranslation,
    oldTestamentTranslation: translation.testament == .oldTestament ? translation : oldTestamentTranslation,
    newTestamentTranslation: translation.testament == .newTestament ? translation : newTestamentTranslation,
  );

  List<HydratedBiblePlanProgress> getHydratedPlanProgresses(Map<BiblePlanType, BiblePlan> planByType) =>
      planProgressByType
          .mapToIterable(
            (type, progress) => HydratedBiblePlanProgress(type: type, plan: planByType[type]!, progress: progress),
          )
          .toList();

  HydratedBiblePlanProgress? getHydratedPlanProgress({
    required BiblePlanType planType,
    required Map<BiblePlanType, BiblePlan> planByType,
  }) => getHydratedPlanProgresses(planByType).firstWhereOrNull((progress) => progress.type == planType);

  bool hasStartedPlan(BiblePlanType planType) => planProgressByType.containsKey(planType);

  bool hasCompletedPassage({required BiblePlanType planType, required int dayIndex, required VerseSelection passage}) =>
      planProgressByType[planType]?.days[dayIndex].isPassageComplete(passage) ?? false;

  bool hasCompletedPlanDay({required BiblePlanType planType, required int dayIndex}) =>
      planProgressByType[planType]?.days[dayIndex].isComplete ?? false;

  User withStartedPlan({required BiblePlanType planType, required BiblePlan plan}) =>
      planProgressByType.containsKey(planType)
      ? this
      : copyWith(
          planProgressByType: {
            ...planProgressByType,
            planType: BiblePlanProgress(days: plan.days.map((day) => BiblePlanDayProgress.incomplete()).toList()),
          },
        );

  User withStoppedPlan(BiblePlanType planType) =>
      copyWith(planProgressByType: {...planProgressByType}..remove(planType));

  User withCompletedPlan(BiblePlanType planType) => copyWith(
    planProgressByType: {...planProgressByType}..remove(planType),
    completedPlans: {...completedPlans, planType},
  );

  User withPassageToggled({
    required BiblePlanType planType,
    required int dayIndex,
    required BiblePlanDay day,
    required VerseSelection passage,
  }) => hasCompletedPassage(planType: planType, dayIndex: dayIndex, passage: passage)
      ? withPassageUncompleted(planType: planType, dayIndex: dayIndex, day: day, passage: passage)
      : withPassageCompleted(planType: planType, dayIndex: dayIndex, day: day, passage: passage);

  User withPlanDayToggled({required BiblePlanType planType, required int dayIndex}) => withProgressDayUpdated(
    planType: planType,
    dayIndex: dayIndex,
    updater: (dayProgress) => dayProgress.withCompletionToggled(),
  );

  User withProgressDayUpdated({
    required BiblePlanType planType,
    required int dayIndex,
    required BiblePlanDayProgress Function(BiblePlanDayProgress) updater,
  }) => withUpdatePlanProgress(
    planType,
    (progress) => progress.copyWith(days: progress.days.withUpdateAt(dayIndex, updater)),
  );

  User withPassageCompleted({
    required BiblePlanType planType,
    required int dayIndex,
    required BiblePlanDay day,
    required VerseSelection passage,
  }) => withProgressDayUpdated(
    planType: planType,
    dayIndex: dayIndex,
    updater: (dayProgress) => dayProgress.withPassageCompleted(day: day, passage: passage),
  );

  User withPassageUncompleted({
    required BiblePlanType planType,
    required int dayIndex,
    required BiblePlanDay day,
    required VerseSelection passage,
  }) => withProgressDayUpdated(
    planType: planType,
    dayIndex: dayIndex,
    updater: (dayProgress) => dayProgress.withPassageUncompleted(day: day, passage: passage),
  );

  User withUpdatePlanProgress(BiblePlanType planType, BiblePlanProgress Function(BiblePlanProgress) update) =>
      copyWith(planProgressByType: planProgressByType.withUpdate(planType, update));
}

Object? _readLastHighlightStyle(Map data, String key) {
  final existing = data[key];
  if (existing != null) {
    return existing;
  }

  final rawColor = data['highlightColor'];
  if (rawColor is String) {
    return HighlightStyle(color: ColorEnum.values.byName(rawColor), type: .highlight).toJson();
  }

  return null;
}
