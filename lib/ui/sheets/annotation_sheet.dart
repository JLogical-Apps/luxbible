import 'package:bible/models/annotation.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/dialog/styled_dialog.dart';
import 'package:bible/style/widgets/sheet/styled_port_sheet.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/style/widgets/styled_form_input.dart';
import 'package:bible/style/widgets/styled_port_field_builder.dart';
import 'package:bible/style/widgets/styled_select.dart';
import 'package:bible/style/widgets/styled_text_field.dart';
import 'package:bible/ui/pages/notebook_icon.dart';
import 'package:bible/ui/pages/notebooks_page.dart';
import 'package:bible/ui/widgets/colored_circle.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:port/port.dart';

class AnnotationSheet {
  static Future<Annotation?> show(
    BuildContext context, {
    Widget? subtitle,
    Annotation? annotation,
    required AnnotationSelection selection,
    Function(BuildContext)? onRemove,
  }) {
    final user = ref.read(userProvider);
    final initialNotebookId = annotation != null
        ? annotation.notebookId
        : user.getNotebookById(user.lastNotebookId)?.id;
    final initialColor = annotation?.color ?? user.getNotebookById(initialNotebookId)?.color ?? .stone;

    final port =
        Port.of({
          'color': SimplePortField<ColorEnum>(value: initialColor),
          'note': PortField.string(initialValue: annotation?.note),
          'notebookId': SimplePortField<String?>(value: initialNotebookId),
        }).map(
          (values, port) => Annotation(
            createdAt: annotation?.createdAt ?? .now(),
            selection: selection,
            color: values['color'],
            note: (values['note'] as String).trim(),
            notebookId: values['notebookId'],
          ),
        );

    return context.showStyledSheet(
      (context) => StyledPortSheet(
        title: (annotation == null ? 'Annotate' : 'Annotation').toText(),
        subtitle: subtitle,
        trailing: onRemove == null
            ? null
            : StyledCircleButton.lg(child: Symbols.ink_eraser.toIcon(), onPressed: () => onRemove(context)),
        port: port,
        childrenBuilder: (context, ref) => [
          if (user.notebooks.isNotEmpty)
            Consumer(
              builder: (context, ref, child) {
                final user = ref.watch(userProvider);
                return StyledPortFieldBuilder<String?>(
                  fieldPath: 'notebookId',
                  builder: (context, value, errorText, onChanged) => StyledSelect<String?>(
                    label: 'Notebook'.toText(),
                    options: [...user.notebooks.map((notebook) => notebook.id), null],
                    selectedOption: user.getNotebookById(value)?.id,
                    optionMapper: (id) {
                      final notebook = user.getNotebookById(id);
                      return StyledSelectOption(
                        title: (notebook?.name ?? 'Default').toText(),
                        leading: NotebookIcon(notebook: notebook),
                      );
                    },
                    onSelected: (id) => onChanged(id),
                    dialogTrailing: StyledCircleButton.md(
                      child: Symbols.tune.toIcon(),
                      onPressed: () {
                        context.pop();
                        context.push(NotebooksPage());
                      },
                    ),
                  ),
                );
              },
            ),
          StyledPortFieldBuilder<ColorEnum>(
            fieldPath: 'color',
            builder: (context, value, errorText, onChanged) => StyledFormInput(
              label: 'Color'.toText(),
              error: errorText?.toText(),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: ColorEnum.values
                    .map(
                      (color) => StyledCircleButton.lg(
                        child: ColoredCircle(color: color.toHue(context.colors).primary, isSelected: value == color),
                        onPressed: () => onChanged(color),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          StyledPortFieldBuilder<String>(
            fieldPath: 'note',
            builder: (context, value, errorText, onChanged) => StyledTextField.multiline(
              text: value,
              label: 'Note'.toText(),
              error: errorText?.toText(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> edit(BuildContext context, {required Annotation annotation}) async {
    final newAnnotation = await show(
      context,
      selection: annotation.selection,
      annotation: annotation,
      subtitle: annotation.formatLocation().toText(),
      onRemove: (context) async {
        final confirmed = await context.showStyledDialog(
          (context) => StyledDialog.confirmDelete(
            title: 'Delete Annotation'.toText(),
            body: 'Are you sure you want to delete this annotation?'.toText(),
          ),
        );
        if (confirmed == true && context.mounted) {
          ref.updateUser((user) => user.withRemovedAnnotation(annotation));
          context.pop();
        }
      },
    );
    if (newAnnotation != null) {
      ref.updateUser((user) => user.withAnnotationUpdated(annotation, newAnnotation));
    }
  }
}

class NewAnnotationSheet {
  static Future<Annotation?> show(
    BuildContext context, {
    required AnnotationSelection selection,
    Function()? onAnnotationsRemoved,
  }) async {
    final user = ref.read(userProvider);
    final selectionText = await ref.read(
      annotationSelectionTextProvider(translation: user.translation, selection: selection).future,
    );

    final hasAnnotation = selection.when(
      verses: (verseSelection) => user.isVerseSelectionAnnotated(verseSelection),
      text: (textSelection) => user.isTextSelectionAnnotated(textSelection),
    );

    if (!context.mounted) return null;

    return AnnotationSheet.show(
      context,
      selection: selection,
      subtitle: selectionText.toText(),
      onRemove: hasAnnotation
          ? (context) async {
              final confirmed = await context.showStyledDialog(
                (context) => StyledDialog.confirmDelete(
                  title: 'Delete Annotation'.toText(),
                  body: 'Are you sure you want to delete this annotation?'.toText(),
                ),
              );
              if (confirmed == true && context.mounted) {
                ref.updateUser((user) => user.withRemovedSelectionAnnotations(selection));
                onAnnotationsRemoved?.call();
                context.pop();
              }
            }
          : null,
    );
  }
}
