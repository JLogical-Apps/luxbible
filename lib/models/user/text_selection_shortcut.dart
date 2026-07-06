import 'package:bible/models/annotation.dart';
import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/region_type.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/text_selection_action.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/styled_text_action.dart';
import 'package:bible/ui/sheets/annotation_sheet.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_symbols_icons/symbols.dart';

enum TextSelectionShortcut {
  annotate,
  highlight,
  interlinear,
  search,
  copy;

  String title({User? user, BibleTextSelection? textSelection}) =>
      toTextSelectionAction()?.title() ??
      switch (this) {
        highlight => _isAnnotated(user: user, textSelection: textSelection) ? 'Remove Annotations' : 'Highlight',
        _ => throw UnimplementedError(),
      };

  String description({User? user, BibleTextSelection? textSelection}) =>
      toTextSelectionAction()?.description() ??
      switch (this) {
        highlight =>
          _isAnnotated(user: user, textSelection: textSelection)
              ? 'Remove text selection annotations from ${RegionType.text.formatThis()}.'
              : 'Highlight ${RegionType.text.formatThis()} with the last color you used.',
        _ => throw UnimplementedError(),
      };

  Widget buildIcon(BuildContext context, {User? user, BibleTextSelection? textSelection}) =>
      toTextSelectionAction()?.icon.mapIfNonNull(Icon.new) ??
      switch (this) {
        highlight =>
          _isAnnotated(user: user, textSelection: textSelection)
              ? Icon(Symbols.ink_eraser)
              : Icon(Symbols.highlighter_size_3, color: user?.highlightColor.toHue(context.colors).primary),
        _ => throw UnimplementedError(),
      };

  Future<void> onPressed(
    BuildContext context, {
    required BibleTextSelection textSelection,
    required Function() onDeselect,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) =>
      toTextSelectionAction()?.onPressed(
        context,
        textSelection: textSelection,
        onDeselect: onDeselect,
        onNavigateToVerseSelection: onNavigateToVerseSelection,
      ) ??
      switch (this) {
        highlight => () async {
          final rootContext = context.rootContext;
          onDeselect();

          final user = ref.read(userProvider);
          if (user.isTextSelectionAnnotated(textSelection)) {
            ref.updateUser((user) => user.withRemovedTextSelectionAnnotations(textSelection));
            return;
          }

          final annotation = Annotation(
            createdAt: .now(),
            color: user.highlightColor,
            selection: AnnotationSelection.text(textSelection: textSelection),
          );
          ref.updateUser((user) => user.withAnnotation(annotation));

          if (!context.mounted) return;
          context.showStyledSnackbar(
            message: 'Highlighted text in ${textSelection.toVerseSelection().format()}.'.toText(),
            duration: Duration(seconds: 8),
            action: StyledTextAction(
              label: 'Edit'.toText(),
              onPressed: () => AnnotationSheet.edit(rootContext, annotation: annotation),
            ),
          );
        }(),
        _ => throw UnimplementedError(),
      };

  TextSelectionAction? toTextSelectionAction() => switch (this) {
    annotate => .annotate,
    interlinear => .interlinear,
    search => .search,
    copy => .copy,
    _ => null,
  };

  bool _isAnnotated({User? user, BibleTextSelection? textSelection}) =>
      textSelection != null && user != null && user.isTextSelectionAnnotated(textSelection);
}
