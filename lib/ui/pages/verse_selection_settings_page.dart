import 'package:bible/models/user/verse_selection_shortcut.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/verse_selection_bottom_bar.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class VerseSelectionSettingsPage extends ConsumerWidget {
  const VerseSelectionSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final verseSelectionConfiguration = user.verseSelection;

    return StyledPage(
      backgroundColor: .backgroundPrimary,
      title: 'Verse Selection'.toText(),
      body: Column(
        children: [
          ColoredBox(
            color: context.colors.surfacePrimary,
            child: StyledSection.child(
              title: 'Toolbar'.toText(),
              padding: .symmetric(vertical: 16),
              childPadding: .symmetric(horizontal: 8),
              child: VerseSelectionBottomBar(
                configuration: verseSelectionConfiguration,
                user: user,
                verseSelection: null,
                onMorePressed: () {},
                onClosePressed: () {},
                onShorcutPressed: (shortcutIndex, shortcut) async {
                  final newShortcut = await showShortcutSheet(context, initialShortcut: shortcut);
                  if (newShortcut != null) {
                    ref.updateUser(
                      (user) => user.copyWith(
                        verseSelection: verseSelectionConfiguration.withPinnedShortcut(shortcutIndex, newShortcut),
                      ),
                    );
                    ref.markOnboardingStep(.customizeToolbar);
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
                  title: 'Gestures'.toText(),
                  child: StyledCard(
                    children: [
                      StyledListItem(
                        title: 'Long Press'.toText(),
                        subtitle: 'Shortcut when a verse selection is long-pressed.'.toText(),
                        leading: Symbols.touch_long.toIcon(),
                        trailing: StyledEditBadge(
                          child: StyledCircleButton.lg(
                            colorBuilder: .surfaceSecondary,
                            onPressed: () async {
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
                  title: 'Selection'.toText(),
                  child: StyledCard(
                    children: [
                      StyledListItem.switchControl(
                        title: 'Expand to Annotation'.toText(),
                        subtitle: 'Tapping a verse selects its full annotated verse selection.'.toText(),
                        leading: Symbols.aspect_ratio.toIcon(),
                        isSelected: verseSelectionConfiguration.expandToAnnotation,
                        onSelected: (newValue) =>
                            ref.updateUser((user) => user.copyWith.verseSelection(expandToAnnotation: newValue)),
                      ),
                      StyledListItem.switchControl(
                        title: 'Range Selection'.toText(),
                        subtitle: 'Tapping a second verse selects all verses between it and the first.'.toText(),
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
      title: 'Verse Selection Shortcut'.toText(),
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
