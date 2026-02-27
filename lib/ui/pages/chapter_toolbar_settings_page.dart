import 'package:bible/models/book_type.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/toolbar_shortcut.dart';
import 'package:bible/models/user.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_selection_sheet.dart';
import 'package:bible/style/widgets/styled_card.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/style/widgets/styled_page.dart';
import 'package:bible/style/widgets/styled_section.dart';
import 'package:bible/style/widgets/styled_select.dart';
import 'package:bible/ui/pages/styled_edit_badge.dart';
import 'package:bible/ui/widgets/toolbar.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class ChapterToolbarSettingsPage extends ConsumerWidget {
  const ChapterToolbarSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final toolbar = user.toolbar;

    return StyledPage(
      titleText: 'Chapter Toolbar Settings',
      body: Column(
        children: [
          ColoredBox(
            color: context.colors.surfacePrimary,
            child: StyledSection.child(
              titleText: 'Toolbar',
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Toolbar(
                toolbar: toolbar,
                chapterReference: ChapterReference(book: BookType.genesis, chapterNum: 1),
                translation: user.translation,
                user: user,
                onPressed: () {},
                onMorePressed: () {},
                onShorcutPressed: (shortcutIndex, shortcut) async {
                  final newShortcut = await showSelectToolbarSheet(context, initialShortcut: shortcut, user: user);
                  if (newShortcut != null) {
                    ref.updateUser(
                      (user) => user.copyWith(toolbar: toolbar.withPinnedShortcut(shortcutIndex, newShortcut)),
                    );
                  }
                },
                isEdit: true,
                color: context.colors.surfaceTertiary,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                StyledSection.child(
                  titleText: 'Gestures',
                  child: StyledCard(
                    children: [
                      StyledListItem(
                        titleText: 'Long Press',
                        subtitleText: 'Shortcut when the toolbar is long-pressed.',
                        leadingIcon: Symbols.touch_long,
                        trailing: StyledEditBadge(
                          child: StyledCircleButton.lg(
                            color: context.colors.surfaceSecondary,
                            onPressed: () async {
                              final newShortcut = await showSelectToolbarSheet(
                                context,
                                initialShortcut: toolbar.longPressShortcut,
                                user: user,
                              );
                              if (newShortcut != null) {
                                ref.updateUser(
                                  (user) => user.copyWith(toolbar: toolbar.copyWith(longPressShortcut: newShortcut)),
                                );
                              }
                            },
                            child: toolbar.longPressShortcut.buildIcon(context, user: user, reference: null),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<ToolbarShortcut?> showSelectToolbarSheet(
    BuildContext context, {
    required ToolbarShortcut initialShortcut,
    required User user,
  }) => context.showStyledSheet(
    StyledSelectionSheet(
      titleText: 'Toolbar Shortcut',
      options: ToolbarShortcut.values,
      initialOption: initialShortcut,
      optionMapper: (shortcut) => StyledSelectOption(
        titleText: shortcut.title(user: user, reference: null),
        subtitleText: shortcut.description(user: user, reference: null),
        leading: shortcut.buildIcon(context, user: user, reference: null),
      ),
    ),
  );
}
