import 'package:bible/models/bible_plan.dart';
import 'package:bible/models/bible_plan_notification.dart';
import 'package:bible/models/hydrated_bible_plan_progress.dart';
import 'package:bible/models/reminder.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/language_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/local_notification_service.dart';
import 'package:bible/utils/extensions/date_time_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:utils_core/utils_core.dart';

part 'bible_plan_local_notification_schedules_provider.g.dart';

const biblePlanReminderNotificationChannelId = 'app.luxbible.app.channel.bible_plan_reminders';

@Riverpod(keepAlive: true)
List<LocalNotification> biblePlanLocalNotifications(Ref ref) {
  final plans = ref.watch(biblePlansProvider);
  final progressByType = ref.watch(userProvider.select((user) => user.planProgressByType));
  ref.watch(languageProvider);

  return progressByType
      .mapToIterable((type, progress) => HydratedBiblePlanProgress(type: type, plan: plans[type]!, progress: progress))
      .map(
        (progress) => switch (progress.progress.reminder) {
          DailyReminder(:final time) when !progress.isCompleted => () {
            final HydratedBiblePlanProgress(type: planType, :currentDay) = progress;

            final reading = currentDay.isReviewAndReflect
                ? t.biblePlans.reviewAndReflect
                : currentDay.passages.map((passage) => passage.format()).join(', ');

            return LocalNotification(
              id: planType.notificationId,
              channel: LocalNotificationChannel(
                id: biblePlanReminderNotificationChannelId,
                name: t.biblePlans.reminderNotificationChannelName,
                description: t.biblePlans.reminderNotificationChannelDescription,
              ),
              title: t.biblePlans.reminderNotificationTitle(name: planType.title()),
              body: t.biblePlans.reminderNotificationBody(reading: reading),
              schedule: RepeatingLocalNotificationSchedule(
                time: time,
                startDate: progress.progress.wasCompletedToday() ? .now().nextDate : null,
              ),
              payload: BiblePlanNotification.getNotificationPrefixFor(planType),
            );
          }(),
          _ => null,
        },
      )
      .nonNulls
      .toList();
}

extension BiblePlanReminderNotificationId on BiblePlanType {
  int get notificationId => switch (this) {
    .esv_through_the_bible => 31001,
    .one_year_chronological => 31002,
    .heartlight_ot_and_nt => 31003,
    .esv_every_day_in_word => 31004,
    .mcheyne => 31005,
    .esv_literary_study_bible => 31006,
    .heartlight_different_topics => 31007,
    .heartlight_nt_psalms_proverbs => 31008,
    .navigators_5x5x5_nt => 31009,
    .esv_gospels_and_epistles => 31010,
    .esv_pentateuch_and_history_of_israel => 31011,
    .esv_chronicles_and_prophets => 31012,
    .esv_psalms_and_wisdom_literature => 31013,
  };
}
