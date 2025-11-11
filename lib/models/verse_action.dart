import 'package:bible/models/passage.dart';
import 'package:bible/models/user.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_color_sheet.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/ui/widgets/colored_circle.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum VerseAction {
  highlight,
  highlightColor;

  Widget buildIcon(
    BuildContext context, {
    required User user,
    required Passage selectedPassage,
  }) => switch (this) {
    highlight => Icon(
      user.isPassageHighlighted(selectedPassage)
          ? Symbols.ink_eraser
          : Symbols.format_ink_highlighter,
      color: user.isPassageHighlighted(selectedPassage)
          ? null
          : user.highlightColor.toHue(context.colors).primary,
    ),
    highlightColor => ColoredCircle(
      color: user.highlightColor.toHue(context.colors).primary,
      isSelected: true,
    ),
  };

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required User user,
    required Passage selectedPassage,
  }) async {
    switch (this) {
      case highlight:
        ref.updateUser(
          (user) => user.withToggledHighlight(
            passage: selectedPassage,
            color: user.highlightColor,
          ),
        );
      case highlightColor:
        final newColor = await context.showStyledSheet(
          StyledColorSheet(
            titleText: 'Highlight Color',
            initialColor: user.highlightColor,
            trailing: user.isPassageHighlighted(selectedPassage)
                ? StyledCircleButton(
                    icon: Symbols.ink_eraser,
                    onPressed: () {
                      Navigator.of(context).pop();
                      ref.updateUser(
                        (user) => user.withRemovedHighlight(passage: selectedPassage),
                      );
                    },
                  )
                : null,
          ),
        );
        if (newColor != null) {
          ref.updateUser(
            (user) => user
                .withHighlight(passage: selectedPassage, color: newColor)
                .copyWith(highlightColor: newColor),
          );
        }
    }
  }
}
