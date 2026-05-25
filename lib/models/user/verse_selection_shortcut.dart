import 'package:bible/models/annotation.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/models/verse_selection_action.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

enum VerseSelectionShortcut {
  study,
  compare,
  interlinear,
  commentary,
  crossReferences,
  annotate,
  highlight,
  copy;

  String title({User? user, VerseSelection? verseSelection}) =>
      toStudyAction()?.title() ??
      toVerseSelectionAction()?.title() ??
      switch (this) {
        highlight => _isAnnotated(user: user, verseSelection: verseSelection) ? 'Remove Annotations' : 'Highlight',
        _ => throw UnimplementedError(),
      };

  String description({User? user, VerseSelection? verseSelection}) =>
      toStudyAction()?.description(region: null, regionType: RegionType.verses) ??
      toVerseSelectionAction()?.description() ??
      switch (this) {
        highlight =>
          _isAnnotated(user: user, verseSelection: verseSelection)
              ? 'Remove verse selection annotations from ${RegionType.verses.formatThis()}.'
              : 'Highlight ${RegionType.verses.formatThis()} with the last color you used.',
        _ => throw UnimplementedError(),
      };

  Widget buildIcon(BuildContext context, {User? user, VerseSelection? verseSelection}) =>
      toStudyAction()?.icon.mapIfNonNull(Icon.new) ??
      toVerseSelectionAction()?.icon.mapIfNonNull(Icon.new) ??
      switch (this) {
        highlight =>
          _isAnnotated(user: user, verseSelection: verseSelection)
              ? Icon(Symbols.ink_eraser)
              : Icon(Symbols.highlighter_size_3, color: user?.highlightColor.toHue(context.colors).primary),
        _ => throw UnimplementedError(),
      };

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required VerseSelection verseSelection,
    required Function() onDeselect,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) =>
      toStudyAction()?.onPressed(
        context,
        ref,
        region: verseSelection,
        onNavigateToVerseSelection: onNavigateToVerseSelection,
      ) ??
      toVerseSelectionAction()?.onPressed(
        context,
        ref,
        selectedVerseSelection: verseSelection,
        onDeselect: onDeselect,
        onNavigateToVerseSelection: onNavigateToVerseSelection,
      ) ??
      switch (this) {
        highlight => () async {
          onDeselect();

          ref.updateUser((user) {
            if (user.isVerseSelectionAnnotated(verseSelection)) {
              return user.withRemovedVerseSelectionAnnotations(verseSelection);
            } else {
              return user.withAnnotation(
                Annotation(
                  color: user.highlightColor,
                  selection: AnnotationSelection.verses(verseSelection: verseSelection),
                ),
              );
            }
          });
        }(),
        _ => throw UnimplementedError(),
      };

  VerseSelectionAction? toVerseSelectionAction() => switch (this) {
    study => VerseSelectionAction.study,
    annotate => VerseSelectionAction.annotate,
    copy => VerseSelectionAction.copy,
    _ => null,
  };

  StudyAction? toStudyAction() => switch (this) {
    compare => StudyAction.compare,
    interlinear => StudyAction.interlinear,
    commentary => StudyAction.commentary,
    crossReferences => StudyAction.crossReferences,
    _ => null,
  };

  bool _isAnnotated({User? user, VerseSelection? verseSelection}) =>
      verseSelection != null && user != null && user.isVerseSelectionAnnotated(verseSelection);
}
