import 'package:bible/models/main_action.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/region_type.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/models/study_panel.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/i18n/strings.g.dart';
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
  audio,
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
  plans,
  themeAndLayout;

  String title() =>
      toStudyAction()?.title() ??
      toMainAction()?.title() ??
      switch (this) {
        switchBible => t.toolbarShortcuts.switchBible,
        dictionary => t.toolbarShortcuts.dictionary,
        lexicon => t.toolbarShortcuts.lexicon,
        _ => t.toolbarShortcuts.themeAndLayout,
      };

  String description({User? user}) =>
      toStudyAction()?.description(regionFormat: null, regionType: RegionType.chapter) ??
      toMainAction()?.description(user: user) ??
      switch (this) {
        switchBible => t.toolbarShortcuts.switchBibleDescription,
        dictionary => t.toolbarShortcuts.dictionaryDescription,
        lexicon => t.toolbarShortcuts.lexiconDescription,
        _ => t.toolbarShortcuts.themeAndLayoutDescription,
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
        dictionary => () async {
          final result = await context.push<VerseSelection>(DictionaryPage());
          if (result != null) {
            onNavigateToVerseSelection(result);
          }
        }(),
        lexicon => () async {
          final result = await context.push<VerseSelection>(LexiconPage());
          if (result != null) {
            onNavigateToVerseSelection(result);
          }
        }(),
        themeAndLayout => context.push(ThemeSettingsPage()),
        _ => throw UnimplementedError(),
      };

  MainAction? toMainAction() => switch (this) {
    audio => .audio,
    bookmark => .bookmark,
    study => .study,
    search => .search,
    studyPanel => .studyPanel,
    resources => .resources,
    plans => .plans,
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
