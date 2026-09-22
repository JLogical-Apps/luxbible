import 'package:bible/functions/verse_of_the_day_preview.dart';
import 'package:bible/services/analytics_service.dart';
import 'package:bible/services/local_notification_service.dart';
import 'package:lux/lux_core.dart';

class VerseOfTheDayNotification {
  static bool handlePayload(String payload) {
    final date = getDateForPayload(payload);
    if (date == null || !VerseOfTheDayPreview.show(date)) return false;

    AnalyticsEvent.notificationTapped.log();
    return true;
  }

  static int getNotificationIdFor(DateTime date) => 32000000 + date.year * 10000 + date.month * 100 + date.day;

  static String getNotificationPrefixFor(DateTime date) =>
      '${LocalNotificationService.payloadPrefix}verse-of-the-day:${date.isoDate}';

  static DateTime? getDateForPayload(String payload) {
    final prefix = '${LocalNotificationService.payloadPrefix}verse-of-the-day:';
    if (!payload.startsWith(prefix)) return null;

    return tryDecodeIsoDate(payload.substring(prefix.length));
  }
}
