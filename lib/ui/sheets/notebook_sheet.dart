import 'package:bible/models/color_enum.dart';
import 'package:bible/models/notebook.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/selectable_icon.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:port/port.dart';
import 'package:uuid/uuid.dart';

class NotebookSheet {
  static Future<Notebook?> show(BuildContext context, {Notebook? initialNotebook}) => context.showStyledSheet(
    (context) => StyledPortSheet(
      title: (initialNotebook == null ? 'Create Notebook' : 'Edit Notebook').toText(),
      port:
          Port.of({
            'color': SimplePortField<ColorEnum>(value: initialNotebook?.color ?? ColorEnum.stone),
            'name': PortField.string(initialValue: initialNotebook?.name).isNotBlank(),
          }).map(
            (values, port) => (initialNotebook ?? Notebook(id: initialNotebook?.id ?? Uuid().v4(), name: '')).copyWith(
              name: values['name'],
              color: values['color'],
            ),
          ),
      childrenBuilder: (context, ref) => [
        StyledPortFieldBuilder<ColorEnum>(
          fieldPath: 'color',
          builder: (context, value, errorText, onChanged) => StyledFormInput(
            label: 'Color'.toText(),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: ColorEnum.values
                  .map(
                    (color) => StyledCircleButton.md(
                      child: SelectableIcon(
                        Symbols.book_2,
                        isSelected: color == value,
                        color: color.toHue(context.colors).medium,
                      ),
                      onPressed: () => onChanged(color),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        StyledPortFieldBuilder<String>(
          fieldPath: 'name',
          builder: (context, value, errorText, onChanged) =>
              StyledTextField(text: value, label: 'Name'.toText(), error: errorText?.toText(), onChanged: onChanged),
        ),
      ],
    ),
  );
}
