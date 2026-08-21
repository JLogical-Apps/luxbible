import 'package:bible/models/user/language.dart';
import 'package:lux/lux.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DateTimeExtensions on DateTime {
  DateTime get nextDate => isUtc ? DateTime.utc(year, month, day + 1) : DateTime(year, month, day + 1);

  bool isOnSameLocalDateAs(DateTime other) {
    final local = toLocal();
    final otherLocal = other.toLocal();
    return local.year == otherLocal.year && local.month == otherLocal.month && local.day == otherLocal.day;
  }

  DateTime withTime(Time time) => DateTime(year, month, day, time.hour, time.minute);

  List<DateTime> getFollowingDates({required int count}) =>
      Range.generate(0, count - 1).map((offset) => DateTime(year, month, day + offset)).toList();

  String formatAgo() => timeago.format(this, locale: Language.device.code);
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
