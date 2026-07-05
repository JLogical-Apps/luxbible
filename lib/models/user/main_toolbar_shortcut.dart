import 'package:bible/models/main_action.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/region_type.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/models/study_panel.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/pages/dictionary_page.dart';
import 'package:bible/ui/pages/lexicon_page.dart';
import 'package:bible/ui/pages/theme_settings_page.dart';
import 'package:bible/ui/sheets/bible_sheet.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum MainToolbarShortcut {
  bookmark,
  study,
  compare,
  interlinear,
  commentary,
  crossReferences,
  studyPanel,
  switchBible,
  search,
  resources,
  dictionary,
  lexicon,
  themeAndLayout;

  String title() =>
      toStudyAction()?.title() ??
      toMainAction()?.title() ??
      switch (this) {
        switchBible => 'Switch Bible',
        dictionary => 'Dictionary',
        lexicon => 'Lexicon',
        _ => 'Theme & Layout',
      };

  String description({User? user}) =>
      toStudyAction()?.description(regionFormat: null, regionType: RegionType.chapter) ??
      toMainAction()?.description(user: user) ??
      switch (this) {
        switchBible => 'Switch the Bible translation.',
        dictionary => 'Look up people, places, and topics in Easton\'s Bible Dictionary.',
        lexicon => 'Study the original Hebrew and Greek words with Strong\'s Lexicon.',
        _ => 'Customize the theme & layout of the Bible.',
      };

  Widget buildIcon(BuildContext context, {User? user}) =>
      toStudyAction()?.icon.mapIfNonNull(Icon.new) ??
      toMainAction()?.buildIcon(context, user: user) ??
      switch (this) {
        switchBible => Symbols.book.toIcon(),
        dictionary => Symbols.menu_book.toIcon(),
        lexicon => Symbols.translate.toIcon(),
        _ => Symbols.custom_typography.toIcon(),
      };

  Future<void> onPressed(
    BuildContext context, {
    required ChapterReference reference,
    required Function(VerseSelection) onNavigateToVerseSelection,
    required Function(StudyPanel) onAddStudyPanel,
  }) =>
      toStudyAction()?.onPressed(
        context,
        verseSelection: reference.toVerseSelection(),
        regionFormat: reference.format(),
        onNavigateToVerseSelection: onNavigateToVerseSelection,
        user: ref.read(userProvider),
      ) ??
      toMainAction()?.onPressed(
        context,
        reference: reference,
        onNavigateToVerseSelection: onNavigateToVerseSelection,
        onAddStudyPanel: onAddStudyPanel,
      ) ??
      switch (this) {
        switchBible => () async {
          final newTranslation = await BibleSheet.show(context);
          if (newTranslation != null) {
            ref.updateUser((user) => user.withTranslation(newTranslation));
          }
        }(),
        dictionary => context.push(DictionaryPage()),
        lexicon => () async {
          final result = await context.push<VerseSelection>(LexiconPage());
          if (result != null) {
            onNavigateToVerseSelection(result);
          }
        }(),
        _ => context.push(ThemeSettingsPage()),
      };

  MainAction? toMainAction() => switch (this) {
    bookmark => .bookmark,
    study => .study,
    search => .search,
    studyPanel => .studyPanel,
    resources => .resources,
    _ => null,
  };

  StudyAction? toStudyAction() => switch (this) {
    compare => .compare,
    interlinear => .interlinear,
    commentary => .commentary,
    crossReferences => .crossReferences,
    _ => null,
  };
}
