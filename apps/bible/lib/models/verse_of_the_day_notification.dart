import 'package:bible/main.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/verse_of_the_day_provider.dart';
import 'package:bible/services/local_notification_service.dart';
import 'package:bible/services/analytics_service.dart';
import 'package:bible/ui/pages/bible_page.dart';
import 'package:bible/ui/sheets/preview_passage_sheet.dart';
import 'package:lux/lux.dart';

class VerseOfTheDayNotification {
  static bool handlePayload(String payload) {
    final date = VerseOfTheDayNotification.getDateForPayload(payload);
    if (date == null) return false;

    final context = navigatorKey.currentContext;
    if (context == null) return false;

    AnalyticsEvent.notificationTapped.log();
    final selection = ref.read(verseOfTheDaySelectionsProvider)[getVerseOfTheDayIndex(date)];
    context.goToStack([
      (context) => BiblePage(),
    ], onLoaded: (context) => PreviewPassageSheet.show(context, verseSelection: selection));
    return true;
  }

  static int getNotificationIdFor(DateTime date) => 32000000 + date.year * 10000 + date.month * 100 + date.day;

  static String getNotificationPrefixFor(DateTime date) =>
      '${LocalNotificationService.payloadPrefix}verse-of-the-day:${date.notificationDate}';

  static DateTime? getDateForPayload(String payload) {
    final prefix = '${LocalNotificationService.payloadPrefix}verse-of-the-day:';
    if (!payload.startsWith(prefix)) return null;

    final data = payload.substring(prefix.length);
    final date = DateTime.tryParse(data);
    return date?.notificationDate == data ? date : null;
  }
}

extension on DateTime {
  String get notificationDate =>
      '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
}
