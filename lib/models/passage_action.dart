import 'package:bible/models/passage.dart';
import 'package:bible/models/user.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_color_sheet.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/ui/pages/commentaries_page.dart';
import 'package:bible/ui/pages/compare_page.dart';
import 'package:bible/ui/pages/interlinear_page.dart';
import 'package:bible/ui/widgets/colored_circle.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum PassageAction {
  highlight,
  highlightColor,
  compare,
  interlinear,
  commentary;

  String title({required User user, required Passage selectedPassage}) => switch (this) {
    highlight => user.isPassageHighlighted(selectedPassage) ? 'Remove Highlight' : 'Quick Highlight',
    highlightColor => 'Highlight',
    compare => 'Translation Compare',
    interlinear => 'Interlinear',
    commentary => 'Commentary',
  };

  String description({required User user, required Passage selectedPassage}) => switch (this) {
    highlight =>
      user.isPassageHighlighted(selectedPassage)
          ? 'Remove highlights from the selected passage.'
          : 'Highlight the selected passage with the last highlight color you used.',
    highlightColor => 'Choose a color to highlight for the selected passage.',
    compare => 'Compare the selected passage across a variety of translations.',
    interlinear => 'View a lexical breakdown of the selected passage using Strong\'s lexicon.',
    commentary => 'View commentary of the selected passage.',
  };

  Widget buildIcon(BuildContext context, {required User user, required Passage selectedPassage}) => switch (this) {
    highlight => Icon(
      user.isPassageHighlighted(selectedPassage) ? Symbols.ink_eraser : Symbols.format_ink_highlighter,
      color: user.isPassageHighlighted(selectedPassage) ? null : user.highlightColor.toHue(context.colors).primary,
    ),
    highlightColor => ColoredCircle(color: user.highlightColor.toHue(context.colors).primary, isSelected: true),
    compare => Icon(Symbols.text_compare),
    interlinear => Icon(Symbols.translate),
    commentary => Icon(Symbols.school),
  };

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required User user,
    required Passage selectedPassage,
    required Function() deselectVerses,
  }) async {
    switch (this) {
      case highlight:
        deselectVerses();
        ref.updateUser((user) => user.withToggledHighlight(passage: selectedPassage, color: user.highlightColor));
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
                      deselectVerses();
                      ref.updateUser((user) => user.withRemovedHighlight(passage: selectedPassage));
                    },
                  )
                : null,
          ),
        );
        if (newColor != null) {
          deselectVerses();
          ref.updateUser(
            (user) => user.withHighlight(passage: selectedPassage, color: newColor).copyWith(highlightColor: newColor),
          );
        }
      case compare:
        context.push(ComparePage(passage: selectedPassage));
      case interlinear:
        context.push(InterlinearPage(passage: selectedPassage));
      case commentary:
        context.push(CommentariesPage(passage: selectedPassage));
    }
  }
}
