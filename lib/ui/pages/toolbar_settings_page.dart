import 'package:bible/models/book_type.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/toolbar_shortcut.dart';
import 'package:bible/models/user.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_selection_sheet.dart';
import 'package:bible/style/widgets/styled_page.dart';
import 'package:bible/style/widgets/styled_section.dart';
import 'package:bible/style/widgets/styled_select.dart';
import 'package:bible/ui/widgets/toolbar.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ToolbarSettingsPage extends ConsumerWidget {
  const ToolbarSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return StyledPage(
      titleText: 'Toolbar Settings',
      body: Column(
        children: [
          ColoredBox(
            color: context.colors.surfacePrimary,
            child: StyledSection(
              titleText: 'Toolbar',
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Toolbar(
                toolbar: user.toolbar,
                chapterReference: ChapterReference(book: BookType.genesis, chapterNum: 1),
                translation: user.translation,
                user: user,
                onPressed: () {},
                onMorePressed: () {},
                onShorcutPressed: (shortcutIndex, shortcut) async {
                  final newShortcut = await showSelectToolbarSheet(context, initialShortcut: shortcut, user: user);
                  if (newShortcut != null) {
                    ref.updateUser(
                      (user) => user.copyWith(toolbar: user.toolbar.withPinnedShortcut(shortcutIndex, newShortcut)),
                    );
                  }
                },
                isEdit: true,
                color: context.colors.surfaceTertiary,
              ),
            ),
          ),
          Expanded(child: ListView(children: [])),
        ],
      ),
    );
  }

  Future<ToolbarShortcut?> showSelectToolbarSheet(
    BuildContext context, {
    required ToolbarShortcut initialShortcut,
    required User user,
  }) => context.showStyledSheet(
    StyledSelectionSheet(
      titleText: 'Toolbar Shortcut',
      options: ToolbarShortcut.values,
      initialOption: initialShortcut,
      optionMapper: (shortcut) => StyledSelectOption(
        titleText: shortcut.title(user: user, reference: null),
        subtitleText: shortcut.description(user: user, reference: null),
        leading: shortcut.buildIcon(context, user: user, reference: null),
      ),
    ),
  );
}
