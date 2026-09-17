import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:bible/models/user/toolbar_preset.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/analytics_service.dart';
import 'package:bible/ui/pages/annotations_page.dart';
import 'package:bible/ui/pages/bookmarks_page.dart';
import 'package:bible/ui/pages/commentaries_page.dart';
import 'package:bible/ui/pages/compare_settings_page.dart';
import 'package:bible/ui/pages/highlight_styles_page.dart';
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
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:style/style.dart';
import 'package:url_launcher/url_launcher.dart';

final discordUri = Uri.parse('https://discord.gg/C4zfZDpZMB');
final supportEmailUri = Uri.parse('mailto:support@luxbible.app');
final luxBibleUri = Uri.parse('https://www.luxbible.app');
final instagramUri = Uri.parse('https://www.instagram.com/luxbible.app/');
final facebookUri = Uri.parse('https://www.facebook.com/people/Lux-Bible/61591758211559/');
final youtubeUri = Uri.parse('https://www.youtube.com/@luxbibleapp');
final tiktokUri = Uri.parse('https://www.tiktok.com/@lux.bible');
final appStoreReviewUri = Uri.parse('https://apps.apple.com/app/id6759510218?action=write-review');
final playStoreReviewUri = Uri.parse('https://play.google.com/store/apps/details?id=app.luxbible.app');

class MorePage extends HookConsumerWidget implements StyledRoute<VerseSelection> {
  const MorePage({super.key});

  @override
  String get path => '/more';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider);
    final user = ref.watch(userProvider);

    return StyledPage(
      backgroundColor: .backgroundPrimary,
      title: t.mainActions.more.toText(),
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
                  title: t.studyActions.compare.toText(),
                  leading: Symbols.text_compare.toIcon(),
                  onPressed: () => context.push(CompareSettingsPage()),
                ),
                StyledListItem.navigation(
                  title: t.labels.commentaries.toText(),
                  leading: Symbols.tooltip_2.toIcon(),
                  onPressed: () => context.push(CommentariesPage()),
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
                        (context, _) => StyledSelectionSheet(
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
            title: t.settings.title.toText(),
            child: StyledCard(
              children: [
                StyledListItem.navigation(
                  title: t.settings.pushNotifications.toText(),
                  leading: Symbols.notifications.toIcon(),
                  onPressed: () => context.push(PushNotificationsPage()),
                ),
                StyledListItem.externalNavigation(
                  title: t.settings.language.toText(),
                  leading: Symbols.language.toIcon(),
                  onPressed: () => AppSettings.openAppSettings(type: .appLocale),
                ),
              ],
            ),
          ),
          StyledSection.child(
            title: t.labels.community.toText(),
            child: StyledCard(
              children: [
                StyledListItem.externalNavigation(
                  title: t.labels.discord.toText(),
                  subtitle: t.settings.discussionAndAnnouncements.toText(),
                  leading: FaIcon(FontAwesomeIcons.discord),
                  onPressed: () {
                    AnalyticsEvent.communityLinkPressed.log();
                    launchUrl(discordUri);
                  },
                ),
                StyledListItem.externalNavigation(
                  title: t.labels.instagram.toText(),
                  leading: FaIcon(FontAwesomeIcons.instagram),
                  onPressed: () {
                    AnalyticsEvent.communityLinkPressed.log();
                    launchUrl(instagramUri);
                  },
                ),
                StyledListItem.externalNavigation(
                  title: t.labels.tiktok.toText(),
                  leading: FaIcon(FontAwesomeIcons.tiktok),
                  onPressed: () {
                    AnalyticsEvent.communityLinkPressed.log();
                    launchUrl(tiktokUri);
                  },
                ),
                StyledListItem.externalNavigation(
                  title: t.labels.facebook.toText(),
                  leading: FaIcon(FontAwesomeIcons.facebook),
                  onPressed: () {
                    AnalyticsEvent.communityLinkPressed.log();
                    launchUrl(facebookUri);
                  },
                ),
                StyledListItem.externalNavigation(
                  title: t.labels.youtube.toText(),
                  leading: FaIcon(FontAwesomeIcons.youtube),
                  onPressed: () {
                    AnalyticsEvent.communityLinkPressed.log();
                    launchUrl(youtubeUri);
                  },
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
                  subtitle: t.settings.leaveReview(store: Platform.isIOS ? 'App Store' : 'Play Store').toText(),
                  leading: Symbols.star.toIcon(),
                  onPressed: () async {
                    AnalyticsEvent.rateLuxPressed.log();
                    await launchUrl(
                      Platform.isIOS ? appStoreReviewUri : playStoreReviewUri,
                      mode: .externalApplication,
                    );
                  },
                  trailing: Symbols.arrow_outward.toIcon(),
                ),
                Builder(
                  builder: (shareContext) => StyledListItem(
                    title: t.settings.shareLux.toText(),
                    subtitle: t.settings.shareLuxDescription.toText(),
                    leading: Symbols.share.toIcon(),
                    onPressed: () async {
                      final renderObject = shareContext.findRenderObject();
                      final origin = renderObject is RenderBox
                          ? renderObject.localToGlobal(Offset.zero) & renderObject.size
                          : null;
                      await SharePlus.instance.share(
                        ShareParams(uri: luxBibleUri, title: 'Lux Bible', sharePositionOrigin: origin),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          StyledSection.child(
            title: t.labels.help.toText(),
            child: StyledCard(
              children: [
                StyledListItem.navigation(
                  title: t.settings.reportProblem.toText(),
                  subtitle: t.settings.reportProblemDescription.toText(),
                  leading: Symbols.bug_report.toIcon(),
                  onPressed: () => context.showStyledSheet(
                    (context, _) => StyledSheet(
                      title: t.settings.reportProblem.toText(),
                      children: [
                        StyledListItem.externalNavigation(
                          title: t.labels.discord.toText(),
                          subtitle: t.settings.recommended.toText(),
                          leading: FaIcon(FontAwesomeIcons.discord),
                          onPressed: () {
                            AnalyticsEvent.communityLinkPressed.log();
                            launchUrl(discordUri);
                          },
                        ),
                        StyledListItem.externalNavigation(
                          title: t.settings.emailSupport.toText(),
                          subtitle: 'support@luxbible.app'.toText(),
                          leading: Symbols.mail.toIcon(),
                          onPressed: () => launchUrl(supportEmailUri),
                        ),
                      ],
                    ),
                  ),
                ),
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
