import 'package:lux/lux_core.dart';

enum BiblePlanSeason {
  advent;

  // The first Sunday of Advent is the fourth Sunday before Christmas, which always falls between Nov 27 and Dec 3.
  DateTime getStartDate(int year) {
    final earliestStart = DateTime(year, 11, 27);
    return earliestStart.addDays((DateTime.sunday - earliestStart.weekday) % 7);
  }

  DateTime getEndDate(int year) => DateTime(year, 12, 25);

  // Promoting it 3 days early lets readers start on the season's first day.
  DateTime getPromotionStartDate(int year) => getStartDate(year).addDays(-3);

  bool isPromotedOn(DateTime date) => date.isBetween(getPromotionStartDate(date.year), getEndDate(date.year));

  int getDaysUntilStart(DateTime date) => date.getDaysUntil(getStartDate(date.year));

  int getDaysUntilEnd(DateTime date) => date.getDaysUntil(getEndDate(date.year));

  // The season's last day while it's still ahead and being promoted, so a seasonal plan can be paced to finish on it.
  DateTime? getUpcomingEndDate(DateTime date) =>
      isPromotedOn(date) && getDaysUntilEnd(date) > 0 ? getEndDate(date.year) : null;

  int getWeek(DateTime date) => (getStartDate(date.year).getDaysUntil(date) ~/ 7 + 1).clamp(1, 4);
}
