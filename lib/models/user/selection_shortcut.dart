import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/models/selection_action.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

enum SelectionShortcut {
  annotate,
  highlight,
  copy;

  String title({required User? user, required Selection? selection}) =>
      toSelectionAction()?.title() ??
      switch (this) {
        highlight => _isAnnotated(user: user, selection: selection) ? 'Remove Annotations' : 'Highlight',
        _ => throw UnimplementedError(),
      };

  String description({required User? user, required Selection? selection}) =>
      toSelectionAction()?.description() ??
      switch (this) {
        highlight =>
          _isAnnotated(user: user, selection: selection)
              ? 'Remove selection annotations from ${RegionType.selection.formatThis()}.'
              : 'Highlight ${RegionType.selection.formatThis()} with the last color you used.',
        _ => throw UnimplementedError(),
      };

  Widget buildIcon(BuildContext context, {required User? user, required Selection? selection}) =>
      toSelectionAction()?.icon.mapIfNonNull(Icon.new) ??
      switch (this) {
        highlight =>
          _isAnnotated(user: user, selection: selection)
              ? Icon(Symbols.ink_eraser)
              : Icon(Symbols.highlighter_size_3, color: user?.highlightColor.toHue(context.colors).primary),
        _ => throw UnimplementedError(),
      };

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required Selection selection,
    required User user,
    required Bible bible,
    required Function() onDeselect,
  }) =>
      toSelectionAction()?.onPressed(
        context,
        ref,
        selection: selection,
        bible: bible,
        user: user,
        onDeselect: onDeselect,
      ) ??
      switch (this) {
        highlight => () async {
          onDeselect();

          if (user.isSelectionAnnotated(selection)) {
            ref.updateUser((user) => user.withRemovedSelectionAnnotations(selection));
          } else {
            ref.updateUser(
              (user) => user.withAnnotation(
                Annotation(createdAt: DateTime.now(), color: user.highlightColor, selections: [selection]),
              ),
            );
          }
        }(),
        _ => throw UnimplementedError(),
      };

  SelectionAction? toSelectionAction() => switch (this) {
    annotate => SelectionAction.annotate,
    copy => SelectionAction.copy,
    _ => null,
  };

  bool _isAnnotated({User? user, Selection? selection}) =>
      selection != null && user != null && user.isSelectionAnnotated(selection);
}
