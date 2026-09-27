import 'package:bible/models/bible_plan.dart';
import 'package:collection/collection.dart';
import 'package:lux/lux.dart';

class HydratedBiblePlanProgress {
  final String id;
  final BiblePlan plan;
  final BiblePlanProgress progress;

  const HydratedBiblePlanProgress({required this.id, required this.plan, required this.progress});

  // Progress started before instance IDs existed falls back to the plan ID so its annotations stay linked.
  String get instanceId => progress.instanceId ?? id;

  BiblePlanDayId getDayId(int dayIndex) => BiblePlanDayId(instanceId: instanceId, dayIndex: dayIndex);

  bool isPassageComplete({required int dayIndex, required VerseSelection passage}) =>
      (progress.days.elementAtOrNull(dayIndex) ?? BiblePlanDayProgress.incomplete()).isPassageComplete(passage);

  bool isDayComplete({required int dayIndex}) =>
      (progress.days.elementAtOrNull(dayIndex) ?? BiblePlanDayProgress.incomplete()).isComplete;

  int get currentDayIndex =>
      plan.dayIndexes.firstWhereOrNull((index) => !isDayComplete(dayIndex: index)) ?? (plan.days.length - 1);

  BiblePlanDay get currentDay => plan.days[currentDayIndex];

  int? get lastCompletedDayIndex => plan.dayIndexes.lastWhereOrNull((index) => isDayComplete(dayIndex: index));

  int get numCompletedDays => plan.dayIndexes.where((index) => isDayComplete(dayIndex: index)).length;

  bool get isCompleted => numCompletedDays == plan.dayCount;

  DateTime get naturalEndDate => BiblePlanPace.getNaturalEndDate(
    dayCount: plan.dayCount,
    completedDayCount: numCompletedDays,
    hasCompletedToday: progress.wasCompletedToday(),
  );

  // How many days sooner than the target the reader would finish at one plan day per day, so negative means behind.
  int? get daysAheadOfPace => switch (progress.pace) {
    PacedBiblePlanPace(:final endDate) when !isCompleted => naturalEndDate.getDaysUntil(endDate),
    _ => null,
  };
}
