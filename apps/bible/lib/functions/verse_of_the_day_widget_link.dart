import 'package:bible/functions/verse_of_the_day_preview.dart';
import 'package:bible/services/analytics_service.dart';
import 'package:lux/lux_core.dart';
import 'package:utils_core/utils_core.dart';

class VerseOfTheDayWidgetLink {
  static const scheme = 'luxbible';
  static const host = 'verse-of-the-day';

  static bool handleLink(String link) {
    final date = getDateForLink(link);
    if (date == null || !VerseOfTheDayPreview.show(date)) return false;

    AnalyticsEvent.verseOfTheDayWidgetTapped.log();
    return true;
  }

  /// A widget whose horizon has run out links without a date, so it opens today's passage.
  static DateTime? getDateForLink(String link) {
    if (Uri.tryParse(link) case final uri? when uri.scheme == scheme && uri.host == host) {
      final requested = uri.queryParameters['date'];
      return (requested == null ? null : tryDecodeIsoDate(requested)) ?? DateTime.now().withoutTime();
    }
    return null;
  }
}
