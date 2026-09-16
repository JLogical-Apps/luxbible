import 'package:bible/models/bible_plan.dart';
import 'package:collection/collection.dart';
import 'package:lux/lux.dart';

class HydratedBiblePlanProgress {
  final String id;
  final BiblePlan plan;
  final BiblePlanProgress progress;

  const HydratedBiblePlanProgress({required this.id, required this.plan, required this.progress});

  bool isPassageComplete({required int dayIndex, required VerseSelection passage}) =>
      (progress.days.elementAtOrNull(dayIndex) ?? BiblePlanDayProgress.incomplete()).isPassageComplete(passage);

  bool isDayComplete({required int dayIndex}) =>
      (progress.days.elementAtOrNull(dayIndex) ?? BiblePlanDayProgress.incomplete()).isComplete;

  int get currentDayIndex =>
      plan.dayIndexes.firstWhereOrNull((index) => !isDayComplete(dayIndex: index)) ?? (plan.days.length - 1);

  BiblePlanDay get currentDay => plan.days[currentDayIndex];

  int get numCompletedDays => plan.dayIndexes.where((index) => isDayComplete(dayIndex: index)).length;

  bool get isCompleted => numCompletedDays == plan.dayCount;
}
