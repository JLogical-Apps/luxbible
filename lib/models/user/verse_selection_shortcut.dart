import 'package:bible/models/annotation.dart';
import 'package:bible/models/reference/region_type.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/study_action.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/models/verse_selection_action.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/sheets/annotation_sheet.dart';
import 'package:bible/ui/widgets/highlight_style_icon.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/cupertino.dart';
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
      toStudyAction()?.description(regionFormat: null, regionType: RegionType.verses) ??
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
              : user == null
              ? Icon(Symbols.highlighter_size_3)
              : HighlightStyleIcon(style: user.lastHighlightStyle),
        _ => throw UnimplementedError(),
      };

  Future<void> onPressed(
    BuildContext context, {
    required VerseSelection verseSelection,
    required Function() onDeselect,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) =>
      toStudyAction()?.onPressed(
        context,
        regionFormat: verseSelection.format(),
        verseSelection: verseSelection,
        onNavigateToVerseSelection: onNavigateToVerseSelection,
        user: ref.read(userProvider),
      ) ??
      toVerseSelectionAction()?.onPressed(
        context,
        selectedVerseSelection: verseSelection,
        onDeselect: onDeselect,
        onNavigateToVerseSelection: onNavigateToVerseSelection,
      ) ??
      switch (this) {
        highlight => () async {
          final rootContext = context.rootContext;
          onDeselect();

          final user = ref.read(userProvider);
          if (user.isVerseSelectionAnnotated(verseSelection)) {
            ref.updateUser((user) => user.withRemovedVerseSelectionAnnotations(verseSelection));
            return;
          }

          final annotation = Annotation(
            createdAt: .now(),
            style: user.lastHighlightStyle,
            selection: AnnotationSelection.verses(verseSelection: verseSelection),
          );
          ref.updateUser((user) => user.withAnnotation(annotation));

          if (!context.mounted) return;
          context.showStyledSnackbar(
            message: 'Highlighted ${verseSelection.format()}.'.toText(),
            duration: Duration(seconds: 8),
            action: StyledTextAction(
              label: 'Edit'.toText(),
              onPressed: () => AnnotationSheet.edit(rootContext, annotation: annotation),
            ),
          );
        }(),
        _ => throw UnimplementedError(),
      };

  VerseSelectionAction? toVerseSelectionAction() => switch (this) {
    study => .study,
    annotate => .annotate,
    copy => .copy,
    _ => null,
  };

  StudyAction? toStudyAction() => switch (this) {
    compare => .compare,
    interlinear => .interlinear,
    commentary => .commentary,
    crossReferences => .crossReferences,
    _ => null,
  };

  bool _isAnnotated({User? user, VerseSelection? verseSelection}) =>
      verseSelection != null && user != null && user.isVerseSelectionAnnotated(verseSelection);
}
