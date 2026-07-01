import 'package:bible/models/annotation.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_port_sheet.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/style/widgets/styled_form_input.dart';
import 'package:bible/style/widgets/styled_port_field_builder.dart';
import 'package:bible/style/widgets/styled_text_field.dart';
import 'package:bible/ui/widgets/colored_circle.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:port/port.dart';

class AnnotationSheet {
  static Future<Annotation?> show(
    BuildContext context, {
    Widget? subtitle,
    Annotation? annotation,
    required AnnotationSelection selection,
    Function(BuildContext)? onRemove,
  }) => context.showStyledSheet(
    (context) => StyledPortSheet(
      title: (annotation == null ? 'Annotate' : 'Annotation').toText(),
      subtitle: subtitle,
      trailing: onRemove == null
          ? null
          : StyledCircleButton.lg(child: Symbols.ink_eraser.toIcon(), onPressed: () => onRemove(context)),
      port:
          Port.of({
            'color': SimplePortField<ColorEnum>(value: annotation?.color ?? ColorEnum.stone),
            'note': PortField.string(initialValue: annotation?.note),
          }).map(
            (values, port) => Annotation(
              createdAt: annotation?.createdAt ?? .now(),
              selection: selection,
              color: values['color'],
              note: (values['note'] as String).trim(),
            ),
          ),
      childrenBuilder: (context) => [
        StyledPortFieldBuilder<ColorEnum>(
          fieldPath: 'color',
          builder: (context, value, errorText, onChanged) => StyledFormInput(
            labelText: 'Color',
            errorText: errorText,
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
          builder: (context, value, errorText, onChanged) =>
              StyledTextField.multiline(text: value, labelText: 'Note', errorText: errorText, onChanged: onChanged),
        ),
      ],
    ),
  );

  static Future<void> edit(BuildContext context, {required Annotation annotation}) async {
    final newAnnotation = await show(
      context,
      selection: annotation.selection,
      annotation: annotation,
      subtitle: annotation.formatLocation().toText(),
      onRemove: (context) {
        ref.updateUser((user) => user.withRemovedAnnotation(annotation));
        context.pop();
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
          ? (context) {
              ref.updateUser((user) => user.withRemovedSelectionAnnotations(selection));
              onAnnotationsRemoved?.call();
              context.pop();
            }
          : null,
    );
  }
}
