import 'package:bible/models/bible.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/models/toolbar_action.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum ToolbarShortcut {
  bookmark,
  study,
  compare,
  interlinear,
  commentary;

  String title({required User user, required ChapterReference? reference}) =>
      toStudyAction()?.title() ??
      toToolbarAction()?.title(user: user, reference: reference) ??
      (throw UnimplementedError());

  String description({required User user, required ChapterReference? reference}) =>
      toStudyAction()?.description(region: null, regionType: RegionType.chapter) ??
      toToolbarAction()?.description(user: user, reference: reference) ??
      (throw UnimplementedError());

  Widget buildIcon(BuildContext context, {required User user, required ChapterReference? reference}) =>
      toStudyAction()?.icon.mapIfNonNull(Icon.new) ??
      toToolbarAction()?.buildIcon(context, reference: reference, user: user) ??
      (throw UnimplementedError());

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required ChapterReference reference,
    required User user,
    required Bible bible,
  }) =>
      toStudyAction()?.onPressed(context, ref, region: reference, bible: bible) ??
      toToolbarAction()?.onPressed(context, ref, user: user, reference: reference, bible: bible) ??
      (throw UnimplementedError());

  ToolbarAction? toToolbarAction() => switch (this) {
    bookmark => ToolbarAction.bookmark,
    study => ToolbarAction.study,
    _ => null,
  };

  StudyAction? toStudyAction() => switch (this) {
    compare => StudyAction.compare,
    interlinear => StudyAction.interlinear,
    commentary => StudyAction.commentary,
    _ => null,
  };
}
