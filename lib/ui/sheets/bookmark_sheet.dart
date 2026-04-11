import 'package:bible/models/bookmark.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/style/style.dart';
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
        port: Port.of({
          'color': SimplePortField<ColorEnum>(value: initialBookmark?.color ?? ColorEnum.stone),
          'name': PortField.string(initialValue: initialBookmark?.name).isNotBlank(),
        }).map((values, port) => Bookmark(chapter: reference, name: values['name'], color: values['color'])),
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
                        child: Stack(
                          children: [
                            Icon(Symbols.bookmark, color: color.toHue(context.colors).medium),
                            if (color == value) Icon(Symbols.bookmark, fill: 0),
                          ],
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
                StyledTextField(text: value, labelText: 'Name', errorText: errorText, onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}
