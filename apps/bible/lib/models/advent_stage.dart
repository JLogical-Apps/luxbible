import 'dart:math';

import 'package:bible/models/bible_plan_season.dart';

class AdventStage {
  static const candleCount = 4;

  // 0 is the night before the first reading and 1 is the Christmas sunrise.
  final double progress;
  final double litCandles;
  final bool isComplete;

  const AdventStage({required this.progress, required this.litCandles, required this.isComplete});

  // A candle is lit on the first reading of each week: days 1, 8, 15, and 22.
  AdventStage.fromCompletedDays(int completedDays, {required int dayCount})
    : progress = completedDays / dayCount,
      litCandles = min(candleCount, (completedDays / 7).ceil()).toDouble(),
      isComplete = completedDays >= dayCount;

  // Follows the calendar's candles but keeps the scene at night, so promotion doesn't reveal the sunrise early.
  AdventStage.fromDate(DateTime date)
    : progress = BiblePlanSeason.advent.getDaysUntilEnd(date) == 0 ? 1 : 0,
      litCandles = BiblePlanSeason.advent.getDaysUntilStart(date) > 0
          ? 0
          : BiblePlanSeason.advent.getWeek(date).toDouble(),
      isComplete = BiblePlanSeason.advent.getDaysUntilEnd(date) == 0;
}
