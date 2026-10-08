import 'package:bible/models/main_action.dart';
import 'package:bible/models/reference/region_type.dart';
import 'package:bible/models/resource_type.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/models/study_panel.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/pages/lexicon_page.dart';
import 'package:bible/ui/pages/theme_settings_page.dart';
import 'package:bible/ui/sheets/bible_sheet.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:utils_core/utils_core.dart';

enum MainToolbarShortcut {
  audio,
  bookmark,
  study,
  verseOfTheDay,
  compare,
  interlinear,
  commentary,
  crossReferences,
  linkedResources,
  studyPanel,
  switchBible,
  search,
  resources,
  people,
  themes,
  dictionary,
  maps,
  videos,
  creeds,
  lexicon,
  plans,
  themeAndLayout;

  String title() =>
      toStudyAction()?.title() ??
      toMainAction()?.title() ??
      toResourceType()?.title() ??
      switch (this) {
        switchBible => t.toolbarShortcuts.switchBible,
        lexicon => t.toolbarShortcuts.lexicon,
        _ => t.toolbarShortcuts.themeAndLayout,
      };

  String description({User? user}) =>
      toStudyAction()?.description(regionFormat: null, regionType: RegionType.chapter) ??
      toMainAction()?.description(user: user) ??
      toResourceType()?.description() ??
      switch (this) {
        switchBible => t.toolbarShortcuts.switchBibleDescription,
        lexicon => t.toolbarShortcuts.lexiconDescription,
        _ => t.toolbarShortcuts.themeAndLayoutDescription,
      };

  Widget buildIcon(BuildContext context, {User? user}) =>
      toStudyAction()?.icon.mapIfNonNull(Icon.new) ??
      toMainAction()?.buildIcon(context, user: user) ??
      toResourceType()?.icon.toIcon() ??
      switch (this) {
        switchBible => Symbols.book.toIcon(),
        lexicon => Symbols.translate.toIcon(),
        _ => Symbols.custom_typography.toIcon(),
      };

  Future<void> onPressed(
    BuildContext context, {
    required ChapterReference reference,
    required Function(VerseSelection) onNavigateToVerseSelection,
    required Function(StudyPanel) onAddStudyPanel,
    required Function(String bookmarkId) onBookmarkAdded,
  }) =>
      toStudyAction()?.onPressed(
        context,
        verseSelection: reference.toVerseSelection(),
        regionFormat: reference.format(),
        onNavigateToVerseSelection: onNavigateToVerseSelection,
        onAddStudyPanel: onAddStudyPanel,
        user: ref.read(userProvider),
      ) ??
      toMainAction()?.onPressed(
        context,
        reference: reference,
        onNavigateToVerseSelection: onNavigateToVerseSelection,
        onAddStudyPanel: onAddStudyPanel,
        onBookmarkAdded: onBookmarkAdded,
      ) ??
      toResourceType()?.page.mapIfNonNull((page) async {
        final result = await context.push(page);
        if (result != null) {
          onNavigateToVerseSelection(result);
        }
      }) ??
      switch (this) {
        switchBible => () async {
          final newTranslation = await BibleSheet.show(context);
          if (newTranslation != null) {
            ref.updateUser((user) => user.withTranslation(newTranslation));
          }
        }(),
        lexicon => () async {
          final result = await context.push(LexiconPage());
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
    verseOfTheDay => .verseOfTheDay,
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
    linkedResources => .linkedResources,
    _ => null,
  };

  ResourceType? toResourceType() => switch (this) {
    people => .people,
    themes => .themes,
    dictionary => .dictionary,
    maps => .maps,
    videos => .videos,
    creeds => .creeds,
    _ => null,
  };
}
