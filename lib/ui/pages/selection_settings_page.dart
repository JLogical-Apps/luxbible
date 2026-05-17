import 'package:bible/models/user/selection_shortcut.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/selection_bottom_bar.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class SelectionSettingsPage extends ConsumerWidget {
  const SelectionSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    final selectionConfiguration = user.selection;

    return StyledPage(
      backgroundColor: .backgroundPrimary,
      title: 'Selection Settings'.toText(),
      body: Column(
        children: [
          ColoredBox(
            color: context.colors.surfacePrimary,
            child: StyledSection.child(
              title: 'Toolbar'.toText(),
              padding: .symmetric(vertical: 16),
              childPadding: .symmetric(horizontal: 8),
              child: SelectionBottomBar(
                configuration: selectionConfiguration,
                user: user,
                selection: null,
                onMorePressed: () {},
                onClosePressed: () {},
                onShorcutPressed: (shortcutIndex, shortcut) async {
                  final newShortcut = await showSelectToolbarSheet(context, initialShortcut: shortcut);
                  if (newShortcut != null) {
                    ref.updateUser(
                      (user) => user.copyWith(
                        selection: selectionConfiguration.withPinnedShortcut(shortcutIndex, newShortcut),
                      ),
                    );
                  }
                },
                isEdit: true,
                color: context.colors.surfaceTertiary,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                StyledSection.child(
                  title: 'Selection'.toText(),
                  child: StyledCard(
                    children: [
                      StyledListItem.switchControl(
                        title: 'Expand to Annotation'.toText(),
                        subtitle: 'Long-pressing an annotated word selects its full highlighted range.'.toText(),
                        leading: Symbols.aspect_ratio.toIcon(),
                        selected: selectionConfiguration.expandToAnnotation,
                        onSelected: (newValue) =>
                            ref.updateUser((user) => user.copyWith.selection(expandToAnnotation: newValue)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<SelectionShortcut?> showSelectToolbarSheet(
    BuildContext context, {
    required SelectionShortcut initialShortcut,
  }) => context.showStyledSheet(
    (context) => StyledSelectionSheet(
      title: 'Selection Shortcut'.toText(),
      options: SelectionShortcut.values,
      initialOption: initialShortcut,
      optionMapper: (shortcut) => StyledSelectOption(
        title: shortcut.title().toText(),
        subtitle: shortcut.description().toText(),
        leading: shortcut.buildIcon(context),
      ),
    ),
  );
}
