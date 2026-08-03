import 'package:lux/lux.dart';
import 'package:lux/i18n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:bible/models/user/main_toolbar_shortcut.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/widgets/main_toolbar.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class MainToolbarSettingsPage extends ConsumerWidget {
  const MainToolbarSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final mainToolbar = user.mainToolbar;

    return StyledPage(
      backgroundColor: .backgroundPrimary,
      title: t.toolbarSettings.mainToolbar.toText(),
      body: Column(
        children: [
          ColoredBox(
            color: context.colors.surfacePrimary,
            child: StyledSection.child(
              title: t.labels.toolbar.toText(),
              subtitle: t.toolbarSettings.shownForMain.toText(),
              padding: .symmetric(vertical: 16),
              child: MainToolbar(
                mainToolbar: mainToolbar,
                chapterReference: ChapterReference(book: BookType.genesis, chapterNum: 1),
                translation: user.translation,
                user: user,
                onPressed: () {},
                onMorePressed: () {},
                onShorcutPressed: (shortcutIndex, shortcut) async {
                  ref.markOnboardingStep(.customizeToolbar);
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
                  title: t.toolbarSettings.gestures.toText(),
                  child: StyledCard(
                    children: [
                      StyledListItem(
                        title: t.toolbarSettings.longPress.toText(),
                        subtitle: t.toolbarSettings.mainLongPressDescription.toText(),
                        leading: Symbols.touch_long.toIcon(),
                        trailing: StyledEditBadge(
                          child: StyledCircleButton.md(
                            colorBuilder: .surfaceSecondary,
                            onPressed: () async {
                              ref.markOnboardingStep(.customizeToolbar);
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
                    ],
                  ),
                ),
                StyledSection.child(
                  title: t.labels.visibility.toText(),
                  child: StyledCard(
                    children: [
                      StyledListItem.radio(
                        title: t.toolbarSettings.hideToolbar.toText(),
                        subtitle: t.toolbarSettings.hideToolbarDescription.toText(),
                        leading: Symbols.bottom_panel_close.toIcon(),
                        isSelected: mainToolbar.pinToBottom == false,
                        onSelected: () => ref.updateUser((user) => user.copyWith.mainToolbar(pinToBottom: false)),
                      ),
                      StyledListItem.radio(
                        title: t.toolbarSettings.pinToolbar.toText(),
                        subtitle: t.toolbarSettings.pinToolbarDescription.toText(),
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
        title: t.toolbarSettings.mainShortcut.toText(),
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
