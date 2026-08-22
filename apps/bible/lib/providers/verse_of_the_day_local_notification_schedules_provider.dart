import 'package:bible/models/verse_of_the_day_notification.dart';
import 'package:bible/providers/language_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/providers/verse_of_the_day_provider.dart';
import 'package:bible/services/local_notification_service.dart';
import 'package:bible/utils/extensions/date_time_extensions.dart';
import 'package:lux/i18n.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:utils_core/utils_core.dart';

part 'verse_of_the_day_local_notification_schedules_provider.g.dart';

const verseOfTheDayReminderNotificationChannelId = 'app.luxbible.app.channel.verse_of_the_day_reminders';

const verseOfTheDayNotificationHorizonDays = 14;

@Riverpod(keepAlive: true)
Future<List<LocalNotification>> verseOfTheDayLocalNotifications(Ref ref) async {
  final user = ref.watch(userProvider);
  ref.watch(languageProvider);

  final time = user.verseOfTheDayReminder?.dailyTime;
  if (time == null) return [];

  final dates = time.getNextNotificationDate().getFollowingDates(count: verseOfTheDayNotificationHorizonDays);

  return (await dates.map((date) async {
    final verseOfTheDay = await guardAsync(() => ref.read(verseOfTheDayForDateProvider(date: date).future));
    if (verseOfTheDay == null) return null;

    return LocalNotification(
      id: VerseOfTheDayNotification.getNotificationIdFor(date),
      channel: LocalNotificationChannel(
        id: verseOfTheDayReminderNotificationChannelId,
        name: t.verseOfTheDay.reminderNotificationChannelName,
        description: t.verseOfTheDay.reminderNotificationChannelDescription,
      ),
      title: t.verseOfTheDay.reminderNotificationTitle,
      body: verseOfTheDay.format(),
      time: DateTime(date.year, date.month, date.day, time.hour, time.minute),
      payload: VerseOfTheDayNotification.getNotificationPrefixFor(date),
    );
  }).wait).nonNulls.toList();
}
