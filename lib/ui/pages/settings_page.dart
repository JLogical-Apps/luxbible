import 'package:bible/models/user/theme_mode.dart';
import 'package:bible/providers/package_info_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/annotations_page.dart';
import 'package:bible/ui/pages/main_toolbar_settings_page.dart';
import 'package:bible/ui/pages/text_selection_settings_page.dart';
import 'package:bible/ui/pages/verse_selection_settings_page.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
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
            title: 'Features'.toText(),
            child: StyledCard(
              children: [
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
                  leading: Symbols.text_format.toIcon(),
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
                  onPressed: () => context.push(VerseSelectionSettingsPage()),
                ),
              ],
            ),
          ),
          StyledSection.child(
            title: 'Theme'.toText(),
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
            title: 'Community'.toText(),
            child: StyledCard(
              children: [
                StyledListItem(
                  title: 'Discord'.toText(),
                  subtitle: 'Feedback and announcements'.toText(),
                  leading: FaIcon(FontAwesomeIcons.discord),
                  onPressed: () => launchUrl(Uri.parse('https://discord.gg/C4zfZDpZMB')),
                  trailing: Symbols.arrow_outward.toIcon(),
                ),
                StyledListItem(
                  title: 'Instagram'.toText(),
                  subtitle: 'Tips and updates about Lux'.toText(),
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
