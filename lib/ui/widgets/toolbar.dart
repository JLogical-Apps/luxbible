import 'package:bible/models/bible_translation.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/user/toolbar_configuration.dart';
import 'package:bible/models/user/toolbar_shortcut.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class Toolbar extends StatelessWidget {
  final ToolbarConfiguration toolbar;
  final ChapterReference chapterReference;
  final BibleTranslation translation;
  final User user;

  final Function() onPressed;
  final Function()? onLongPressed;
  final Function(int shortcutIndex, ToolbarShortcut) onShorcutPressed;
  final Function() onMorePressed;

  final bool isEdit;
  final ColorBuilder? colorBuilder;

  const Toolbar({
    super.key,
    required this.toolbar,
    required this.chapterReference,
    required this.translation,
    required this.user,
    required this.onPressed,
    this.onLongPressed,
    required this.onShorcutPressed,
    required this.onMorePressed,
    this.isEdit = false,
    this.colorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return StyledMaterial(
      colorBuilder: colorBuilder ?? .surfacePrimary,
      borderRadius: .circular(999),
      padding: .only(left: 24, right: 12),
      onPressed: onPressed,
      onLongPressed: onLongPressed,
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: .centerLeft,
              child: Padding(
                padding: .symmetric(vertical: 16),
                child: Row(
                  spacing: 8,
                  children: [
                    Flexible(
                      child: Text(
                        chapterReference.book.title(),
                        style: context.textStyle.labelLg,
                        maxLines: 1,
                        overflow: .ellipsis,
                      ),
                    ),
                    Text(
                      chapterReference.chapterNum.toString(),
                      style: context.textStyle.labelLg,
                      maxLines: 1,
                      overflow: .ellipsis,
                    ),
                    StyledBadge(text: translation.title()),
                    gapW12,
                  ],
                ),
              ),
            ),
          ),
          ...toolbar.pinnedShortcuts.mapIndexed(
            (i, shortcut) => StyledEditBadge(
              isEdit: isEdit,
              child: Tooltip(
                message: shortcut.title(),
                child: StyledCircleButton.lg(
                  onPressed: () => onShorcutPressed(i, shortcut),
                  child: shortcut.buildIcon(context, user: user),
                ),
              ),
            ),
          ),
          StyledCircleButton.lg(onPressed: onMorePressed, child: Symbols.more_vert.toIcon()),
        ],
      ),
    );
  }
}
