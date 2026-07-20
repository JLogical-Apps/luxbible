import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/text_selection_action.dart';
import 'package:bible/models/verse_selection_action.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/text_selection_settings_page.dart';
import 'package:bible/ui/pages/verse_selection_settings_page.dart';
import 'package:bible/ui/widgets/bible_selection.dart';
import 'package:bible/ui/widgets/text_selection_bottom_bar.dart';
import 'package:bible/ui/widgets/verse_selection_bottom_bar.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class SelectionToolbar extends ConsumerWidget {
  final BibleSelection selection;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const SelectionToolbar({super.key, required this.selection, required this.onNavigateToVerseSelection});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    if (selection.verseSelection case final verseSelection?) {
      return VerseSelectionBottomBar(
        verseSelection: verseSelection,
        configuration: user.verseSelection,
        user: user,
        onClosePressed: selection.clear,
        onShorcutPressed: (_, shortcut) => shortcut.onPressed(
          context,
          verseSelection: verseSelection,
          onDeselect: selection.clearVerses,
          onNavigateToVerseSelection: onNavigateToVerseSelection,
        ),
        onMorePressed: () => context.showStyledSheet(
          (context) => StyledSheet(
            title: 'Verse Selection'.toText(),
            subtitle: verseSelection.format().toText(),
            trailing: StyledCircleButton.md(
              child: Symbols.tune.toIcon(),
              onPressed: () {
                context.pop();
                context.push(VerseSelectionSettingsPage());
              },
            ),
            children: VerseSelectionAction.values
                .map(
                  (action) => StyledListItem(
                    title: action.title().toText(),
                    subtitle: action.description().toText(),
                    leading: action.icon.toIcon(),
                    trailing: action.isNavigation ? Icon(Symbols.chevron_right) : null,
                    onPressed: () {
                      Navigator.of(context).pop();
                      action.onPressed(
                        context,
                        selectedVerseSelection: verseSelection,
                        onDeselect: selection.clearVerses,
                        onNavigateToVerseSelection: onNavigateToVerseSelection,
                      );
                    },
                  ),
                )
                .toList(),
          ),
        ),
      );
    }

    if (selection.textSelection case final textSelection?) {
      return TextSelectionBottomBar(
        textSelection: textSelection,
        configuration: user.textSelection,
        user: user,
        onClosePressed: selection.clear,
        onShorcutPressed: (_, shortcut) => shortcut.onPressed(
          context,
          textSelection: textSelection,
          onDeselect: selection.clearText,
          onNavigateToVerseSelection: onNavigateToVerseSelection,
        ),
        onMorePressed: () async {
          final selectionText = await ref.read(textSelectionTextProvider(textSelection).future);
          if (!context.mounted) return;

          await context.showStyledSheet(
            (context) => StyledSheet(
              title: 'Text Selection'.toText(),
              subtitle: '"$selectionText"'.toText(),
              trailing: StyledCircleButton.md(
                child: Symbols.tune.toIcon(),
                onPressed: () {
                  context.pop();
                  context.push(TextSelectionSettingsPage());
                },
              ),
              children: TextSelectionAction.values
                  .map(
                    (action) => StyledListItem(
                      title: action.title().toText(),
                      subtitle: action.description().toText(),
                      leading: action.icon.toIcon(),
                      trailing: action.isNavigation ? Icon(Symbols.chevron_right) : null,
                      onPressed: () {
                        Navigator.of(context).pop();
                        action.onPressed(
                          context,
                          textSelection: textSelection,
                          onDeselect: selection.clearText,
                          onNavigateToVerseSelection: onNavigateToVerseSelection,
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        },
      );
    }

    return SizedBox.shrink();
  }
}
