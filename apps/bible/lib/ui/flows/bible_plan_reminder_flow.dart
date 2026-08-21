import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/bible_plan_local_notification_schedules_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/flows/local_notification_permission_flow.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class BiblePlanReminderFlow {
  static Future<void> showDiscoveryPrompt({required BuildContext context, required BiblePlanType planType}) async {
    final user = ref.read(userProvider);
    final progress = user.planProgressByType[planType];
    if (progress == null || progress.reminder != null) return;

    final shouldAdd = await context.showStyledDialog(
      (context) => StyledDialog.confirmOrCancel(
        title: t.biblePlans.reminderDiscoveryTitle.toText(),
        body: t.biblePlans.reminderDiscoveryBody(name: planType.title()).toText(),
        confirmLabel: t.biblePlans.addReminder.toText(),
        cancelLabel: t.biblePlans.noReminder.toText(),
      ),
      isDismissible: false,
    );
    if (!context.mounted) return;

    ref.updateUser((user) => user.withPlanReminder(planType, .none()));
    if (shouldAdd != true) return;

    final time = await context.showStyledSheet(
      (context, _) => StyledTimeDialSheet(title: t.biblePlans.dailyReminders.toText(), initialTime: Time.now()),
    );
    if (time != null && context.mounted) {
      await save(context: context, planType: planType, time: time);
    }
  }

  static Future<bool> save({required BuildContext context, required BiblePlanType planType, required Time time}) async {
    if (!ref.read(userProvider).planProgressByType.containsKey(planType)) return false;

    final hasPermission = await LocalNotificationPermissionFlow.request(
      context: context,
      androidChannelId: biblePlanReminderNotificationChannelId,
      permissionDeniedTitle: t.biblePlans.reminderPermissionDeniedTitle,
      permissionDeniedBody: t.biblePlans.reminderPermissionDeniedBody,
      openSettingsLabel: t.biblePlans.openNotificationSettings,
      cancelLabel: t.common.cancel,
      errorTitle: t.biblePlans.reminderSchedulingFailedTitle,
      errorBody: t.biblePlans.reminderSchedulingFailedBody,
    );
    if (!context.mounted || !hasPermission) return false;

    ref.updateUser((user) => user.withPlanReminder(planType, .daily(time: time)));
    context.showStyledSnackbar(
      message: t.biblePlans
          .reminderSaved(
            name: planType.title(),
            time: time.format(format: context.timeFormat),
          )
          .toText(),
    );
    return true;
  }
}
