import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_port_sheet.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/style/widgets/styled_form_input.dart';
import 'package:bible/style/widgets/styled_port_field_builder.dart';
import 'package:bible/style/widgets/styled_text_field.dart';
import 'package:bible/ui/widgets/colored_circle.dart';
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
    required Region region,
    required Bible bible,
    required User user,
    Function()? onAnnotationsRemoved,
  }) {
    final hasAnnotation = region.when(
      passage: (passage) => user.isPassageAnnotated(passage),
      selection: (selection) => user.isSelectionAnnotated(selection),
      chapterReference: (reference) => throw UnimplementedError(),
    );
    return StyledPortSheet.show(
      context,
      titleText: 'Annotate',
      subtitleText: region.format(bible),
      trailing: hasAnnotation
          ? StyledCircleButton.lg(
              icon: Symbols.ink_eraser,
              onPressed: () {
                ref.updateUser((user) => user.withRemovedRegionAnnotations(region));
                onAnnotationsRemoved?.call();
                Navigator.of(context).pop();
              },
            )
          : null,
      port: Port.of({'color': SimplePortField<ColorEnum>(value: ColorEnum.stone), 'note': PortField.string()}).map(
        (values, port) => Annotation(
          passages: [if (region is Passage) region],
          selections: [if (region is Selection) region],
          createdAt: DateTime.now(),
          color: values['color'],
          note: (values['note'] as String).trim().nullIfBlank,
        ),
      ),
      childrenBuilder: (context) => [
        StyledPortFieldBuilder<ColorEnum>(
          fieldPath: 'color',
          builder: (context, value, errorText, onChanged) => StyledFormInput(
            labelText: 'Color',
            errorText: errorText,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}
