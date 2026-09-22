import 'package:bible/functions/bible_plan_notification.dart';
import 'package:bible/models/hydrated_bible_plan_progress.dart';
import 'package:bible/models/reminder.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/language_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/local_notification_service.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bible_plan_local_notification_schedules_provider.g.dart';

const biblePlanReminderNotificationChannelId = 'app.luxbible.app.channel.bible_plan_reminders';
const biblePlanNotificationCapacity = 14;

@Riverpod(keepAlive: true)
List<LocalNotification> biblePlanLocalNotifications(Ref ref) {
  final plans = ref.watch(biblePlansProvider);
  final user = ref.watch(userProvider);
  ref.watch(languageProvider);

  final reminderProgresses = user
      .getHydratedPlanProgresses(plans)
      .where((progress) => progress.progress.reminder is DailyReminder && !progress.isCompleted)
      .take(biblePlanNotificationCapacity)
      .toList();

  if (reminderProgresses.isEmpty) return [];

  final horizonDays = biblePlanNotificationCapacity ~/ reminderProgresses.length;

  return reminderProgresses.expand((progress) {
    final HydratedBiblePlanProgress(id: planId, :currentDay) = progress;
    final DailyReminder(:time) = progress.progress.reminder as DailyReminder;

    return time
        .getNextNotificationDate(startDate: progress.progress.wasCompletedToday() ? .now().nextDate : null)
        .getFollowingDates(count: horizonDays)
        .map(
          (date) => LocalNotification(
            id: BiblePlanNotification.getNotificationIdFor(planId, date),
            channel: LocalNotificationChannel(
              id: biblePlanReminderNotificationChannelId,
              name: t.biblePlans.reminderNotificationChannelName,
              description: t.biblePlans.reminderNotificationChannelDescription,
            ),
            title: t.biblePlans.reminderNotificationTitle(name: progress.plan.getDisplayName(planId)),
            body: t.biblePlans.reminderNotificationBody(
              reading: currentDay.isReviewAndReflect
                  ? t.biblePlans.reviewAndReflect
                  : currentDay.passages.map((passage) => passage.format()).join(', '),
            ),
            time: DateTime(date.year, date.month, date.day, time.hour, time.minute),
            payload: BiblePlanNotification.getNotificationPrefixFor(planId),
          ),
        );
  }).toList();
}
