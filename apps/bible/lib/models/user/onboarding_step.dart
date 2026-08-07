import 'package:flutter/widgets.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';

class OnboardingState {
  final bool isVerseSelected;
  final bool isWordSelected;
  final bool isMainToolbarVisible;
  final bool hasStudyPanel;
  final bool hasHistory;

  const OnboardingState({
    required this.isVerseSelected,
    required this.isWordSelected,
    required this.isMainToolbarVisible,
    required this.hasStudyPanel,
    required this.hasHistory,
  });

  bool get isNothingSelected => !isVerseSelected && !isWordSelected;
}

enum OnboardingMicroStep {
  selectVerse,
  selectWord,
  deselectEverything,
  revealMainToolbar,
  addStudyPanel,
  navigateSomewhere,

  viewCrossReferences,
  annotateVerse,
  searchWord,
  switchBible,
  goToChapter,
  goBack,
  swipeChapter,
  viewStudyPanel,
  customizeToolbar,
  startBiblePlan;

  List<InlineSpan> description({required BibleTranslation translation}) {
    WidgetSpan icon(IconData icon) => WidgetSpan(alignment: .middle, child: Icon(icon, size: 18));
    return switch (this) {
      selectVerse => [TextSpan(text: t.onboardingSteps.selectVerse)],
      selectWord => [TextSpan(text: t.onboardingSteps.selectWord)],
      deselectEverything => [
        TextSpan(text: t.onboardingSteps.deselectPrefix),
        icon(Symbols.close),
        TextSpan(text: t.onboardingSteps.deselectSuffix),
      ],
      revealMainToolbar => [TextSpan(text: t.onboardingSteps.revealToolbar)],
      addStudyPanel => [
        TextSpan(text: t.onboardingSteps.addPanelPrefix),
        icon(Symbols.more_vert),
        TextSpan(text: t.onboardingSteps.addPanelSuffix),
      ],
      navigateSomewhere => [TextSpan(text: t.onboardingSteps.goToChapter)],
      viewCrossReferences => [
        TextSpan(text: t.onboardingSteps.openPrefix),
        icon(Symbols.more_vert),
        TextSpan(text: t.onboardingSteps.crossReferencesSuffix),
      ],
      annotateVerse => [
        TextSpan(text: t.onboardingSteps.annotatePrefix),
        icon(Symbols.note_stack),
        TextSpan(text: t.onboardingSteps.annotateSuffix),
      ],
      searchWord => [
        TextSpan(text: t.onboardingSteps.searchPrefix),
        icon(Symbols.search),
        TextSpan(text: t.onboardingSteps.searchSuffix),
      ],
      switchBible => [TextSpan(text: t.onboardingSteps.switchBibleDescription(translation: translation.title()))],
      goToChapter => [TextSpan(text: t.onboardingSteps.goToChapterDescription)],
      goBack => [TextSpan(text: t.onboardingSteps.goBackDescription)],
      swipeChapter => [TextSpan(text: t.onboardingSteps.swipeChapterDescription)],
      viewStudyPanel => [TextSpan(text: t.onboardingSteps.viewPanelDescription)],
      customizeToolbar => [
        TextSpan(text: t.onboardingSteps.openPrefix),
        icon(Symbols.more_vert),
        TextSpan(text: t.onboardingSteps.settingsSeparator),
        icon(Symbols.settings),
        TextSpan(text: t.onboardingSteps.customizeToolbarSuffix),
      ],
      startBiblePlan => [
        TextSpan(text: t.onboardingSteps.openPrefix),
        icon(Symbols.more_vert),
        TextSpan(text: t.onboardingSteps.startPlanSuffix),
      ],
    };
  }

  bool isCompleted(OnboardingState state) => switch (this) {
    selectVerse => state.isVerseSelected,
    selectWord => state.isWordSelected,
    deselectEverything => state.isNothingSelected,
    revealMainToolbar => state.isMainToolbarVisible,
    addStudyPanel => state.hasStudyPanel,
    navigateSomewhere => state.hasHistory,
    annotateVerse ||
    viewCrossReferences ||
    searchWord ||
    switchBible ||
    goToChapter ||
    goBack ||
    swipeChapter ||
    viewStudyPanel ||
    customizeToolbar ||
    startBiblePlan => false,
  };
}

enum OnboardingStep {
  crossReferences,
  annotateVerse,
  searchWord,
  changeBible,
  navigateChapter,
  goBack,
  swipeChapter,
  addStudyPanel,
  customizeToolbar,
  startBiblePlan;

  String title() => switch (this) {
    crossReferences => t.onboardingSteps.viewCrossReferences,
    annotateVerse => t.onboardingSteps.annotateVerse,
    searchWord => t.onboardingSteps.searchWord,
    changeBible => t.onboardingSteps.switchBible,
    navigateChapter => t.onboardingSteps.navigateChapter,
    goBack => t.onboardingSteps.goBack,
    swipeChapter => t.onboardingSteps.swipeChapter,
    addStudyPanel => t.onboardingSteps.addStudyPanel,
    customizeToolbar => t.onboardingSteps.customizeToolbar,
    startBiblePlan => t.onboardingSteps.startBiblePlan,
  };

  IconData get icon => switch (this) {
    crossReferences => Symbols.graph_4,
    annotateVerse => Symbols.note_stack,
    searchWord => Symbols.search,
    changeBible => Symbols.book,
    navigateChapter => Symbols.pin_drop,
    goBack => Symbols.undo,
    swipeChapter => Symbols.swipe,
    addStudyPanel => Symbols.add_notes,
    customizeToolbar => Symbols.tune,
    startBiblePlan => Symbols.calendar_month,
  };

  List<OnboardingMicroStep> get microSteps => switch (this) {
    crossReferences => [.selectVerse, .viewCrossReferences],
    annotateVerse => [.selectVerse, .annotateVerse],
    searchWord => [.selectWord, .searchWord],
    changeBible => [.deselectEverything, .revealMainToolbar, .switchBible],
    navigateChapter => [.deselectEverything, .revealMainToolbar, .goToChapter],
    goBack => [.navigateSomewhere, .deselectEverything, .revealMainToolbar, .goBack],
    swipeChapter => [.swipeChapter],
    addStudyPanel => [.deselectEverything, .revealMainToolbar, .addStudyPanel, .viewStudyPanel],
    customizeToolbar => [.deselectEverything, .revealMainToolbar, .customizeToolbar],
    startBiblePlan => [.deselectEverything, .revealMainToolbar, .startBiblePlan],
  };
}
