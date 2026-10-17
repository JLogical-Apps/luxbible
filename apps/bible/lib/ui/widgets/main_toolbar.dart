import 'package:bible/models/user/main_toolbar_configuration.dart';
import 'package:bible/models/user/main_toolbar_shortcut.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/audio_bible_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class MainToolbar extends StatelessWidget {
  final MainToolbarConfiguration mainToolbar;
  final String bookTitle;
  final String location;
  final BibleTranslation translation;
  final User? user;
  final AudioBibleContext audioContext;

  final Widget? leading;

  final Function()? onPressed;
  final Function()? onLongPressed;
  final Function()? onSwipeLeft;
  final Function()? onSwipeRight;
  final Function(int shortcutIndex, MainToolbarShortcut)? onShorcutPressed;
  final Function()? onMorePressed;

  final bool isEdit;
  final bool hasMoreNotification;
  final ColorBuilder? colorBuilder;

  const MainToolbar({
    super.key,
    required this.mainToolbar,
    required this.bookTitle,
    required this.location,
    required this.translation,
    this.user,
    this.audioContext = .bible,
    this.leading,
    this.onPressed,
    this.onLongPressed,
    this.onSwipeRight,
    this.onSwipeLeft,
    this.onShorcutPressed,
    this.onMorePressed,
    this.isEdit = false,
    this.hasMoreNotification = false,
    this.colorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final leading = this.leading;
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
        padding: .only(left: leading == null ? 24 : 8, right: 12),
        onPressed: () => onPressed?.call(),
        onLongPressed: onLongPressed,
        child: Row(
          children: [
            if (leading != null) ...[leading, gapW4],
            Expanded(
              child: Align(
                alignment: .centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16) + .only(right: 4),
                  child: Row(
                    spacing: 8,
                    children: [
                      Flexible(
                        child: Text(bookTitle, style: context.textStyle.labelLg, maxLines: 1, overflow: .ellipsis),
                      ),
                      Text(location, style: context.textStyle.labelLg, maxLines: 1, overflow: .ellipsis),
                      StyledTag.sm(child: translation.title().toText()),
                    ],
                  ),
                ),
              ),
            ),
            ...mainToolbar.pinnedShortcuts.mapIndexed(
              (i, shortcut) => StyledEditBadge(
                isEdit: isEdit,
                child: Tooltip(
                  message: shortcut.title(audioContext: audioContext),
                  child: StyledCircleButton.md(
                    onPressed: () => onShorcutPressed?.call(i, shortcut),
                    child: shortcut.buildIcon(context, user: user, audioContext: audioContext),
                  ),
                ),
              ),
            ),
            StyledCircleButton.md(
              onPressed: () => onMorePressed?.call(),
              child: StyledNotificationDot(isVisible: hasMoreNotification, child: Symbols.more_vert.toIcon()),
            ),
          ],
        ),
      ),
    );
  }
}
