import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/user.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_color_sheet.dart';
import 'package:bible/style/widgets/sheet/styled_port_sheet.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/style/widgets/styled_port_field_builder.dart';
import 'package:bible/style/widgets/styled_text_field.dart';
import 'package:bible/ui/pages/commentaries_page.dart';
import 'package:bible/ui/pages/compare_page.dart';
import 'package:bible/ui/pages/interlinear_page.dart';
import 'package:bible/ui/widgets/colored_circle.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:port/port.dart';

enum PassageAction {
  highlight,
  highlightColor,
  note,
  copy,
  compare,
  interlinear,
  commentary;

  String title({required User user, required Passage selectedPassage}) => switch (this) {
    highlight => user.isPassageAnnotated(selectedPassage) ? 'Remove Highlight' : 'Quick Highlight',
    highlightColor => 'Highlight',
    note => 'Note',
    copy => 'Copy',
    compare => 'Translation Compare',
    interlinear => 'Interlinear',
    commentary => 'Commentary',
  };

  String description({required User user, required Passage selectedPassage}) => switch (this) {
    highlight =>
      user.isPassageAnnotated(selectedPassage)
          ? 'Remove highlights from the selected passage.'
          : 'Highlight the selected passage with the last highlight color you used.',
    highlightColor => 'Choose a color to highlight for the selected passage.',
    note => 'Add a note to the selected passage.',
    copy => 'Copy the selected passage to your clipboard.',
    compare => 'Compare the selected passage across a variety of translations.',
    interlinear => 'View a lexical breakdown of the selected passage using Strong\'s lexicon.',
    commentary => 'View commentary of the selected passage.',
  };

  Widget buildIcon(BuildContext context, {required User user, required Passage selectedPassage}) => switch (this) {
    highlight => Icon(
      user.isPassageAnnotated(selectedPassage) ? Symbols.ink_eraser : Symbols.format_ink_highlighter,
      color: user.isPassageAnnotated(selectedPassage) ? null : user.highlightColor.toHue(context.colors).primary,
    ),
    highlightColor => ColoredCircle(color: user.highlightColor.toHue(context.colors).primary, isSelected: true),
    note => Icon(Symbols.note_add),
    copy => Icon(Symbols.copy_all),
    compare => Icon(Symbols.text_compare),
    interlinear => Icon(Symbols.translate),
    commentary => Icon(Symbols.school),
  };

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required User user,
    required Passage selectedPassage,
    required Bible bible,
    required Function() onDeselect,
  }) async {
    switch (this) {
      case highlight:
        onDeselect();
        if (user.isPassageAnnotated(selectedPassage)) {
          ref.updateUser((user) => user.withRemovedPassageAnnotations(selectedPassage));
        } else {
          ref.updateUser(
            (user) => user.withAnnotation(
              Annotation(createdAt: DateTime.now(), passages: [selectedPassage], color: user.highlightColor),
            ),
          );
        }
      case highlightColor:
        final newColor = await context.showStyledSheet(
          StyledColorSheet(
            titleText: 'Highlight Color',
            initialColor: user.highlightColor,
            trailing: user.isPassageAnnotated(selectedPassage)
                ? StyledCircleButton(
                    icon: Symbols.ink_eraser,
                    onPressed: () {
                      Navigator.of(context).pop();
                      onDeselect();
                      ref.updateUser((user) => user.withRemovedPassageAnnotations(selectedPassage));
                    },
                  )
                : null,
          ),
        );
        if (newColor != null) {
          onDeselect();
          ref.updateUser(
            (user) => user
                .withAnnotation(Annotation(color: newColor, passages: [selectedPassage], createdAt: DateTime.now()))
                .copyWith(highlightColor: newColor),
          );
        }
      case note:
        final note = await StyledPortSheet.show(
          context,
          titleText: 'Add Note',
          port: Port.of({'note': PortField.string().isNotBlank()}).map((values, port) => values['note'] as String),
          childrenBuilder: (context) => [
            StyledPortFieldBuilder<String>(
              fieldPath: 'note',
              builder: (context, value, errorText, onChanged) =>
                  StyledTextField(text: value, labelText: 'Note', errorText: errorText, onChanged: onChanged),
            ),
          ],
        );
        if (note != null) {
          ref.updateUser(
            (user) => user.withAnnotation(
              Annotation(passages: [selectedPassage], createdAt: DateTime.now(), color: ColorEnum.stone, note: note),
            ),
          );
        }
      case copy:
        context.showStyledSnackbar(messageText: '${selectedPassage.format()} copied to clipboard.');
        await Clipboard.setData(
          ClipboardData(
            text: selectedPassage.references.map((reference) => bible.getVerseByReference(reference).text).join(),
          ),
        );
      case compare:
        context.push(ComparePage(passage: selectedPassage));
      case interlinear:
        context.push(InterlinearPage(passage: selectedPassage));
      case commentary:
        context.push(CommentariesPage(passage: selectedPassage));
    }
  }
}
