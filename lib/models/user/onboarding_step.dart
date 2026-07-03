import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/symbols.dart';

class OnboardingState {
  final bool isVerseSelected;
  final bool isWordSelected;
  final bool isMainToolbarVisible;
  final bool hasStudyPanel;
  final bool isViewingStudyPanel;
  final bool hasHistory;

  const OnboardingState({
    required this.isVerseSelected,
    required this.isWordSelected,
    required this.isMainToolbarVisible,
    required this.hasStudyPanel,
    required this.isViewingStudyPanel,
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
  viewStudyPanel,
  navigateSomewhere;

  String title() => switch (this) {
    selectVerse => 'Select a verse',
    selectWord => 'Select a word',
    deselectEverything => 'Deselect everything',
    revealMainToolbar => 'Reveal the main toolbar',
    addStudyPanel => 'Add a study panel',
    viewStudyPanel => 'View the study panel',
    navigateSomewhere => 'Navigate to another chapter',
  };

  String detail() => switch (this) {
    selectVerse => 'Tap any verse in the Bible to select it.',
    selectWord => 'Long-press any word to select it, then keep dragging to select more.',
    deselectEverything => 'Tap the X on the selection toolbar, or tap your selection again, to clear it.',
    revealMainToolbar => 'Scroll up on the Bible to reveal the main toolbar along the bottom.',
    addStudyPanel => "Open the main toolbar's More menu and choose Add Study Panel.",
    viewStudyPanel => 'Swipe this onboarding panel to the right to reveal your study panel.',
    navigateSomewhere => 'Open the main toolbar, tap the reference, and type in another chapter.',
  };

  bool isCompleted(OnboardingState state) => switch (this) {
    selectVerse => state.isVerseSelected,
    selectWord => state.isWordSelected,
    deselectEverything => state.isNothingSelected,
    revealMainToolbar => state.isMainToolbarVisible,
    addStudyPanel => state.hasStudyPanel,
    viewStudyPanel => state.isViewingStudyPanel,
    navigateSomewhere => state.hasHistory,
  };
}

enum OnboardingStep {
  selectVerse,
  annotateVerse,
  crossReferences,
  selectWord,
  searchWord,
  changeBible,
  navigateChapter,
  goBack,
  addStudyPanel,
  openSettings,
  customizeToolbar;

  String title() => switch (this) {
    selectVerse => 'Select a verse',
    annotateVerse => 'Highlight a verse',
    crossReferences => 'View cross references',
    selectWord => 'Select a word',
    searchWord => 'Search for a word',
    changeBible => 'Switch your Bible',
    navigateChapter => 'Go to another chapter',
    goBack => 'Go back',
    addStudyPanel => 'Add a study panel',
    openSettings => 'Open Settings',
    customizeToolbar => 'Customize your verse toolbar',
  };

  String instructions() => switch (this) {
    selectVerse => 'Tap any verse to select it.',
    annotateVerse => 'With a verse selected, tap Annotate in the toolbar to highlight it.',
    crossReferences => 'With a verse selected, open the More menu in the toolbar, then Study → Cross References.',
    selectWord => 'Long-press a word to select it.',
    searchWord => 'With a word selected, tap Search to look it up across the Bible.',
    changeBible => 'Tap the main toolbar to switch Bibles.',
    navigateChapter => 'Tap the main toolbar and type in another chapter.',
    goBack => 'Swipe right on the main toolbar to jump back to where you were.',
    addStudyPanel => 'Open the More menu in the toolbar, add a study panel, then swipe over to view it.',
    openSettings => "Open the More menu in the toolbar and tap Settings.",
    customizeToolbar => 'In Settings → Verse Selection, change which shortcuts appear on a verse.',
  };

  IconData get icon => switch (this) {
    selectVerse => Symbols.touch_app,
    annotateVerse => Symbols.ink_highlighter,
    crossReferences => Symbols.graph_4,
    selectWord => Symbols.text_select_start,
    searchWord => Symbols.search,
    changeBible => Symbols.book,
    navigateChapter => Symbols.pin_drop,
    goBack => Symbols.undo,
    addStudyPanel => Symbols.dashboard,
    openSettings => Symbols.settings,
    customizeToolbar => Symbols.tune,
  };

  List<OnboardingMicroStep> get microSteps => switch (this) {
    selectVerse => [],
    annotateVerse => [.selectVerse],
    crossReferences => [.selectVerse],
    selectWord => [.deselectEverything],
    searchWord => [.selectWord],
    changeBible => [.deselectEverything, .revealMainToolbar],
    navigateChapter => [.deselectEverything, .revealMainToolbar],
    goBack => [.navigateSomewhere, .revealMainToolbar],
    addStudyPanel => [.deselectEverything, .revealMainToolbar, .addStudyPanel, .viewStudyPanel],
    openSettings => [.deselectEverything, .revealMainToolbar],
    customizeToolbar => [.deselectEverything, .revealMainToolbar],
  };
}
