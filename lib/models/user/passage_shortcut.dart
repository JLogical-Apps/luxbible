import 'package:bible/models/bible.dart';
import 'package:bible/models/passage_action.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/models/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum PassageShortcut {
  study,
  compare,
  interlinear,
  commentary,
  annotate,
  copy;

  String title() => toStudyAction()?.title() ?? toPassageAction()?.title() ?? (throw UnimplementedError());

  String description() =>
      toStudyAction()?.description(region: null, regionType: RegionType.passage) ??
      toPassageAction()?.description() ??
      (throw UnimplementedError());

  IconData get icon => toStudyAction()?.icon ?? toPassageAction()?.icon ?? (throw UnimplementedError());

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required Passage passage,
    required User user,
    required Bible bible,
    required Function() onDeselect,
  }) =>
      toStudyAction()?.onPressed(context, ref, region: passage, bible: bible) ??
      toPassageAction()?.onPressed(
        context,
        ref,
        user: user,
        selectedPassage: passage,
        bible: bible,
        onDeselect: onDeselect,
      ) ??
      (throw UnimplementedError());

  PassageAction? toPassageAction() => switch (this) {
    study => PassageAction.study,
    annotate => PassageAction.annotate,
    copy => PassageAction.copy,
    _ => null,
  };

  StudyAction? toStudyAction() => switch (this) {
    compare => StudyAction.compare,
    interlinear => StudyAction.interlinear,
    commentary => StudyAction.commentary,
    _ => null,
  };
}
