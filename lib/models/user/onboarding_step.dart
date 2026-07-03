import 'package:flutter/widgets.dart';
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
  openSettings,
  customizeToolbar;

  String title() => switch (this) {
    selectVerse => 'Select a verse',
    selectWord => 'Select a word',
    deselectEverything => 'Deselect everything',
    revealMainToolbar => 'Reveal the main toolbar',
    addStudyPanel => 'Add a study panel',
    navigateSomewhere => 'Navigate to another chapter',
    viewCrossReferences => 'View cross references',
    annotateVerse => 'Annotate the verse',
    searchWord => 'Search for the word',
    switchBible => 'Switch your Bible',
    goToChapter => 'Go to another chapter',
    goBack => 'Go back',
    swipeChapter => 'Swipe to change chapter',
    viewStudyPanel => 'View the study panel',
    openSettings => 'Open Settings',
    customizeToolbar => 'Customize your toolbars',
  };

  String detail() => switch (this) {
    selectVerse => 'Tap any verse in the Bible to select it.',
    selectWord => 'Long-press any word to select it, then keep dragging to select more.',
    deselectEverything => 'Tap the X on the selection toolbar, or tap your selection again, to clear it.',
    revealMainToolbar => 'Scroll up on the Bible to reveal the main toolbar along the bottom.',
    addStudyPanel => "Open the main toolbar's More menu and choose Add Study Panel.",
    navigateSomewhere => 'Open the main toolbar, tap the reference, and type in another chapter.',
    viewCrossReferences => 'Open the More menu in the toolbar, then Study → Cross References.',
    annotateVerse => 'Tap Annotate in the toolbar to highlight and add notes to a verse.',
    searchWord => 'Tap Search to look it up across the Bible.',
    switchBible => 'Tap the main toolbar to switch Bibles.',
    goToChapter => 'Tap the main toolbar and navigate to another chapter.',
    goBack => 'Swipe right on the main toolbar to jump back to where you were.',
    swipeChapter => 'Swipe left or right on the Bible to move to the next or previous chapter.',
    viewStudyPanel => 'Swipe this Get Started panel to the right to reveal your study panel.',
    openSettings => 'Open the More menu in the toolbar and tap Settings.',
    customizeToolbar => 'In Settings, pick a toolbar preset or change your toolbar shortcuts.',
  };

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
    openSettings ||
    customizeToolbar => false,
  };
}

enum OnboardingStep {
  selectVerse,
  crossReferences,
  annotateVerse,
  selectWord,
  searchWord,
  changeBible,
  navigateChapter,
  goBack,
  swipeChapter,
  addStudyPanel,
  openSettings,
  customizeToolbar;

  String title() => switch (this) {
    selectVerse => 'Select a verse',
    crossReferences => 'View cross references',
    annotateVerse => 'Annotate a verse',
    selectWord => 'Select a word',
    searchWord => 'Search for a word',
    changeBible => 'Switch your Bible',
    navigateChapter => 'Go to another chapter',
    goBack => 'Go back',
    swipeChapter => 'Swipe to change chapter',
    addStudyPanel => 'Add a study panel',
    openSettings => 'Open Settings',
    customizeToolbar => 'Customize your toolbars',
  };

  String description() => switch (this) {
    selectVerse =>
      'Selecting a verse lets you act on it, such as highlighting it, studying it, or exploring related passages.',
    crossReferences =>
      'You can act on selected verses by tapping the More menu in the toolbar. Cross references connect a verse to related passages throughout Scripture. This is just one of the ways you can study a verse.',
    annotateVerse =>
      'With a verse selected, you can highlight it or add notes to it. Shortcuts on your toolbar allow you to quickly perform repeated actions.',
    selectWord =>
      'Selecting a word lets you act on it, such as highlighting it, studying it, or searching for it everywhere else.',
    searchWord => 'Searching shows you every place a word appears across the Bible.',
    changeBible => 'Switch your Bible with a tap to study in whichever translation suits you best.',
    navigateChapter => 'Jump straight to any chapter to keep your study moving.',
    goBack => 'Quickly return to where you were after exploring somewhere else by swiping on the toolbar.',
    swipeChapter => 'Swiping the Bible is the fastest way to move through chapters as you read.',
    addStudyPanel => 'Study panels keep your study side-by-side with the text.',
    openSettings => 'Settings is where you customize Lux to fit the way you study.',
    customizeToolbar => 'Customizing your toolbars puts the actions you use most within easy reach.',
  };

  IconData get icon => switch (this) {
    selectVerse => Symbols.touch_app,
    crossReferences => Symbols.graph_4,
    annotateVerse => Symbols.note_stack,
    selectWord => Symbols.text_select_start,
    searchWord => Symbols.search,
    changeBible => Symbols.book,
    navigateChapter => Symbols.pin_drop,
    goBack => Symbols.undo,
    swipeChapter => Symbols.swipe,
    addStudyPanel => Symbols.add_notes,
    openSettings => Symbols.settings,
    customizeToolbar => Symbols.tune,
  };

  List<OnboardingMicroStep> get microSteps => switch (this) {
    selectVerse => [.selectVerse],
    crossReferences => [.selectVerse, .viewCrossReferences],
    annotateVerse => [.selectVerse, .annotateVerse],
    selectWord => [.deselectEverything, .selectWord],
    searchWord => [.selectWord, .searchWord],
    changeBible => [.deselectEverything, .revealMainToolbar, .switchBible],
    navigateChapter => [.deselectEverything, .revealMainToolbar, .goToChapter],
    goBack => [.navigateSomewhere, .revealMainToolbar, .goBack],
    swipeChapter => [.swipeChapter],
    addStudyPanel => [.deselectEverything, .revealMainToolbar, .addStudyPanel, .viewStudyPanel],
    openSettings => [.deselectEverything, .revealMainToolbar, .openSettings],
    customizeToolbar => [.deselectEverything, .revealMainToolbar, .customizeToolbar],
  };
}
