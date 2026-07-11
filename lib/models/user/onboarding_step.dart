import 'package:bible/models/bible/bible_translation.dart';
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
  customizeToolbar,
  startBiblePlan;

  List<InlineSpan> description({required BibleTranslation translation}) {
    WidgetSpan icon(IconData icon) => WidgetSpan(alignment: .middle, child: Icon(icon, size: 18));
    return switch (this) {
      selectVerse => [TextSpan(text: 'Tap a verse to select it')],
      selectWord => [TextSpan(text: 'Long-press a word')],
      deselectEverything => [
        TextSpan(text: 'Tap '),
        icon(Symbols.close),
        TextSpan(text: ' next to your selection to deselect'),
      ],
      revealMainToolbar => [TextSpan(text: 'Scroll up to reveal the main toolbar')],
      addStudyPanel => [
        TextSpan(text: 'Tap '),
        icon(Symbols.more_vert),
        TextSpan(text: ' → Add Study Panel and add any Study Panel'),
      ],
      navigateSomewhere => [TextSpan(text: 'Go to another chapter')],
      viewCrossReferences => [
        TextSpan(text: 'Open '),
        icon(Symbols.more_vert),
        TextSpan(text: ' → Study → Cross References'),
      ],
      annotateVerse => [
        TextSpan(text: 'Tap '),
        icon(Symbols.note_stack),
        TextSpan(text: ' to highlight or add a note'),
      ],
      searchWord => [TextSpan(text: 'Tap '), icon(Symbols.search), TextSpan(text: ' to look the word up everywhere')],
      switchBible => [TextSpan(text: 'Tap the main toolbar → ${translation.title()} to switch Bibles')],
      goToChapter => [TextSpan(text: 'Tap the main toolbar to go to another chapter')],
      goBack => [TextSpan(text: 'Swipe right on the toolbar to go back')],
      swipeChapter => [TextSpan(text: 'Swipe the Bible left or right to change chapter')],
      viewStudyPanel => [TextSpan(text: 'Swipe this panel right to view your study panel')],
      customizeToolbar => [
        TextSpan(text: 'Open '),
        icon(Symbols.more_vert),
        TextSpan(text: ' → '),
        icon(Symbols.settings),
        TextSpan(text: ' > Toolbars and pick a toolbar preset or change any of your toolbar shortcuts'),
      ],
      startBiblePlan => [
        TextSpan(text: 'Open '),
        icon(Symbols.more_vert),
        TextSpan(text: ' → Bible Plans and start any Bible plan'),
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
    crossReferences => 'View cross references',
    annotateVerse => 'Annotate a verse',
    searchWord => 'Search for a word',
    changeBible => 'Switch your Bible',
    navigateChapter => 'Go to another chapter',
    goBack => 'Go back',
    swipeChapter => 'Swipe to change chapter',
    addStudyPanel => 'Add a study panel',
    customizeToolbar => 'Customize your toolbars',
    startBiblePlan => 'Start a Bible plan',
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
