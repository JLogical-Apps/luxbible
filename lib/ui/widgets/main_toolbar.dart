import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/user/main_toolbar_configuration.dart';
import 'package:bible/models/user/main_toolbar_shortcut.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class MainToolbar extends StatelessWidget {
  final MainToolbarConfiguration mainToolbar;
  final ChapterReference chapterReference;
  final BibleTranslation translation;
  final User? user;

  final Function()? onPressed;
  final Function()? onLongPressed;
  final Function()? onSwipeLeft;
  final Function()? onSwipeRight;
  final Function(int shortcutIndex, MainToolbarShortcut)? onShorcutPressed;
  final Function()? onMorePressed;

  final bool isEdit;
  final ColorBuilder? colorBuilder;

  const MainToolbar({
    super.key,
    required this.mainToolbar,
    required this.chapterReference,
    required this.translation,
    this.user,
    this.onPressed,
    this.onLongPressed,
    this.onSwipeRight,
    this.onSwipeLeft,
    this.onShorcutPressed,
    this.onMorePressed,
    this.isEdit = false,
    this.colorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        const sensitivity = 4;
        if (details.velocity.pixelsPerSecond.dx > sensitivity) {
          onSwipeLeft?.call();
        } else if (details.velocity.pixelsPerSecond.dx < -sensitivity) {
          onSwipeRight?.call();
        }
      },
      child: StyledMaterial(
        colorBuilder: colorBuilder ?? .surfacePrimary,
        borderRadius: .circular(999),
        padding: .only(left: 24, right: 12),
        onPressed: () => onPressed?.call(),
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
                      StyledTag(child: translation.title().toText()),
                      gapW12,
                    ],
                  ),
                ),
              ),
            ),
            ...mainToolbar.pinnedShortcuts.mapIndexed(
              (i, shortcut) => StyledEditBadge(
                isEdit: isEdit,
                child: Tooltip(
                  message: shortcut.title(),
                  child: StyledCircleButton.lg(
                    onPressed: () => onShorcutPressed?.call(i, shortcut),
                    child: shortcut.buildIcon(context, user: user),
                  ),
                ),
              ),
            ),
            StyledCircleButton.lg(onPressed: () => onMorePressed?.call(), child: Symbols.more_vert.toIcon()),
          ],
        ),
      ),
    );
  }
}
