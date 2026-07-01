import 'package:bible/providers/package_info_provider.dart';
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
