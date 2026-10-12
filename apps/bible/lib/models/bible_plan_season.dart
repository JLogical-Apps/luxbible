import 'package:lux/i18n.dart';
import 'package:lux/lux_core.dart';

enum BiblePlanSeason {
  advent;

  // The plan's 27 days fit only Advent 2026, since the season's length changes every year.
  DateTime get startDate => switch (this) {
    advent => DateTime(2026, 11, 29),
  };

  DateTime get endDate => switch (this) {
    advent => DateTime(2026, 12, 25),
  };

  // Promoting it 2 weeks early lets readers start on the season's first day.
  DateTime get promotionStartDate => startDate.addDays(-14);

  bool isPromotedOn(DateTime date) => date.isBetween(promotionStartDate, endDate);

  int getDaysUntilStart(DateTime date) => date.getDaysUntil(startDate);

  int getDaysUntilEnd(DateTime date) => date.getDaysUntil(endDate);

  // A plan started on or after its last day would begin behind, so it's only paced to end while that day is ahead.
  DateTime? getUpcomingEndDate(DateTime date) => getDaysUntilEnd(date) > 0 ? endDate : null;

  String? getScheduleLabel(DateTime date) => switch ((getDaysUntilStart(date), getDaysUntilEnd(date))) {
    (_, < 0) => null,
    (> 0, _) => t.biblePlans.startsOn(date: startDate.formatMonthAndDay()),
    _ => t.biblePlans.endsOn(date: endDate.formatMonthAndDay()),
  };

  int getWeek(DateTime date) => (startDate.getDaysUntil(date) ~/ 7 + 1).clamp(1, 4);
}
