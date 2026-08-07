import 'package:bible/models/user/user.dart';
import 'package:bible/models/user/verse_selection_configuration.dart';
import 'package:bible/models/user/verse_selection_shortcut.dart';
import 'package:bible/ui/widgets/bottom_bar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class VerseSelectionBottomBar extends StatelessWidget {
  final VerseSelection? verseSelection;
  final VerseSelectionConfiguration configuration;

  final User? user;

  final Function()? onClosePressed;
  final Function()? onMorePressed;
  final Function(int shortcutIndex, VerseSelectionShortcut)? onShorcutPressed;

  final bool isEdit;
  final Color? color;

  const VerseSelectionBottomBar({
    super.key,
    required this.verseSelection,
    required this.configuration,
    this.user,
    this.onClosePressed,
    this.onMorePressed,
    this.onShorcutPressed,
    this.isEdit = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return BottomBar(
      text: (verseSelection ?? VerseSelection.reference(Reference(book: BookType.genesis, chapterNum: 1, verseNum: 1)))
          .format(),
      buttons: configuration.pinnedShortcuts
          .mapIndexed(
            (i, shortcut) => StyledEditBadge(
              isEdit: isEdit,
              child: Tooltip(
                message: shortcut.title(user: user, verseSelection: verseSelection),
                child: StyledCircleButton.md(
                  child: shortcut.buildIcon(context, user: user, verseSelection: verseSelection),
                  onPressed: () => onShorcutPressed?.call(i, shortcut),
                ),
              ),
            ),
          )
          .toList(),
      onMorePressed: () => onMorePressed?.call(),
      onClosePressed: () => onClosePressed?.call(),
      color: color,
    );
  }
}
