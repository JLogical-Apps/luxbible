import 'package:bible/models/bible_translation.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/toolbar_configuration.dart';
import 'package:bible/models/toolbar_shortcut.dart';
import 'package:bible/models/user.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_badge.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/style/widgets/styled_material.dart';
import 'package:bible/ui/pages/styled_edit_badge.dart';
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
  final Color? color;

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
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return StyledMaterial(
      color: color ?? context.colors.surfacePrimary,
      borderRadius: BorderRadius.circular(999),
      padding: EdgeInsets.only(left: 24, right: 12),
      onPressed: onPressed,
      onLongPressed: onLongPressed,
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  spacing: 8,
                  children: [
                    Text(chapterReference.format(), style: context.textStyle.labelLg),
                    StyledBadge(text: translation.title()),
                  ],
                ),
              ),
            ),
          ),
          ...toolbar.pinnedShortcuts.mapIndexed(
            (i, shortcut) => StyledEditBadge(
              isEdit: isEdit,
              child: Tooltip(
                message: shortcut.title(user: user, reference: chapterReference),
                child: StyledCircleButton.lg(
                  onPressed: () => onShorcutPressed(i, shortcut),
                  child: shortcut.buildIcon(context, user: user, reference: chapterReference),
                ),
              ),
            ),
          ),
          StyledCircleButton.lg(icon: Symbols.more_vert, onPressed: onMorePressed),
        ],
      ),
    );
  }
}
