import 'package:bible/models/main_action.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum MainToolbarShortcut {
  bookmark,
  study,
  compare,
  interlinear,
  commentary,
  crossReferences,
  search;

  String title() => toStudyAction()?.title() ?? toMainAction()?.title() ?? (throw UnimplementedError());

  String description({User? user}) =>
      toStudyAction()?.description(region: null, regionType: RegionType.chapter) ??
      toMainAction()?.description(user: user) ??
      (throw UnimplementedError());

  Widget buildIcon(BuildContext context, {User? user}) =>
      toStudyAction()?.icon.mapIfNonNull(Icon.new) ??
      toMainAction()?.buildIcon(context, user: user) ??
      (throw UnimplementedError());

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required ChapterReference reference,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) =>
      toStudyAction()?.onPressed(
        context,
        ref,
        region: reference,
        onNavigateToVerseSelection: onNavigateToVerseSelection,
      ) ??
      toMainAction()?.onPressed(
        context,
        ref,
        reference: reference,
        onNavigateToVerseSelection: onNavigateToVerseSelection,
      ) ??
      (throw UnimplementedError());

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
