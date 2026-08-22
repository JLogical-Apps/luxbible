import 'package:bible/models/bible_plan_notification.dart';
import 'package:bible/models/hydrated_bible_plan_progress.dart';
import 'package:bible/models/reminder.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/language_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/local_notification_service.dart';
import 'package:bible/utils/extensions/date_time_extensions.dart';
import 'package:lux/i18n.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:utils_core/utils_core.dart';

part 'bible_plan_local_notification_schedules_provider.g.dart';

const biblePlanReminderNotificationChannelId = 'app.luxbible.app.channel.bible_plan_reminders';
const biblePlanNotificationCapacity = 14;

@Riverpod(keepAlive: true)
List<LocalNotification> biblePlanLocalNotifications(Ref ref) {
  final plans = ref.watch(biblePlansProvider);
  final progressByType = ref.watch(userProvider).planProgressByType;
  ref.watch(languageProvider);

  final reminderProgresses = progressByType
      .mapToIterable((type, progress) => HydratedBiblePlanProgress(type: type, plan: plans[type]!, progress: progress))
      .where((progress) => progress.progress.reminder is DailyReminder && !progress.isCompleted)
      .toList();

  if (reminderProgresses.isEmpty) return [];

  final horizonDays = biblePlanNotificationCapacity ~/ reminderProgresses.length;

  return reminderProgresses.expand((progress) {
    final HydratedBiblePlanProgress(type: planType, :currentDay) = progress;
    final DailyReminder(:time) = progress.progress.reminder as DailyReminder;

    return time
        .getNextNotificationDate(startDate: progress.progress.wasCompletedToday() ? .now().nextDate : null)
        .getFollowingDates(count: horizonDays)
        .map(
          (date) => LocalNotification(
            id: BiblePlanNotification.getNotificationIdFor(planType, date),
            channel: LocalNotificationChannel(
              id: biblePlanReminderNotificationChannelId,
              name: t.biblePlans.reminderNotificationChannelName,
              description: t.biblePlans.reminderNotificationChannelDescription,
            ),
            title: t.biblePlans.reminderNotificationTitle(name: planType.title()),
            body: t.biblePlans.reminderNotificationBody(
              reading: currentDay.isReviewAndReflect
                  ? t.biblePlans.reviewAndReflect
                  : currentDay.passages.map((passage) => passage.format()).join(', '),
            ),
            time: DateTime(date.year, date.month, date.day, time.hour, time.minute),
            payload: BiblePlanNotification.getNotificationPrefixFor(planType),
          ),
        );
  }).toList();
}
