import 'package:bible/models/user/toolbar_preset.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/pages/annotations_page.dart';
import 'package:bible/ui/pages/bibles_page.dart';
import 'package:bible/ui/pages/bookmarks_page.dart';
import 'package:bible/ui/pages/commentaries_page.dart';
import 'package:bible/ui/pages/highlight_styles_page.dart';
import 'package:bible/ui/pages/language_page.dart';
import 'package:bible/ui/pages/main_toolbar_settings_page.dart';
import 'package:bible/ui/pages/notebooks_page.dart';
import 'package:bible/ui/pages/push_notifications_page.dart';
import 'package:bible/ui/pages/text_selection_settings_page.dart';
import 'package:bible/ui/pages/theme_settings_page.dart';
import 'package:bible/ui/pages/verse_selection_settings_page.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:style/style.dart';
import 'package:url_launcher/url_launcher.dart';

final discordUri = Uri.parse('https://discord.gg/C4zfZDpZMB');

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider);
    final user = ref.watch(userProvider);

    return StyledPage(
      backgroundColor: .backgroundPrimary,
      title: t.settings.title.toText(),
      body: ListView(
        children: [
          StyledSection.child(
            title: t.settings.customize.toText(),
            child: StyledCard(
              children: [
                StyledListItem.navigation(
                  title: t.themeSettings.title.toText(),
                  leading: Symbols.custom_typography.toIcon(),
                  onPressed: () => context.push(ThemeSettingsPage()),
                ),
                StyledListItem.navigation(
                  title: t.labels.bibles.toText(),
                  leading: Symbols.book.toIcon(),
                  onPressed: () => context.push(BiblesPage()),
                ),
                StyledListItem.navigation(
                  title: t.labels.commentaries.toText(),
                  leading: Symbols.tooltip_2.toIcon(),
                  onPressed: () => context.push(CommentariesPage()),
                ),
                StyledListItem.navigation(
                  title: t.settings.pushNotifications.toText(),
                  leading: Symbols.notifications.toIcon(),
                  onPressed: () => context.push(PushNotificationsPage()),
                ),
                StyledListItem.navigation(
                  title: t.settings.language.toText(),
                  leading: Symbols.language.toIcon(),
                  onPressed: () => context.push(LanguagePage()),
                ),
              ],
            ),
          ),
          StyledSection.child(
            title: t.labels.toolbars.toText(),
            child: StyledCard(
              children: [
                StyledListItem(
                  title: t.settings.toolbarPresets.toText(),
                  subtitle: (user.toolbarPreset?.title() ?? t.common.custom).toText(),
                  trailing: StyledPillButton.md(
                    label: t.common.select.toText(),
                    onPressed: () async {
                      ref.markOnboardingStep(.customizeToolbar);
                      final preset = await context.showStyledSheet(
                        (context) => StyledSelectionSheet(
                          title: t.settings.toolbarPreset.toText(),
                          aboveOptions: Padding(
                            padding: .all(16),
                            child: StyledTile.message(
                              leading: Symbols.info.toIcon(),
                              title: t.settings.presetWarning.toText(),
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
                  title: t.toolbarSettings.mainToolbar.toText(),
                  leading: RotatedBox(quarterTurns: 2, child: Symbols.toolbar.toIcon()),
                  onPressed: () => context.push(MainToolbarSettingsPage()),
                ),
                StyledListItem.navigation(
                  title: t.toolbarSettings.verseSelection.toText(),
                  leading: Symbols.text_ad.toIcon(),
                  onPressed: () => context.push(VerseSelectionSettingsPage()),
                ),
                StyledListItem.navigation(
                  title: t.toolbarSettings.textSelection.toText(),
                  leading: Symbols.text_select_start.toIcon(),
                  onPressed: () => context.push(TextSelectionSettingsPage()),
                ),
              ],
            ),
          ),
          StyledSection.child(
            title: t.settings.yourContent.toText(),
            child: StyledCard(
              children: [
                StyledListItem.navigation(
                  title: t.labels.annotations.toText(),
                  leading: Symbols.note_stack.toIcon(),
                  onPressed: () async {
                    final result = await context.push(AnnotationsPage());
                    if (result != null && context.mounted) {
                      context.pop(result);
                    }
                  },
                ),
                StyledListItem.navigation(
                  title: t.labels.notebooks.toText(),
                  leading: Symbols.book_2.toIcon(),
                  onPressed: () async {
                    final result = await context.push(NotebooksPage());
                    if (result != null && context.mounted) {
                      context.pop(result);
                    }
                  },
                ),
                StyledListItem.navigation(
                  title: t.labels.highlightStyles.toText(),
                  leading: Symbols.format_ink_highlighter.toIcon(),
                  onPressed: () async {
                    final result = await context.push(HighlightStylesPage());
                    if (result != null && context.mounted) {
                      context.pop(result);
                    }
                  },
                ),
                StyledListItem.navigation(
                  title: t.labels.bookmarks.toText(),
                  leading: Symbols.bookmark.toIcon(),
                  onPressed: () => context.push(BookmarksPage()),
                ),
              ],
            ),
          ),
          StyledSection.child(
            title: t.labels.community.toText(),
            child: StyledCard(
              children: [
                StyledListItem(
                  title: t.labels.discord.toText(),
                  subtitle: t.settings.discussionAndAnnouncements.toText(),
                  leading: FaIcon(FontAwesomeIcons.discord),
                  onPressed: () => launchUrl(discordUri),
                  trailing: Symbols.arrow_outward.toIcon(),
                ),
                StyledListItem(
                  title: t.labels.instagram.toText(),
                  subtitle: t.settings.tipsAndUpdates.toText(),
                  leading: FaIcon(FontAwesomeIcons.instagram),
                  onPressed: () => launchUrl(Uri.parse('https://www.instagram.com/luxbible.app/')),
                  trailing: Symbols.arrow_outward.toIcon(),
                ),
              ],
            ),
          ),
          StyledSection.child(
            title: t.settings.supportLux.toText(),
            child: StyledCard(
              children: [
                StyledListItem(
                  title: t.settings.rateLux.toText(),
                  subtitle: t.settings.leaveReview.toText(),
                  leading: Symbols.star.toIcon(),
                  onPressed: () => context.showStyledDialog(
                    (context) => StyledDialog(
                      title: t.settings.supportLux.toText(),
                      body: t.settings.supportMessage.toText(),
                      buttonsBuilder: (context) => [
                        StyledRectButton.primary(
                          label: t.settings.leaveRating.toText(),
                          onPressed: () async {
                            context.pop();
                            final appReview = InAppReview.instance;
                            if (await appReview.isAvailable()) {
                              await appReview.requestReview();
                            } else {
                              await appReview.openStoreListing(appStoreId: 'id6759510218');
                            }
                          },
                        ),
                        StyledRectButton.transparent(
                          label: t.settings.joinDiscord.toText(),
                          onPressed: () {
                            context.pop();
                            launchUrl(discordUri);
                          },
                        ),
                      ],
                    ),
                  ),
                  trailing: Symbols.arrow_outward.toIcon(),
                ),
              ],
            ),
          ),
          StyledSection.child(
            title: t.labels.help.toText(),
            child: StyledCard(
              children: [
                StyledListItem(
                  title: t.settings.restartGetStarted.toText(),
                  subtitle: t.settings.restartGetStartedDescription.toText(),
                  leading: Symbols.data_info_alert.toIcon(),
                  onPressed: () {
                    ref.updateUser((user) => user.withOnboardingReset());
                    context.pop();
                  },
                ),
                StyledListItem(
                  title: t.settings.resetTutorials.toText(),
                  subtitle: t.settings.resetTutorialsDescription.toText(),
                  leading: Symbols.help.toIcon(),
                  onPressed: () {
                    ref.updateUser((user) => user.withTutorialsReset());
                    context.showStyledSnackbar(message: t.settings.tutorialsReset.toText());
                  },
                ),
              ],
            ),
          ),
          StyledSection.child(
            title: t.labels.about.toText(),
            child: StyledCard(
              children: [
                StyledListItem(
                  title: t.labels.version.toText(),
                  subtitle: packageInfo.version.toText(),
                  leading: Symbols.perm_device_information.toIcon(),
                ),
                StyledListItem.navigation(
                  title: t.labels.licenses.toText(),
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
