import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/user/main_toolbar_shortcut.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_selection_sheet.dart';
import 'package:bible/style/widgets/styled_card.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/style/widgets/styled_edit_badge.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/style/widgets/styled_page.dart';
import 'package:bible/style/widgets/styled_section.dart';
import 'package:bible/style/widgets/styled_select.dart';
import 'package:bible/ui/widgets/main_toolbar.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class MainToolbarSettingsPage extends ConsumerWidget {
  const MainToolbarSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final mainToolbar = user.mainToolbar;

    return StyledPage(
      backgroundColor: .backgroundPrimary,
      title: 'Main Toolbar'.toText(),
      body: Column(
        children: [
          ColoredBox(
            color: context.colors.surfacePrimary,
            child: StyledSection.child(
              title: 'Toolbar'.toText(),
              padding: .symmetric(vertical: 16),
              child: MainToolbar(
                mainToolbar: mainToolbar,
                chapterReference: ChapterReference(book: BookType.genesis, chapterNum: 1),
                translation: user.translation,
                user: user,
                onPressed: () {},
                onMorePressed: () {},
                onShorcutPressed: (shortcutIndex, shortcut) async {
                  final newShortcut = await showSelectMainToolbarSheet(context, initialShortcut: shortcut);
                  if (newShortcut != null) {
                    ref.updateUser(
                      (user) => user.copyWith(mainToolbar: mainToolbar.withPinnedShortcut(shortcutIndex, newShortcut)),
                    );
                  }
                },
                isEdit: true,
                colorBuilder: .surfaceTertiary,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                StyledSection.child(
                  title: 'Gestures'.toText(),
                  child: StyledCard(
                    children: [
                      StyledListItem(
                        title: 'Long Press'.toText(),
                        subtitle: 'Shortcut when the toolbar is long-pressed.'.toText(),
                        leading: Symbols.touch_long.toIcon(),
                        trailing: StyledEditBadge(
                          child: StyledCircleButton.lg(
                            colorBuilder: .surfaceSecondary,
                            onPressed: () async {
                              final newShortcut = await showSelectMainToolbarSheet(
                                context,
                                initialShortcut: mainToolbar.longPressShortcut,
                              );
                              if (newShortcut != null) {
                                ref.updateUser(
                                  (user) =>
                                      user.copyWith(mainToolbar: mainToolbar.copyWith(longPressShortcut: newShortcut)),
                                );
                              }
                            },
                            child: mainToolbar.longPressShortcut.buildIcon(context, user: user),
                          ),
                        ),
                      ),
                      StyledListItem.switchControl(
                        title: 'Swipe to Navigate'.toText(),
                        subtitle:
                            'Swipe left on the toolbar to go back to the previous verse selection. Swipe right to undo that.'
                                .toText(),
                        leading: Symbols.swipe.toIcon(),
                        isSelected: mainToolbar.swipeToUndo,
                        onSelected: (newValue) =>
                            ref.updateUser((user) => user.copyWith.mainToolbar(swipeToUndo: newValue)),
                      ),
                    ],
                  ),
                ),
                StyledSection.child(
                  title: 'Visibility'.toText(),
                  child: StyledCard(
                    children: [
                      StyledListItem.radio(
                        title: 'Hide'.toText(),
                        subtitle: 'Hide the toolbar while scrolling down for an immersive view of the Bible.'.toText(),
                        leading: Symbols.bottom_panel_close.toIcon(),
                        isSelected: mainToolbar.pinToBottom == false,
                        onSelected: () => ref.updateUser((user) => user.copyWith.mainToolbar(pinToBottom: false)),
                      ),
                      StyledListItem.radio(
                        title: 'Pin'.toText(),
                        subtitle: 'Pin the toolbar to the bottom of the page.'.toText(),
                        leading: Symbols.pin_drop.toIcon(),
                        isSelected: mainToolbar.pinToBottom == true,
                        onSelected: () => ref.updateUser((user) => user.copyWith.mainToolbar(pinToBottom: true)),
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

  Future<MainToolbarShortcut?> showSelectMainToolbarSheet(
    BuildContext context, {
    required MainToolbarShortcut initialShortcut,
  }) {
    final user = ref.read(userProvider);
    return context.showStyledSheet(
      (context) => StyledSelectionSheet(
        title: 'Main Toolbar Shortcut'.toText(),
        options: MainToolbarShortcut.values,
        initialOption: initialShortcut,
        optionMapper: (shortcut) => StyledSelectOption(
          title: shortcut.title().toText(),
          subtitle: shortcut.description(user: user).toText(),
          leading: shortcut.buildIcon(context, user: user),
        ),
      ),
    );
  }
}
