import 'package:bible/models/user/theme_layout_configuration.dart';
import 'package:bible/models/user/theme_mode.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeSettingsPage extends ConsumerWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final hasGreekBible = user.biblesOrDefault.any((bible) => bible.language == .greek);
    final hasHebrewBible = user.biblesOrDefault.any((bible) => bible.language == .hebrew);

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
                  trailing: StyledPillButton.md(
                    label: 'Edit'.toText(),
                    onPressed: () async {
                      final newFont = await context.showStyledSheet(
                        (context) => StyledSelectionSheet(
                          title: 'Font'.toText(),
                          options: ThemeFont.values,
                          optionMapper: (option) => StyledSelectOption(
                            title: Text(option.title(), style: TextStyle(fontFamily: option.fontFamily)),
                          ),
                          initialOption: user.themeLayout.font,
                        ),
                      );
                      if (newFont != null) {
                        ref.updateUser((user) => user.copyWith.themeLayout(font: newFont));
                      }
                    },
                  ),
                ),
                getFontSizeSpacingItem(
                  context,
                  title: 'Font Size & Spacing',
                  value: user.themeLayout.fontSizeSpacing,
                  fallbackTitle: 'System',
                  fallbackDescription: 'Use your device’s preferred text size.',
                  onChanged: (value) => ref.updateUser((user) => user.copyWith.themeLayout(fontSizeSpacing: value)),
                ),
                if (hasGreekBible)
                  getFontSizeSpacingItem(
                    context,
                    title: 'Greek Font Size & Spacing',
                    value: user.themeLayout.greekFontSizeSpacing,
                    onChanged: (value) =>
                        ref.updateUser((user) => user.copyWith.themeLayout(greekFontSizeSpacing: value)),
                  ),
                if (hasHebrewBible)
                  getFontSizeSpacingItem(
                    context,
                    title: 'Hebrew Font Size & Spacing',
                    value: user.themeLayout.hebrewFontSizeSpacing,
                    onChanged: (value) =>
                        ref.updateUser((user) => user.copyWith.themeLayout(hebrewFontSizeSpacing: value)),
                  ),
                StyledListItem.switchControl(
                  title: 'Red Letters'.toText(),
                  subtitle: 'Show Jesus\' words in red.'.toText(),
                  thirdLine: user.translation.hasRedLetters
                      ? null
                      : 'This is not available in ${user.translation.title()}.'.toText(),
                  isSelected: user.themeLayout.redLetters,
                  onSelected: (newValue) => ref.updateUser((user) => user.copyWith.themeLayout(redLetters: newValue)),
                ),
              ],
            ),
          ),
          StyledSection.child(
            title: 'Layout'.toText(),
            child: StyledCard(
              children: [
                StyledListItem(
                  title: 'Section Headings'.toText(),
                  subtitle: user.themeLayout.sections.title().toText(),
                  trailing: StyledPillButton.md(
                    label: 'Edit'.toText(),
                    onPressed: () async {
                      final newSectionHeadings = await context.showStyledSheet(
                        (context) => StyledSelectionSheet(
                          title: 'Section Headings'.toText(),
                          options: SectionHeadings.values,
                          optionMapper: (option) => StyledSelectOption(
                            title: option.title().toText(),
                            subtitle: option.description().toText(),
                          ),
                          initialOption: user.themeLayout.sections,
                        ),
                      );
                      if (newSectionHeadings != null) {
                        ref.updateUser((user) => user.copyWith.themeLayout(sections: newSectionHeadings));
                      }
                    },
                  ),
                ),
                StyledListItem.switchControl(
                  title: 'Verse Numbers'.toText(),
                  isSelected: user.themeLayout.verseNumbers,
                  onSelected: (newValue) => ref.updateUser((user) => user.copyWith.themeLayout(verseNumbers: newValue)),
                ),
                StyledListItem.switchControl(
                  title: 'Paragraphs'.toText(),
                  subtitle: 'Format verses into paragraphs.'.toText(),
                  isSelected: user.themeLayout.paragraphs,
                  onSelected: (newValue) => ref.updateUser((user) => user.copyWith.themeLayout(paragraphs: newValue)),
                ),
                StyledListItem.switchControl(
                  title: 'Footnotes'.toText(),
                  subtitle: 'Show footnote markers within the text.'.toText(),
                  isSelected: user.themeLayout.footnotes,
                  onSelected: (newValue) => ref.updateUser((user) => user.copyWith.themeLayout(footnotes: newValue)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getFontSizeSpacingItem(
    BuildContext context, {
    required String title,
    required FontSizeSpacing? value,
    required Function(FontSizeSpacing?) onChanged,
    String fallbackTitle = 'Default',
    String fallbackDescription = 'Use the default Font Size & Spacing.',
  }) => StyledListItem(
    title: title.toText(),
    subtitle: (value?.title() ?? fallbackTitle).toText(),
    trailing: StyledPillButton.md(
      label: 'Edit'.toText(),
      onPressed: () => context.showStyledSheet(
        (context) => StyledSheet(
          title: title.toText(),
          children: [
            ...FontSizeSpacing.values.map(
              (option) => StyledListItem.radio(
                title: option.title().toText(),
                isSelected: option == value,
                onSelected: () {
                  onChanged(option);
                  context.pop();
                },
              ),
            ),
            StyledListItem.radio(
              title: fallbackTitle.toText(),
              subtitle: fallbackDescription.toText(),
              isSelected: value == null,
              onSelected: () {
                onChanged(null);
                context.pop();
              },
            ),
          ],
        ),
      ),
    ),
  );
}
