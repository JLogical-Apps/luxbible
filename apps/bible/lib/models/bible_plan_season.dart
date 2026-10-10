import 'package:lux/i18n.dart';
import 'package:lux/lux_core.dart';

enum BiblePlanSeason {
  advent;

  // The first Sunday of Advent is the fourth Sunday before Christmas, which always falls between Nov 27 and Dec 3.
  DateTime getStartDate(int year) {
    final earliestStart = DateTime(year, 11, 27);
    return earliestStart.addDays((DateTime.sunday - earliestStart.weekday) % 7);
  }

  DateTime getEndDate(int year) => DateTime(year, 12, 25);

  // Promoting it 2 weeks early lets readers start on the season's first day.
  DateTime getPromotionStartDate(int year) => getStartDate(year).addDays(-14);

  bool isPromotedOn(DateTime date) => date.isBetween(getPromotionStartDate(date.year), getEndDate(date.year));

  int getDaysUntilStart(DateTime date) => date.getDaysUntil(getStartDate(date.year));

  int getDaysUntilEnd(DateTime date) => date.getDaysUntil(getEndDate(date.year));

  // The season's last day while it's still ahead and being promoted, so a seasonal plan can be paced to finish on it.
  DateTime? getUpcomingEndDate(DateTime date) =>
      isPromotedOn(date) && getDaysUntilEnd(date) > 0 ? getEndDate(date.year) : null;

  // Once Christmas has passed, the next season starts the following year.
  String getScheduleLabel(DateTime date) => switch ((getDaysUntilStart(date), getDaysUntilEnd(date))) {
    (_, < 0) => t.biblePlans.startsOn(date: getStartDate(date.year + 1).formatMonthAndDay()),
    (> 0, _) => t.biblePlans.startsOn(date: getStartDate(date.year).formatMonthAndDay()),
    _ => t.biblePlans.endsOn(date: getEndDate(date.year).formatMonthAndDay()),
  };

  int getWeek(DateTime date) => (getStartDate(date.year).getDaysUntil(date) ~/ 7 + 1).clamp(1, 4);
}
