import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/providers/verse_of_the_day_local_notification_schedules_provider.dart';
import 'package:bible/ui/flows/local_notification_permission_flow.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class VerseOfTheDayReminderFlow {
  static Future<void> showDiscoveryPrompt(BuildContext context) async {
    final user = ref.read(userProvider);
    if (user.verseOfTheDayReminder != null) return;

    final shouldAdd = await context.showStyledDialog(
      (context) => StyledDialog.confirmOrCancel(
        title: t.verseOfTheDay.reminderDiscoveryTitle.toText(),
        body: t.verseOfTheDay.reminderDiscoveryBody.toText(),
        confirmLabel: t.verseOfTheDay.addReminder.toText(),
        cancelLabel: t.verseOfTheDay.noReminder.toText(),
      ),
      isDismissible: false,
    );
    if (!context.mounted) return;

    ref.updateUser((user) => user.withVerseOfTheDayNotificationReminder(.none()));
    if (shouldAdd != true) return;

    final time = await context.showStyledSheet(
      (context, _) => StyledTimeDialSheet(title: t.verseOfTheDay.dailyReminders.toText(), initialTime: .now()),
    );
    if (time != null && context.mounted) await save(context: context, time: time);
  }

  static Future<bool> save({required BuildContext context, required Time time}) async {
    final hasPermission = await LocalNotificationPermissionFlow.request(
      context: context,
      androidChannelId: verseOfTheDayReminderNotificationChannelId,
      permissionDeniedTitle: t.verseOfTheDay.reminderPermissionDeniedTitle,
      permissionDeniedBody: t.verseOfTheDay.reminderPermissionDeniedBody,
      openSettingsLabel: t.verseOfTheDay.openNotificationSettings,
      cancelLabel: t.common.cancel,
      errorTitle: t.verseOfTheDay.reminderSchedulingFailedTitle,
      errorBody: t.verseOfTheDay.reminderSchedulingFailedBody,
    );
    if (!context.mounted || !hasPermission) return false;

    ref.updateUser((user) => user.withVerseOfTheDayNotificationReminder(.daily(time: time)));
    context.showStyledSnackbar(
      message: t.verseOfTheDay.reminderSaved(time: time.format(format: context.timeFormat)).toText(),
    );
    return true;
  }

  static void remove() => ref.updateUser((user) => user.withVerseOfTheDayNotificationReminder(.none()));
}
