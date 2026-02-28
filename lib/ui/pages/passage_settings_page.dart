import 'package:bible/models/book_type.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/user/passage_shortcut.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_selection_sheet.dart';
import 'package:bible/style/widgets/styled_page.dart';
import 'package:bible/style/widgets/styled_section.dart';
import 'package:bible/style/widgets/styled_select.dart';
import 'package:bible/ui/widgets/passage_bottom_bar.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PassageSettingsPage extends ConsumerWidget {
  const PassageSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final passageConfiguration = user.passage;

    return StyledPage(
      titleText: 'Passage Settings',
      body: Column(
        children: [
          ColoredBox(
            color: context.colors.surfacePrimary,
            child: StyledSection.child(
              titleText: 'Toolbar',
              padding: EdgeInsets.symmetric(vertical: 16),
              childPadding: EdgeInsets.symmetric(horizontal: 8),
              child: PassageBottomBar(
                configuration: passageConfiguration,
                user: user,
                passage: Passage.reference(Reference(book: BookType.genesis, chapterNum: 1, verseNum: 1)),
                onMorePressed: () {},
                onClosePressed: () {},
                onShorcutPressed: (shortcutIndex, shortcut) async {
                  final newShortcut = await showSelectToolbarSheet(context, initialShortcut: shortcut, user: user);
                  if (newShortcut != null) {
                    ref.updateUser(
                      (user) =>
                          user.copyWith(passage: passageConfiguration.withPinnedShortcut(shortcutIndex, newShortcut)),
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

  Future<PassageShortcut?> showSelectToolbarSheet(
    BuildContext context, {
    required PassageShortcut initialShortcut,
    required User user,
  }) => context.showStyledSheet(
    StyledSelectionSheet(
      titleText: 'Passage Shortcut',
      options: PassageShortcut.values,
      initialOption: initialShortcut,
      optionMapper: (shortcut) => StyledSelectOption(
        titleText: shortcut.title(),
        subtitleText: shortcut.description(),
        leading: shortcut.buildIcon(context),
      ),
    ),
  );
}
