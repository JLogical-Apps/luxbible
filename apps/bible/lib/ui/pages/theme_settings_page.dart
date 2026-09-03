import 'package:bible/models/user/theme_layout_configuration.dart';
import 'package:bible/models/user/theme_mode.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class ThemeSettingsPage extends ConsumerWidget implements StyledRoute<void> {
  const ThemeSettingsPage({super.key});

  @override
  String get path => '/settings/theme';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return StyledPage(
      title: t.themeSettings.title.toText(),
      backgroundColor: .backgroundPrimary,
      body: ListView(
        children: [
          StyledSection.child(
            title: t.themeSettings.brightness.toText(),
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
            title: t.labels.text.toText(),
            child: StyledCard(
              children: [
                StyledListItem(
                  title: t.themeSettings.font.toText(),
                  subtitle: user.themeLayout.font.title().toText(),
                  trailing: StyledPillButton.md(
                    label: t.common.edit.toText(),
                    onPressed: () async {
                      final newFont = await context.showStyledSheet(
                        (context, _) => StyledSelectionSheet(
                          title: t.themeSettings.font.toText(),
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
                  title: t.themeSettings.fontSizeSpacing,
                  value: user.themeLayout.fontSizeSpacing,
                  fallbackTitle: t.themeSettings.system,
                  fallbackDescription: t.themeSettings.systemTextSizeDescription,
                  onChanged: (value) => ref.updateUser((user) => user.copyWith.themeLayout(fontSizeSpacing: value)),
                ),
                if (user.recentBibles.any((bible) => bible.bibleLanguage == .greek) ||
                    user.themeLayout.greekFontSizeSpacing != null)
                  getFontSizeSpacingItem(
                    context,
                    title: t.themeSettings.greekFontSizeSpacing,
                    value: user.themeLayout.greekFontSizeSpacing,
                    onChanged: (value) =>
                        ref.updateUser((user) => user.copyWith.themeLayout(greekFontSizeSpacing: value)),
                  ),
                if (user.recentBibles.any((bible) => bible.bibleLanguage == .hebrew) ||
                    user.themeLayout.hebrewFontSizeSpacing != null)
                  getFontSizeSpacingItem(
                    context,
                    title: t.themeSettings.hebrewFontSizeSpacing,
                    value: user.themeLayout.hebrewFontSizeSpacing,
                    onChanged: (value) =>
                        ref.updateUser((user) => user.copyWith.themeLayout(hebrewFontSizeSpacing: value)),
                  ),
                StyledListItem.switchControl(
                  title: t.themeSettings.redLetters.toText(),
                  subtitle: t.themeSettings.redLettersDescription.toText(),
                  thirdLine: user.translation.hasRedLetters
                      ? null
                      : t.common.notAvailableIn(translation: user.translation.title()).toText(),
                  isSelected: user.themeLayout.redLetters,
                  onSelected: (newValue) => ref.updateUser((user) => user.copyWith.themeLayout(redLetters: newValue)),
                ),
              ],
            ),
          ),
          StyledSection.child(
            title: t.labels.layout.toText(),
            child: StyledCard(
              children: [
                StyledListItem(
                  title: t.themeSettings.sectionHeadings.toText(),
                  subtitle: user.themeLayout.sections.title().toText(),
                  trailing: StyledPillButton.md(
                    label: t.common.edit.toText(),
                    onPressed: () async {
                      final newSectionHeadings = await context.showStyledSheet(
                        (context, _) => StyledSelectionSheet(
                          title: t.themeSettings.sectionHeadings.toText(),
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
                  title: t.themeSettings.verseNumbers.toText(),
                  isSelected: user.themeLayout.verseNumbers,
                  onSelected: (newValue) => ref.updateUser((user) => user.copyWith.themeLayout(verseNumbers: newValue)),
                ),
                StyledListItem.switchControl(
                  title: t.labels.paragraphs.toText(),
                  subtitle: t.themeSettings.paragraphsDescription.toText(),
                  isSelected: user.themeLayout.paragraphs,
                  onSelected: (newValue) => ref.updateUser((user) => user.copyWith.themeLayout(paragraphs: newValue)),
                ),
                StyledListItem.switchControl(
                  title: t.labels.footnotes.toText(),
                  subtitle: t.themeSettings.footnotesDescription.toText(),
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
    String? fallbackTitle,
    String? fallbackDescription,
  }) => StyledListItem(
    title: title.toText(),
    subtitle: (value?.title() ?? fallbackTitle ?? t.common.defaultLabel).toText(),
    trailing: StyledPillButton.md(
      label: t.common.edit.toText(),
      onPressed: () => context.showStyledSheet(
        (context, _) => StyledSheet(
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
              title: (fallbackTitle ?? t.common.defaultLabel).toText(),
              subtitle: (fallbackDescription ?? t.themeSettings.defaultSizeDescription).toText(),
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
