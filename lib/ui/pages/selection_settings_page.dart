import 'package:bible/models/book_type.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/models/user/selection_shortcut.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_selection_sheet.dart';
import 'package:bible/style/widgets/styled_page.dart';
import 'package:bible/style/widgets/styled_section.dart';
import 'package:bible/style/widgets/styled_select.dart';
import 'package:bible/ui/widgets/selection_bottom_bar.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectionSettingsPage extends ConsumerWidget {
  const SelectionSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final bibles = ref.watch(biblesProvider);
    final bible = user.getBible(bibles);

    final selectionConfiguration = user.selection;

    return StyledPage(
      titleText: 'Selection Settings',
      body: Column(
        children: [
          ColoredBox(
            color: context.colors.surfacePrimary,
            child: StyledSection.child(
              titleText: 'Toolbar',
              padding: EdgeInsets.symmetric(vertical: 16),
              childPadding: EdgeInsets.symmetric(horizontal: 8),
              child: SelectionBottomBar(
                configuration: selectionConfiguration,
                user: user,
                bible: bible,
                selection: Selection(
                  start: SelectionWordAnchor(book: BookType.genesis, chapterNum: 1, verseNum: 1, characterOffset: 0),
                  end: SelectionWordAnchor(book: BookType.genesis, chapterNum: 1, verseNum: 1, characterOffset: 30),
                  translation: user.translation,
                ),
                onMorePressed: () {},
                onClosePressed: () {},
                onShorcutPressed: (shortcutIndex, shortcut) async {
                  final newShortcut = await showSelectToolbarSheet(context, initialShortcut: shortcut, user: user);
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
        ],
      ),
    );
  }

  Future<SelectionShortcut?> showSelectToolbarSheet(
    BuildContext context, {
    required SelectionShortcut initialShortcut,
    required User user,
  }) => context.showStyledSheet(
    StyledSelectionSheet(
      titleText: 'Selection Shortcut',
      options: SelectionShortcut.values,
      initialOption: initialShortcut,
      optionMapper: (shortcut) => StyledSelectOption(
        titleText: shortcut.title(),
        subtitleText: shortcut.description(),
        leadingIcon: shortcut.icon,
      ),
    ),
  );
}
