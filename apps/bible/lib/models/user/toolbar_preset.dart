import 'package:bible/models/user/main_toolbar_shortcut.dart';
import 'package:bible/models/user/text_selection_shortcut.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/models/user/verse_selection_shortcut.dart';
import 'package:collection/collection.dart';
import 'package:lux/i18n.dart';

enum ToolbarPreset {
  reader,
  noteTaker,
  studier;

  String title() => switch (this) {
    reader => t.toolbarPresets.reader,
    noteTaker => t.toolbarPresets.noteTaker,
    studier => t.toolbarPresets.studier,
  };

  String description() => switch (this) {
    reader => t.toolbarPresets.readerDescription,
    noteTaker => t.toolbarPresets.noteTakerDescription,
    studier => t.toolbarPresets.studierDescription,
  };

  List<MainToolbarShortcut> get mainPinnedShortcuts => [.bookmark, .search];
  MainToolbarShortcut get mainLongPressShortcut => this == reader ? .plans : .studyPanel;

  List<VerseSelectionShortcut> get versePinnedShortcuts => switch (this) {
    reader => [.annotate, .commentary, .compare],
    noteTaker => [.annotate, .highlight, .copy],
    studier => [.crossReferences, .commentary, .interlinear],
  };

  VerseSelectionShortcut get verseLongPressShortcut => switch (this) {
    reader || .noteTaker => .highlight,
    studier => .annotate,
  };

  List<TextSelectionShortcut> get textPinnedShortcuts => switch (this) {
    reader => [.annotate, .search, .copy],
    noteTaker => [.annotate, .highlight, .search],
    studier => [.annotate, .search, .interlinear],
  };

  TextSelectionShortcut get textLongPressShortcut => switch (this) {
    reader => .highlight,
    noteTaker => .highlight,
    studier => .annotate,
  };

  List<VerseSelectionShortcut> get prominentShortcuts => versePinnedShortcuts;

  bool matches(User user) =>
      ListEquality().equals(user.mainToolbar.pinnedShortcuts, mainPinnedShortcuts) &&
      user.mainToolbar.longPressShortcut == mainLongPressShortcut &&
      ListEquality().equals(user.verseSelection.pinnedShortcuts, versePinnedShortcuts) &&
      user.verseSelection.longPressShortcut == verseLongPressShortcut &&
      ListEquality().equals(user.textSelection.pinnedShortcuts, textPinnedShortcuts) &&
      user.textSelection.longPressShortcut == textLongPressShortcut;
}
