import 'package:bible/models/user/text_selection_shortcut.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/text_selection_bottom_bar.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
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
      title: 'Text Selection'.toText(),
      body: Column(
        children: [
          ColoredBox(
            color: context.colors.surfacePrimary,
            child: StyledSection.child(
              title: 'Toolbar'.toText(),
              subtitle: 'Shown when long-pressing text within verses.'.toText(),
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
                  title: 'Gestures'.toText(),
                  child: StyledCard(
                    children: [
                      StyledListItem(
                        title: 'Long Press'.toText(),
                        subtitle: 'Shortcut when a text selection is long-pressed.'.toText(),
                        leading: Symbols.touch_long.toIcon(),
                        trailing: StyledEditBadge(
                          child: StyledCircleButton.lg(
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
                  title: 'Selection'.toText(),
                  child: StyledCard(
                    children: [
                      StyledListItem.switchControl(
                        title: 'Expand to Annotation'.toText(),
                        subtitle: 'Long-pressing an annotated word selects its full highlighted range.'.toText(),
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
      title: 'Text Selection Shortcut'.toText(),
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
