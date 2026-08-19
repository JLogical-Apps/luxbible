import 'package:bible/models/user/language.dart';
import 'package:lux/lux.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timezone/timezone.dart' as timezone;

extension DateTimeExtensions on DateTime {
  DateTime get nextDate => isUtc ? DateTime.utc(year, month, day + 1) : DateTime(year, month, day + 1);

  bool isOnSameLocalDateAs(DateTime other) {
    final local = toLocal();
    final otherLocal = other.toLocal();
    return local.year == otherLocal.year && local.month == otherLocal.month && local.day == otherLocal.day;
  }

  timezone.TZDateTime inLocation(timezone.Location location) => timezone.TZDateTime.from(this, location);

  String formatAgo() => timeago.format(this, locale: Language.device.code);
}

extension TZDateTimeExtensions on timezone.TZDateTime {
  timezone.TZDateTime get nextDate => timezone.TZDateTime(location, year, month, day + 1);

  timezone.TZDateTime withTime(Time time) => timezone.TZDateTime(location, year, month, day, time.hour, time.minute);
}
