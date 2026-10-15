import 'package:bible/providers/user_provider.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class NavigationSettingsPage extends ConsumerWidget implements StyledRoute<void> {
  const NavigationSettingsPage({super.key});

  @override
  String get path => '/settings/navigation';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigation = ref.watch(userProvider.select((user) => user.navigation));

    return StyledPage(
      backgroundColor: .backgroundPrimary,
      title: t.navigationSettings.title.toText(),
      body: ListView(
        children: [
          StyledSection.child(
            title: t.labels.layout.toText(),
            child: StyledCard.child(
              padding: .all(4),
              child: StyledSegmentedControl(
                colorBuilder: .surfacePrimary,
                options: NavigationLayout.values,
                selectedOption: navigation.layout,
                onOptionSelected: (layout) => ref.updateUser((user) => user.copyWith.navigation(layout: layout)),
                optionBuilder: (layout) => StyledSelectOption(
                  title: Text(layout.title()),
                  leading: switch (layout) {
                    .list => Symbols.list,
                    .grid => Symbols.grid_view,
                  }.toIcon(),
                ),
              ),
            ),
          ),
          StyledSection.child(
            title: t.navigationSettings.general.toText(),
            child: StyledCard(
              children: [
                StyledListItem.switchControl(
                  title: t.navigationSettings.showRecents.toText(),
                  subtitle: t.navigationSettings.showRecentsDescription.toText(),
                  leading: Symbols.history.toIcon(),
                  isSelected: navigation.showsRecents,
                  onSelected: (newValue) => ref.updateUser((user) => user.copyWith.navigation(showsRecents: newValue)),
                ),
                StyledListItem.switchControl(
                  title: t.navigationSettings.openKeyboard.toText(),
                  subtitle: t.navigationSettings.openKeyboardDescription.toText(),
                  leading: Symbols.keyboard.toIcon(),
                  isSelected: navigation.opensKeyboard,
                  onSelected: (newValue) => ref.updateUser((user) => user.copyWith.navigation(opensKeyboard: newValue)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
