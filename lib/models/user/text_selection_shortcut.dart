import 'package:bible/models/annotation.dart';
import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/text_selection_action.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

enum TextSelectionShortcut {
  annotate,
  highlight,
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
    BuildContext context,
    WidgetRef ref, {
    required BibleTextSelection textSelection,
    required Function() onDeselect,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) =>
      toTextSelectionAction()?.onPressed(
        context,
        ref,
        textSelection: textSelection,
        onDeselect: onDeselect,
        onNavigateToVerseSelection: onNavigateToVerseSelection,
      ) ??
      switch (this) {
        highlight => () async {
          onDeselect();

          ref.updateUser((user) {
            if (user.isTextSelectionAnnotated(textSelection)) {
              return user.withRemovedTextSelectionAnnotations(textSelection);
            } else {
              return user.withAnnotation(
                Annotation(
                  color: user.highlightColor,
                  selection: AnnotationSelection.text(textSelection: textSelection),
                ),
              );
            }
          });
        }(),
        _ => throw UnimplementedError(),
      };

  TextSelectionAction? toTextSelectionAction() => switch (this) {
    annotate => TextSelectionAction.annotate,
    search => TextSelectionAction.search,
    copy => TextSelectionAction.copy,
    _ => null,
  };

  bool _isAnnotated({User? user, BibleTextSelection? textSelection}) =>
      textSelection != null && user != null && user.isTextSelectionAnnotated(textSelection);
}
