import 'package:bible/models/user/verse_selection_shortcut.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/widgets/verse_selection_bottom_bar.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class VerseSelectionSettingsPage extends ConsumerWidget {
  const VerseSelectionSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final verseSelectionConfiguration = user.verseSelection;

    return StyledPage(
      backgroundColor: .backgroundPrimary,
      title: t.toolbarSettings.verseSelection.toText(),
      body: Column(
        children: [
          ColoredBox(
            color: context.colors.surfacePrimary,
            child: StyledSection.child(
              title: t.labels.toolbar.toText(),
              subtitle: t.toolbarSettings.shownForVerses.toText(),
              padding: .symmetric(vertical: 16),
              childPadding: .symmetric(horizontal: 8),
              child: VerseSelectionBottomBar(
                configuration: verseSelectionConfiguration,
                user: user,
                verseSelection: null,
                onMorePressed: () {},
                onClosePressed: () {},
                onShorcutPressed: (shortcutIndex, shortcut) async {
                  ref.markOnboardingStep(.customizeToolbar);
                  final newShortcut = await showShortcutSheet(context, initialShortcut: shortcut);
                  if (newShortcut != null) {
                    ref.updateUser(
                      (user) => user.copyWith(
                        verseSelection: verseSelectionConfiguration.withPinnedShortcut(shortcutIndex, newShortcut),
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
                        subtitle: t.toolbarSettings.verseLongPressDescription.toText(),
                        leading: Symbols.touch_long.toIcon(),
                        trailing: StyledEditBadge(
                          child: StyledCircleButton.md(
                            colorBuilder: .surfaceSecondary,
                            onPressed: () async {
                              ref.markOnboardingStep(.customizeToolbar);
                              final newShortcut = await showShortcutSheet(
                                context,
                                initialShortcut: verseSelectionConfiguration.longPressShortcut,
                              );
                              if (newShortcut != null) {
                                ref.updateUser((user) => user.copyWith.verseSelection(longPressShortcut: newShortcut));
                              }
                            },
                            child: verseSelectionConfiguration.longPressShortcut.buildIcon(context),
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
                        subtitle: t.toolbarSettings.expandVerseDescription.toText(),
                        leading: Symbols.aspect_ratio.toIcon(),
                        isSelected: verseSelectionConfiguration.expandToAnnotation,
                        onSelected: (newValue) =>
                            ref.updateUser((user) => user.copyWith.verseSelection(expandToAnnotation: newValue)),
                      ),
                      StyledListItem.switchControl(
                        title: t.toolbarSettings.rangeSelection.toText(),
                        subtitle: t.toolbarSettings.rangeSelectionDescription.toText(),
                        leading: Symbols.format_letter_spacing.toIcon(),
                        isSelected: verseSelectionConfiguration.rangeSelection,
                        onSelected: (newValue) =>
                            ref.updateUser((user) => user.copyWith.verseSelection(rangeSelection: newValue)),
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

  Future<VerseSelectionShortcut?> showShortcutSheet(
    BuildContext context, {
    required VerseSelectionShortcut initialShortcut,
  }) => context.showStyledSheet(
    (context) => StyledSelectionSheet(
      title: t.toolbarSettings.verseShortcut.toText(),
      options: VerseSelectionShortcut.values,
      initialOption: initialShortcut,
      optionMapper: (shortcut) => StyledSelectOption(
        title: shortcut.title().toText(),
        subtitle: shortcut.description().toText(),
        leading: shortcut.buildIcon(context),
      ),
    ),
  );
}
