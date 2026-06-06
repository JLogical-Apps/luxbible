import 'package:bible/models/user/theme_layout_configuration.dart';
import 'package:bible/models/user/theme_mode.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeSettingsPage extends ConsumerWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return StyledPage(
      title: 'Theme & Layout'.toText(),
      backgroundColor: .backgroundPrimary,
      body: ListView(
        children: [
          StyledSection.child(
            title: 'Brightness'.toText(),
            child: StyledCard.child(
              padding: .all(4),
              child: StyledSegmentedControl(
                colorBuilder: .surfacePrimary,
                options: ThemeMode.values,
                selectedOption: user.theme,
                onOptionSelected: (theme) => ref.updateUser((user) => user.copyWith(theme: theme)),
                optionBuilder: (theme) => StyledSelectOption(title: Text(theme.title()), leading: theme.icon.toIcon()),
              ),
            ),
          ),
          StyledSection.child(
            title: 'Text'.toText(),
            child: StyledCard(
              children: [
                StyledListItem(
                  title: 'Font'.toText(),
                  subtitle: user.themeLayout.font.title().toText(),
                  trailing: StyledPillButton.md(label: 'Edit'.toText(), onPressed: () {}),
                ),
                StyledListItem(
                  title: 'Font Size & Spacing'.toText(),
                  subtitle: user.themeLayout.fontSizeSpacing.title().toText(),
                  trailing: StyledPillButton.md(
                    label: 'Edit'.toText(),
                    onPressed: () async {
                      final newFontSizeSpacing = await context.showStyledSheet(
                        (context) => StyledSelectionSheet(
                          title: 'Font Size & Spacing'.toText(),
                          options: FontSizeSpacing.values,
                          optionMapper: (option) => StyledSelectOption(
                            title: option.title().toText(),
                            subtitle: option.description().toText(),
                          ),
                          initialOption: user.themeLayout.fontSizeSpacing,
                        ),
                      );
                      if (newFontSizeSpacing != null) {
                        ref.updateUser((user) => user.copyWith.themeLayout(fontSizeSpacing: newFontSizeSpacing));
                      }
                    },
                  ),
                ),
                StyledListItem.switchControl(
                  title: 'Red Letters'.toText(),
                  subtitle: 'Show Jesus\' words in red.'.toText(),
                  thirdLine: 'This is only available in the BSB translation.'.toText(),
                  selected: user.themeLayout.redLetters,
                  onSelected: (newValue) => ref.updateUser((user) => user.copyWith.themeLayout(redLetters: newValue)),
                ),
              ],
            ),
          ),
          StyledSection.child(
            title: 'Layout'.toText(),
            subtitle: 'These are only available in the BSB translation.'.toText(),
            child: StyledCard(
              children: [
                StyledListItem.switchControl(
                  title: 'Section Headings'.toText(),
                  selected: user.themeLayout.sections,
                  onSelected: (newValue) => ref.updateUser((user) => user.copyWith.themeLayout(sections: newValue)),
                ),
                StyledListItem.switchControl(
                  title: 'Verse Numbers'.toText(),
                  selected: user.themeLayout.verseNumbers,
                  onSelected: (newValue) => ref.updateUser((user) => user.copyWith.themeLayout(verseNumbers: newValue)),
                ),
                StyledListItem.switchControl(
                  title: 'Paragraphs'.toText(),
                  subtitle: 'Format verses into paragraphs.'.toText(),
                  selected: user.themeLayout.paragraphs,
                  onSelected: (newValue) => ref.updateUser((user) => user.copyWith.themeLayout(paragraphs: newValue)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
