import 'package:bible/models/bookmark.dart';
import 'package:bible/models/color_enum.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:port/port.dart';
import 'package:style/style.dart';

class BookmarkSheet {
  static Future<Bookmark?> show(
    BuildContext context, {
    Bookmark? initialBookmark,
    required ChapterReference reference,
  }) async {
    return await context.showStyledSheet(
      (context) => StyledPortSheet(
        title: Text(initialBookmark == null ? t.bookmarks.create : t.bookmarks.edit),
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
              label: t.labels.color.toText(),
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
            builder: (context, value, errorText, onChanged) => StyledTextField(
              text: value,
              label: t.labels.name.toText(),
              error: errorText?.toText(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
