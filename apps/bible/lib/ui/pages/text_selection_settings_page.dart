import 'package:lux/i18n.dart';
import 'package:bible/models/user/text_selection_shortcut.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:style/style.dart';
import 'package:bible/ui/widgets/text_selection_bottom_bar.dart';
import 'package:lux/lux.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class TextSelectionSettingsPage extends ConsumerWidget {
  const TextSelectionSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    final textSelectionConfiguration = user.textSelection;

    return StyledPage(
      backgroundColor: .backgroundPrimary,
      title: t.toolbarSettings.textSelection.toText(),
      body: Column(
        children: [
          ColoredBox(
            color: context.colors.surfacePrimary,
            child: StyledSection.child(
              title: t.labels.toolbar.toText(),
              subtitle: t.toolbarSettings.shownForText.toText(),
              padding: .symmetric(vertical: 16),
              childPadding: .symmetric(horizontal: 8),
              child: TextSelectionBottomBar(
                configuration: textSelectionConfiguration,
                user: user,
                textSelection: null,
                onMorePressed: () {},
                onClosePressed: () {},
                onShorcutPressed: (shortcutIndex, shortcut) async {
                  ref.markOnboardingStep(.customizeToolbar);
                  final newShortcut = await showShortcutSheet(context, initialShortcut: shortcut);
                  if (newShortcut != null) {
                    ref.updateUser(
                      (user) => user.copyWith(
                        textSelection: textSelectionConfiguration.withPinnedShortcut(shortcutIndex, newShortcut),
                      ),
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
                  title: t.toolbarSettings.gestures.toText(),
                  child: StyledCard(
                    children: [
                      StyledListItem(
                        title: t.toolbarSettings.longPress.toText(),
                        subtitle: t.toolbarSettings.textLongPressDescription.toText(),
                        leading: Symbols.touch_long.toIcon(),
                        trailing: StyledEditBadge(
                          child: StyledCircleButton.md(
                            colorBuilder: .surfaceSecondary,
                            onPressed: () async {
                              ref.markOnboardingStep(.customizeToolbar);
                              final newShortcut = await showShortcutSheet(
                                context,
                                initialShortcut: textSelectionConfiguration.longPressShortcut,
                              );
                              if (newShortcut != null) {
                                ref.updateUser((user) => user.copyWith.textSelection(longPressShortcut: newShortcut));
                              }
                            },
                            child: textSelectionConfiguration.longPressShortcut.buildIcon(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                StyledSection.child(
                  title: t.labels.selection.toText(),
                  child: StyledCard(
                    children: [
                      StyledListItem.switchControl(
                        title: t.toolbarSettings.expandToAnnotation.toText(),
                        subtitle: t.toolbarSettings.expandTextDescription.toText(),
                        leading: Symbols.aspect_ratio.toIcon(),
                        isSelected: textSelectionConfiguration.expandToAnnotation,
                        onSelected: (newValue) =>
                            ref.updateUser((user) => user.copyWith.textSelection(expandToAnnotation: newValue)),
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

  Future<TextSelectionShortcut?> showShortcutSheet(
    BuildContext context, {
    required TextSelectionShortcut initialShortcut,
  }) => context.showStyledSheet(
    (context) => StyledSelectionSheet(
      title: t.toolbarSettings.textShortcut.toText(),
      options: TextSelectionShortcut.values,
      initialOption: initialShortcut,
      optionMapper: (shortcut) => StyledSelectOption(
        title: shortcut.title().toText(),
        subtitle: shortcut.description().toText(),
        leading: shortcut.buildIcon(context),
      ),
    ),
  );
}
