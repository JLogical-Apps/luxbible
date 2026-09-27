import 'package:intl/date_symbols.dart';
import 'package:intl/intl.dart';
import 'package:lux/i18n.dart';
import 'package:lux/src/models/time.dart';
import 'package:lux/src/utils/range.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DateTimeExtensions on DateTime {
  DateTime get nextDate => isUtc ? DateTime.utc(year, month, day + 1) : DateTime(year, month, day + 1);

  bool isOnSameLocalDateAs(DateTime other) {
    final local = toLocal();
    final otherLocal = other.toLocal();
    return local.year == otherLocal.year && local.month == otherLocal.month && local.day == otherLocal.day;
  }

  DateTime withTime(Time time) => DateTime(year, month, day, time.hour, time.minute);

  DateTime addDays(int count) => DateTime(year, month, day + count);

  // Compares UTC calendar dates so daylight saving shifts can't turn a day into 23 hours.
  int getDaysUntil(DateTime other) =>
      DateTime.utc(other.year, other.month, other.day).difference(DateTime.utc(year, month, day)).inDays;

  int getMonthsUntil(DateTime other) => (other.year - year) * 12 + other.month - month;

  List<DateTime> getFollowingDates({required int count}) =>
      Range.generate(0, count - 1).map((offset) => DateTime(year, month, day + offset)).toList();

  String formatAgo() => timeago.format(this, locale: LocaleSettings.currentLocale.languageCode);

  String formatDate() => DateFormat.yMMMd(LocaleSettings.currentLocale.languageCode).format(this);

  String formatMonthAndYear() => DateFormat.yMMMM(LocaleSettings.currentLocale.languageCode).format(this);

  /// The calendar date alone, as `yyyy-MM-dd`.
  String get isoDate =>
      '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
}

enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  static DateSymbols get dateSymbols => DateFormat(null, LocaleSettings.currentLocale.languageCode).dateSymbols;

  static Weekday fromDateTime(DateTime date) => values[date.weekday - 1];

  // Intl counts the locale's first day of the week from Monday = 0.
  static List<Weekday> get localizedOrder {
    final firstIndex = dateSymbols.FIRSTDAYOFWEEK;
    return [...values.skip(firstIndex), ...values.take(firstIndex)];
  }

  // Intl lists weekday names starting from Sunday.
  String formatShort() => dateSymbols.STANDALONESHORTWEEKDAYS[(index + 1) % 7];
}

extension TimeNotificationExtensions on Time {
  DateTime getNextNotificationDate({DateTime? startDate}) {
    final now = DateTime.now();
    final today = now.withTime(this);
    final firstAllowedDate = startDate?.withTime(this) ?? today;
    final nextDate = firstAllowedDate.isAfter(today) ? firstAllowedDate : today;
    return nextDate.isAfter(now) ? nextDate : now.nextDate.withTime(this);
  }
}
