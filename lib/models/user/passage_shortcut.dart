import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible.dart';
import 'package:bible/models/passage_action.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

enum PassageShortcut {
  study,
  compare,
  interlinear,
  commentary,
  annotate,
  highlight,
  copy;

  String title({required User? user, required Passage? passage}) =>
      toStudyAction()?.title() ??
      toPassageAction()?.title() ??
      switch (this) {
        highlight => _isAnnotated(user: user, passage: passage) ? 'Remove Annotations' : 'Highlight',
        _ => throw UnimplementedError(),
      };

  String description({required User? user, required Passage? passage}) =>
      toStudyAction()?.description(region: null, regionType: RegionType.passage) ??
      toPassageAction()?.description() ??
      switch (this) {
        highlight =>
          _isAnnotated(user: user, passage: passage)
              ? 'Remove passage annotations from ${RegionType.passage.formatThis()}.'
              : 'Highlight ${RegionType.passage.formatThis()} with the last color you used.',
        _ => throw UnimplementedError(),
      };

  Widget buildIcon(BuildContext context, {required User? user, required Passage? passage}) =>
      toStudyAction()?.icon.mapIfNonNull(Icon.new) ??
      toPassageAction()?.icon.mapIfNonNull(Icon.new) ??
      switch (this) {
        highlight =>
          _isAnnotated(user: user, passage: passage)
              ? Icon(Symbols.ink_eraser)
              : Icon(Symbols.highlighter_size_3, color: user?.highlightColor.toHue(context.colors).primary),
        _ => throw UnimplementedError(),
      };

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
      switch (this) {
        highlight => () async {
          onDeselect();

          if (user.isPassageAnnotated(passage)) {
            ref.updateUser((user) => user.withRemovedPassageAnnotations(passage));
          } else {
            ref.updateUser(
              (user) => user.withAnnotation(
                Annotation(createdAt: DateTime.now(), color: user.highlightColor, passages: [passage]),
              ),
            );
          }
        }(),
        _ => throw UnimplementedError(),
      };

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

  bool _isAnnotated({User? user, Passage? passage}) =>
      passage != null && user != null && user.isPassageAnnotated(passage);
}
