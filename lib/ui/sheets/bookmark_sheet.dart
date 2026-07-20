import 'package:bible/models/bookmark.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/chapter_position.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/selectable_icon.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:port/port.dart';

class BookmarkSheet {
  static Future<Bookmark?> show(
    BuildContext context, {
    Bookmark? initialBookmark,
    required ChapterReference reference,
  }) async {
    return await context.showStyledSheet(
      (context) => StyledPortSheet(
        title: Text(initialBookmark == null ? 'Create Bookmark' : 'Edit Bookmark'),
        port:
            Port.of({
              'color': SimplePortField<ColorEnum>(value: initialBookmark?.color ?? ColorEnum.stone),
              'name': PortField.string(initialValue: initialBookmark?.name).isNotBlank(),
            }).map(
              (values, port) => Bookmark(
                position: ChapterPosition(reference: reference),
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
                          Symbols.bookmark,
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
}
