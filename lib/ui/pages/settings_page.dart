import 'package:bible/models/user/toolbar_preset.dart';
import 'package:bible/providers/package_info_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/annotations_page.dart';
import 'package:bible/ui/pages/bibles_page.dart';
import 'package:bible/ui/pages/bookmarks_page.dart';
import 'package:bible/ui/pages/commentaries_page.dart';
import 'package:bible/ui/pages/main_toolbar_settings_page.dart';
import 'package:bible/ui/pages/text_selection_settings_page.dart';
import 'package:bible/ui/pages/theme_settings_page.dart';
import 'package:bible/ui/pages/verse_selection_settings_page.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider);
    final user = ref.watch(userProvider);

    return StyledPage(
      backgroundColor: .backgroundPrimary,
      title: 'Settings'.toText(),
      body: ListView(
        children: [
          StyledSection.child(
            title: 'Customize'.toText(),
            child: StyledCard(
              children: [
                StyledListItem.navigation(
                  title: 'Theme & Layout'.toText(),
                  leading: Symbols.custom_typography.toIcon(),
                  onPressed: () => context.push(ThemeSettingsPage()),
                ),
                StyledListItem.navigation(
                  title: 'Bibles'.toText(),
                  leading: Symbols.book.toIcon(),
                  onPressed: () => context.push(BiblesPage()),
                ),
                StyledListItem.navigation(
                  title: 'Commentaries'.toText(),
                  leading: Symbols.tooltip_2.toIcon(),
                  onPressed: () => context.push(CommentariesPage()),
                ),
              ],
            ),
          ),
          StyledSection.child(
            title: 'Toolbars'.toText(),
            child: StyledCard(
              children: [
                StyledListItem(
                  title: 'Toolbar Presets'.toText(),
                  subtitle: (user.toolbarPreset?.title() ?? 'Custom').toText(),
                  trailing: StyledPillButton.md(
                    label: 'Select'.toText(),
                    onPressed: () async {
                      ref.markOnboardingStep(.customizeToolbar);
                      final preset = await context.showStyledSheet(
                        (context) => StyledSelectionSheet(
                          title: 'Toolbar Preset'.toText(),
                          aboveOptions: Padding(
                            padding: .all(16),
                            child: StyledTile.message(
                              leading: Symbols.info.toIcon(),
                              title: 'Selecting a preset will override the shortcuts in all your toolbars.'.toText(),
                            ),
                          ),
                          options: ToolbarPreset.values,
                          initialOption: user.toolbarPreset,
                          optionMapper: (preset) => StyledSelectOption(
                            title: preset.title().toText(),
                            subtitle: preset.description().toText(),
                            thirdLine: Padding(
                              padding: .only(top: 8),
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: preset.prominentShortcuts
                                    .map(
                                      (shortcut) => IntrinsicWidth(
                                        child: StyledTag.md(
                                          leading: shortcut.buildIcon(context),
                                          child: shortcut.title().toText(),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      );
                      if (preset != null) {
                        ref.updateUser((user) => user.withPreset(preset));
                      }
                    },
                  ),
                ),
                StyledListItem.navigation(
                  title: 'Main Toolbar'.toText(),
                  leading: RotatedBox(quarterTurns: 2, child: Symbols.toolbar.toIcon()),
                  onPressed: () => context.push(MainToolbarSettingsPage()),
                ),
                StyledListItem.navigation(
                  title: 'Verse Selection'.toText(),
                  leading: Symbols.text_ad.toIcon(),
                  onPressed: () => context.push(VerseSelectionSettingsPage()),
                ),
                StyledListItem.navigation(
                  title: 'Text Selection'.toText(),
                  leading: Symbols.text_select_start.toIcon(),
                  onPressed: () => context.push(TextSelectionSettingsPage()),
                ),
              ],
            ),
          ),
          StyledSection.child(
            title: 'Your Content'.toText(),
            child: StyledCard(
              children: [
                StyledListItem.navigation(
                  title: 'Annotations'.toText(),
                  leading: Symbols.note_stack.toIcon(),
                  onPressed: () async {
                    final result = await context.push(AnnotationsPage());
                    if (result != null && context.mounted) {
                      context.pop(result);
                    }
                  },
                ),
                StyledListItem.navigation(
                  title: 'Bookmarks'.toText(),
                  leading: Symbols.bookmark.toIcon(),
                  onPressed: () => context.push(BookmarksPage()),
                ),
              ],
            ),
          ),
          StyledSection.child(
            title: 'Community'.toText(),
            child: StyledCard(
              children: [
                StyledListItem(
                  title: 'Discord'.toText(),
                  subtitle: 'Discussion and announcements'.toText(),
                  leading: FaIcon(FontAwesomeIcons.discord),
                  onPressed: () => launchUrl(Uri.parse('https://discord.gg/C4zfZDpZMB')),
                  trailing: Symbols.arrow_outward.toIcon(),
                ),
                StyledListItem(
                  title: 'Instagram'.toText(),
                  subtitle: 'Tips and updates'.toText(),
                  leading: FaIcon(FontAwesomeIcons.instagram),
                  onPressed: () => launchUrl(Uri.parse('https://www.instagram.com/luxbible.app/')),
                  trailing: Symbols.arrow_outward.toIcon(),
                ),
              ],
            ),
          ),
          StyledSection.child(
            title: 'Help'.toText(),
            child: StyledCard(
              children: [
                StyledListItem(
                  title: 'Reset Onboarding'.toText(),
                  subtitle: 'Show the Get Started checklist again'.toText(),
                  leading: Symbols.data_info_alert.toIcon(),
                  onPressed: () {
                    ref.updateUser((user) => user.withOnboardingReset());
                    context.pop();
                  },
                ),
              ],
            ),
          ),
          StyledSection.child(
            title: 'About'.toText(),
            child: StyledCard(
              children: [
                StyledListItem(
                  title: 'Version'.toText(),
                  subtitle: packageInfo.version.toText(),
                  leading: Symbols.perm_device_information.toIcon(),
                ),
                StyledListItem.navigation(
                  title: 'Licenses'.toText(),
                  leading: Symbols.license.toIcon(),
                  onPressed: () => showLicensePage(context: context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
