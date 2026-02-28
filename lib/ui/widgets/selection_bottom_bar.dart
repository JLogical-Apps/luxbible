import 'package:bible/models/bible.dart';
import 'package:bible/models/book_type.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/models/user/selection_configuration.dart';
import 'package:bible/models/user/selection_shortcut.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/bottom_bar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class SelectionBottomBar extends StatelessWidget {
  final Selection? selection;
  final SelectionConfiguration configuration;

  final User user;
  final Bible bible;

  final Function() onClosePressed;
  final Function() onMorePressed;
  final Function(int shortcutIndex, SelectionShortcut) onShorcutPressed;

  final bool isEdit;
  final Color? color;

  const SelectionBottomBar({
    super.key,
    required this.selection,
    required this.configuration,
    required this.user,
    required this.bible,
    required this.onClosePressed,
    required this.onMorePressed,
    required this.onShorcutPressed,
    this.isEdit = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return BottomBar(
      text:
          '"${bible.getSelectionText(selection ?? Selection(
                start: SelectionWordAnchor(book: BookType.genesis, chapterNum: 1, verseNum: 1, characterOffset: 0),
                end: SelectionWordAnchor(book: BookType.genesis, chapterNum: 1, verseNum: 1, characterOffset: 30),
                translation: user.translation,
              ))}"',
      buttons: configuration.pinnedShortcuts
          .mapIndexed(
            (i, shortcut) => StyledEditBadge(
              isEdit: isEdit,
              child: Tooltip(
                message: shortcut.title(user: user, selection: selection),
                child: StyledCircleButton.lg(
                  child: shortcut.buildIcon(context, user: user, selection: selection),
                  onPressed: () => onShorcutPressed(i, shortcut),
                ),
              ),
            ),
          )
          .toList(),
      onMorePressed: onMorePressed,
      onClosePressed: onClosePressed,
      color: color,
    );
  }
}
