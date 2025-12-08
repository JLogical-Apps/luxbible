import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/models/user.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_color_sheet.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/ui/sheets/annotation_sheet.dart';
import 'package:bible/ui/widgets/colored_circle.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum SelectionAction {
  highlight,
  highlightColor,
  annotate,
  copy;

  String title({required User user, required Selection selection}) => switch (this) {
    highlight => user.isSelectionAnnotated(selection) ? 'Remove Highlight' : 'Quick Highlight',
    highlightColor => 'Highlight',
    annotate => 'Annotate',
    copy => 'Copy',
  };

  String description({required User user, required Selection selection}) => switch (this) {
    highlight =>
      user.isSelectionAnnotated(selection)
          ? 'Remove highlights from the selection.'
          : 'Highlight the selection with the last highlight color you used.',
    highlightColor => 'Choose a color to highlight for the selection.',
    annotate => 'Annotate the selection.',
    copy => 'Copy the selection to your clipboard.',
  };

  Widget buildIcon(BuildContext context, {required User user, required Selection selection}) => switch (this) {
    highlight => Icon(
      user.isSelectionAnnotated(selection) ? Symbols.ink_eraser : Symbols.format_ink_highlighter,
      color: user.isSelectionAnnotated(selection) ? null : user.highlightColor.toHue(context.colors).primary,
    ),
    highlightColor => ColoredCircle(color: user.highlightColor.toHue(context.colors).primary, isSelected: true),
    annotate => Icon(Symbols.note_stack),
    copy => Icon(Symbols.copy_all),
  };

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required User user,
    required Selection selection,
    required Bible bible,
    required Function() onDeselect,
  }) async {
    switch (this) {
      case highlight:
        onDeselect();
        if (user.isSelectionAnnotated(selection)) {
          ref.updateUser((user) => user.withRemovedSelectionAnnotations(selection));
        } else {
          ref.updateUser(
            (user) => user.withAnnotation(
              Annotation(createdAt: DateTime.now(), selections: [selection], color: user.highlightColor),
            ),
          );
        }
      case highlightColor:
        final newColor = await context.showStyledSheet(
          StyledColorSheet(
            titleText: 'Highlight Color',
            initialColor: user.highlightColor,
            trailing: user.isSelectionAnnotated(selection)
                ? StyledCircleButton.lg(
                    icon: Symbols.ink_eraser,
                    onPressed: () {
                      Navigator.of(context).pop();
                      onDeselect();
                      ref.updateUser((user) => user.withRemovedSelectionAnnotations(selection));
                    },
                  )
                : null,
          ),
        );
        if (newColor != null) {
          onDeselect();
          ref.updateUser(
            (user) => user
                .withAnnotation(Annotation(color: newColor, selections: [selection], createdAt: DateTime.now()))
                .copyWith(highlightColor: newColor),
          );
        }
      case annotate:
        final annotation = await AnnotationSheet.show(context, selections: [selection]);
        if (annotation != null) {
          ref.updateUser((user) => user.withAnnotation(annotation));
        }
      case copy:
        context.showStyledSnackbar(messageText: 'Selection copied to clipboard.');
        await Clipboard.setData(ClipboardData(text: bible.getSelectionText(selection)));
    }
  }
}
