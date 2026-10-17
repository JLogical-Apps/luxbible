import 'package:bible/models/main_action.dart';
import 'package:bible/providers/audio_bible_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/providers/verse_of_the_day_provider.dart';
import 'package:bible/ui/pages/main_toolbar_settings_page.dart';
import 'package:bible/ui/sheets/whats_new_sheet.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class MainActionsSheet {
  static Future<MainAction?> show(
    BuildContext context, {
    AudioBibleContext audioContext = .bible,
    bool showsPendingItems = false,
  }) => context.showStyledSheet<MainAction>((sheetContext, ref) {
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
      children: [
        if (showsPendingItems && user.hasUnseenWhatsNew)
          StyledListItem(
            title: t.whatsNew.title.toText(),
            subtitle: t.whatsNew.description.toText(),
            leading: StyledNotificationDot(child: Symbols.new_releases.toIcon()),
            onPressed: () {
              sheetContext.pop();
              WhatsNewSheet.show(context);
            },
          ),
        if (showsPendingItems)
          ...user.pendingOnboardingTours.map(
            (tour) => StyledListItem(
              title: tour.title().toText(),
              subtitle: tour.description().toText(),
              leading: StyledNotificationDot(child: tour.icon.toIcon()),
              onPressed: () {
                ref.startOnboarding(tour);
                sheetContext.pop();
              },
            ),
          ),
        ...MainAction.topLevelActions.map(
          (action) => StyledListItem(
            title: action.title(audioContext: audioContext).toText(),
            subtitle: Text(
              action.description(user: user, verseOfTheDay: verseOfTheDay, audioContext: audioContext),
              maxLines: 3,
              overflow: .ellipsis,
            ),
            leading: action.buildIcon(sheetContext, user: user, audioContext: audioContext),
            trailing: action.isNavigation ? Icon(Symbols.chevron_right) : null,
            onPressed: () => sheetContext.pop(action),
          ),
        ),
      ],
    );
  });
}
