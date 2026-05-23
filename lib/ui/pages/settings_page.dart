import 'package:bible/providers/package_info_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/main_toolbar_settings_page.dart';
import 'package:bible/ui/pages/text_selection_settings_page.dart';
import 'package:bible/ui/pages/verse_selection_settings_page.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

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
