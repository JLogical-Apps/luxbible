import 'package:bible/models/annotation.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_port_sheet.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/style/widgets/styled_form_input.dart';
import 'package:bible/style/widgets/styled_port_field_builder.dart';
import 'package:bible/style/widgets/styled_text_field.dart';
import 'package:bible/ui/widgets/colored_circle.dart';
import 'package:flutter/material.dart';
import 'package:port/port.dart';

class AnnotationSheet {
  static Future<Annotation?> show(
    BuildContext context, {
    List<Selection> selections = const [],
    List<Passage> passages = const [],
  }) => StyledPortSheet.show(
    context,
    titleText: 'Annotate',
    port:
        Port.of({
          'color': SimplePortField<ColorEnum>(value: ColorEnum.stone),
          'note': PortField.string().isNotBlank(),
        }).map(
          (values, port) => Annotation(
            passages: passages,
            selections: selections,
            createdAt: DateTime.now(),
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
