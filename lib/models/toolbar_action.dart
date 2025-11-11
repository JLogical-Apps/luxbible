import 'package:bible/models/bookmark.dart';
import 'package:bible/models/chapter_reference.dart';
import 'package:bible/models/user.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_color_sheet.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

enum ToolbarAction {
  bookmark;

  Widget buildIcon(
    BuildContext context, {
    required User user,
    required ChapterReference reference,
  }) => switch (this) {
    bookmark => () {
      final bookmark = user.getBookmark(reference);
      return bookmark == null
          ? Icon(Symbols.bookmark, fill: 0)
          : Icon(Symbols.bookmark, color: bookmark.color.toHue(context.colors).medium);
    }(),
  };

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required User user,
    required ChapterReference reference,
  }) async {
    switch (this) {
      case bookmark:
        final bookmark = user.getBookmark(reference);
        if (bookmark == null) {
          final color = await context.showStyledSheet(
            StyledColorSheet(titleText: 'Bookmark Color'),
          );
          if (color != null) {
            ref.updateUser(
              (user) => user.withBookmark(Bookmark(key: reference.toKey(), color: color)),
            );
          }
        } else {
          ref.updateUser((user) => user.withRemovedBookmark(bookmark));
        }
    }
  }
}
