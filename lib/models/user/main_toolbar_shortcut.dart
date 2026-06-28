import 'package:bible/models/main_action.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/region_type.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/models/study_panel.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/pages/theme_settings_page.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum MainToolbarShortcut {
  bookmark,
  study,
  compare,
  interlinear,
  commentary,
  crossReferences,
  search,
  themeAndLayout;

  String title() => toStudyAction()?.title() ?? toMainAction()?.title() ?? 'Theme & Layout';

  String description({User? user}) =>
      toStudyAction()?.description(regionFormat: null, regionType: RegionType.chapter) ??
      toMainAction()?.description(user: user) ??
      'Customize the theme & layout of the Bible.';

  Widget buildIcon(BuildContext context, {User? user}) =>
      toStudyAction()?.icon.mapIfNonNull(Icon.new) ??
      toMainAction()?.buildIcon(context, user: user) ??
      Symbols.custom_typography.toIcon();

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
      context.push(ThemeSettingsPage());

  MainAction? toMainAction() => switch (this) {
    bookmark => MainAction.bookmark,
    study => MainAction.study,
    search => MainAction.search,
    _ => null,
  };

  StudyAction? toStudyAction() => switch (this) {
    compare => StudyAction.compare,
    interlinear => StudyAction.interlinear,
    commentary => StudyAction.commentary,
    crossReferences => StudyAction.crossReferences,
    _ => null,
  };
}
