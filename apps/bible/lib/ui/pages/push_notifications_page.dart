import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/bible_plan_local_notification_schedules_provider.dart';
import 'package:bible/providers/local_notification_schedules_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/local_notification_service.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class PushNotificationsPage extends ConsumerWidget {
  const PushNotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final availability = ref
        .watch(localNotificationAvailabilityProvider(androidChannelId: biblePlanReminderNotificationChannelId))
        .value;

    final isEnabled = availability == .enabled;

    final reminders = user.planProgressByType
        .where((planType, progress) => progress.reminder is DailyBiblePlanReminder)
        .mapToIterable((planType, progress) => (planType: planType, time: progress.reminder!.dailyTime!))
        .toList();

    return StyledPage(
      title: t.settings.pushNotifications.toText(),
      backgroundColor: .backgroundPrimary,
      body: ListView(
        children: [
          if (availability case final availability? when availability != .enabled)
            Padding(
              padding: .only(left: 16, top: 16, right: 16),
              child: StyledCard.child(
                child: StyledListItem(
                  leading: Symbols.notifications_off.toIcon(),
                  title: switch (availability) {
                    .notRequested => t.settings.notificationsNotRequested.toText(),
                    .channelDisabled => t.settings.biblePlanRemindersDisabled.toText(),
                    _ => t.settings.notificationsDisabled.toText(),
                  },
                  subtitle: switch (availability) {
                    .notRequested => t.settings.notificationsNotRequestedDescription.toText(),
                    _ => t.settings.notificationsDisabledDescription.toText(),
                  },
                  trailing: switch (availability) {
                    .notRequested => Symbols.notifications.toIcon(),
                    _ => Symbols.arrow_outward.toIcon(),
                  },
                  onPressed: () async {
                    final notifications = ref.read(localNotificationServiceProvider);
                    final hasPermission = availability == .notRequested
                        ? await notifications.requestPermission()
                        : await notifications.openSettingsAndCheckPermission();
                    if (hasPermission) {
                      await notifications.synchronize(ref.read(localNotificationSchedulesProvider));
                    }
                    ref.invalidate(
                      localNotificationAvailabilityProvider(androidChannelId: biblePlanReminderNotificationChannelId),
                    );
                  },
                ),
              ),
            ),
          StyledSection.child(
            title: t.settings.biblePlanReminders.toText(),
            isEnabled: isEnabled,
            child: reminders.isEmpty
                ? StyledTile.message(
                    leading: Symbols.notifications_none.toIcon(),
                    title: t.settings.noBiblePlanReminders.toText(),
                    subtitle: t.settings.noBiblePlanRemindersDescription.toText(),
                    isEnabled: isEnabled,
                  )
                : StyledCard(
                    children: reminders
                        .map(
                          (reminder) => StyledListItem(
                            title: reminder.planType.title().toText(),
                            subtitle: t.biblePlans
                                .dailyAt(time: reminder.time.format(format: context.timeFormat))
                                .toText(),
                            isEnabled: isEnabled,
                            trailing: Tooltip(
                              message: t.biblePlans.deleteReminder,
                              child: StyledCircleButton.md(
                                colorBuilder: .surfaceSecondary,
                                child: Symbols.delete.toIcon(),
                                onPressed: isEnabled
                                    ? () async {
                                        final shouldDelete = await context.showStyledDialog(
                                          (context) => StyledDialog.confirmDelete(
                                            title: t.biblePlans.deleteReminder.toText(),
                                            body: t.biblePlans
                                                .deleteReminderConfirmation(name: reminder.planType.title())
                                                .toText(),
                                            cancelLabel: t.common.nevermind.toText(),
                                          ),
                                        );
                                        if (shouldDelete == true) {
                                          ref.updateUser((user) => user.withPlanReminder(reminder.planType, .none()));
                                        }
                                      }
                                    : null,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
