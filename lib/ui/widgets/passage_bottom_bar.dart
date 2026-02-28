import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/user/passage_configuration.dart';
import 'package:bible/models/user/passage_shortcut.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/bottom_bar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class PassageBottomBar extends StatelessWidget {
  final Passage passage;
  final PassageConfiguration configuration;

  final User user;

  final Function() onClosePressed;
  final Function() onMorePressed;
  final Function(int shortcutIndex, PassageShortcut) onShorcutPressed;

  final bool isEdit;
  final Color? color;

  const PassageBottomBar({
    super.key,
    required this.passage,
    required this.configuration,
    required this.user,
    required this.onClosePressed,
    required this.onMorePressed,
    required this.onShorcutPressed,
    this.isEdit = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return BottomBar(
      text: passage.format(),
      buttons: configuration.pinnedShortcuts
          .mapIndexed(
            (i, shortcut) => StyledEditBadge(
              isEdit: isEdit,
              child: Tooltip(
                message: shortcut.title(),
                child: StyledCircleButton.lg(
                  child: shortcut.buildIcon(context, user: user),
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
