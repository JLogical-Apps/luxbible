import 'package:bible/models/annotation.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/providers/bibles_provider.dart';
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
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:port/port.dart';

class AnnotationSheet {
  static Future<Annotation?> show(
    BuildContext context,
    WidgetRef ref, {
    Widget? subtitle,
    Annotation? annotation,
    required AnnotationSelection selection,
    Function()? onRemove,
  }) => context.showStyledSheet(
    (context) => StyledPortSheet(
      title: (annotation == null ? 'Annotate' : 'Annotation').toText(),
      subtitle: subtitle,
      trailing: onRemove == null
          ? null
          : StyledCircleButton.lg(child: Symbols.ink_eraser.toIcon(), onPressed: onRemove),
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
}

class NewAnnotationSheet {
  static Future<Annotation?> show(
    BuildContext context,
    WidgetRef ref, {
    required Region region,
    Function()? onAnnotationsRemoved,
  }) {
    final user = ref.read(userProvider);
    final bibles = ref.read(displayBiblesProvider);
    final bible = user.getDisplayBible(bibles);

    final hasAnnotation = region.when(
      verseSelection: (verseSelection) => user.isVerseSelectionAnnotated(verseSelection),
      textSelection: (textSelection) => user.isTextSelectionAnnotated(textSelection),
      chapterReference: (reference) => throw UnimplementedError(),
    );

    return AnnotationSheet.show(
      context,
      ref,
      selection: .fromRegion(region),
      subtitle: region.format(bible).toText(),
      onRemove: hasAnnotation
          ? () {
              ref.updateUser((user) => user.withRemovedRegionAnnotations(region));
              onAnnotationsRemoved?.call();
              context.pop();
            }
          : null,
    );
  }
}
