import 'package:bible/models/main_action.dart';
import 'package:bible/providers/audio_bible_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/providers/verse_of_the_day_provider.dart';
import 'package:bible/ui/pages/main_toolbar_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class MainActionsSheet {
  static Future<MainAction?> show(BuildContext context, {AudioBibleContext audioContext = .bible}) =>
      context.showStyledSheet<MainAction>((sheetContext, ref) {
        final user = ref.watch(userProvider);
        final verseOfTheDay = ref.watch(verseOfTheDayProvider).value;

        return StyledSheet(
          trailing: StyledCircleButton.md(
            child: Symbols.tune.toIcon(),
            onPressed: () {
              sheetContext.pop();
              context.push(MainToolbarSettingsPage());
            },
          ),
          children: MainAction.topLevelActions
              .map(
                (action) => StyledListItem(
                  title: action.title(audioContext: audioContext).toText(),
                  subtitle: Text(
                    action.description(user: user, verseOfTheDay: verseOfTheDay),
                    maxLines: 3,
                    overflow: .ellipsis,
                  ),
                  leading: action.buildIcon(sheetContext, user: user, audioContext: audioContext),
                  trailing: action.isNavigation ? Icon(Symbols.chevron_right) : null,
                  onPressed: () => sheetContext.pop(action),
                ),
              )
              .toList(),
        );
      });
}
