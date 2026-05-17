import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/models/user/selection_configuration.dart';
import 'package:bible/models/user/selection_shortcut.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/bottom_bar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectionBottomBar extends ConsumerWidget {
  final Selection? selection;
  final SelectionConfiguration configuration;

  final User? user;

  final Function()? onClosePressed;
  final Function()? onMorePressed;
  final Function(int shortcutIndex, SelectionShortcut)? onShorcutPressed;

  final bool isEdit;
  final Color? color;

  const SelectionBottomBar({
    super.key,
    required this.selection,
    required this.configuration,
    this.user,
    this.onClosePressed,
    this.onMorePressed,
    this.onShorcutPressed,
    this.isEdit = false,
    this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bibles = ref.watch(displayBiblesProvider);
    final translation = user?.translation ?? .bsb;
    final bible = bibles.firstWhere((bible) => bible.translation == translation);

    return BottomBar(
      text:
          '"${bible.getSelectionText(selection ?? Selection(
                start: SelectionWordAnchor(book: BookType.genesis, chapterNum: 1, verseNum: 1, characterOffset: 0),
                end: SelectionWordAnchor(book: BookType.genesis, chapterNum: 1, verseNum: 1, characterOffset: 30),
                translation: translation,
              ))}"',
      buttons: configuration.pinnedShortcuts
          .mapIndexed(
            (i, shortcut) => StyledEditBadge(
              isEdit: isEdit,
              child: Tooltip(
                message: shortcut.title(user: user, selection: selection),
                child: StyledCircleButton.lg(
                  child: shortcut.buildIcon(context, user: user, selection: selection),
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
