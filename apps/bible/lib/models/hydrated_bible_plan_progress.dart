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

  List<BiblePlanDayItem> getDayItems(int dayIndex) => progress.getDayItems(plan.days[dayIndex]);

  bool isReviewAndReflect(int dayIndex) => progress.isReviewAndReflect(plan.days[dayIndex]);

  bool isItemComplete({required int dayIndex, required BiblePlanDayItem item}) =>
      progress.getDayProgress(dayIndex).isItemComplete(item);

  bool isDayComplete({required int dayIndex}) => progress.getDayProgress(dayIndex).isComplete;

  int getFirstIncompleteItemIndex(int dayIndex) =>
      getDayItems(dayIndex).indexWhereOrNull((item) => !isItemComplete(dayIndex: dayIndex, item: item)) ?? 0;

  int get currentDayIndex =>
      plan.dayIndexes.firstWhereOrNull((index) => !isDayComplete(dayIndex: index)) ?? (plan.days.length - 1);

  int? get lastCompletedDayIndex => plan.dayIndexes.lastWhereOrNull((index) => isDayComplete(dayIndex: index));

  int get numCompletedDays => plan.dayIndexes.where((index) => isDayComplete(dayIndex: index)).length;

  bool get isCompleted => numCompletedDays == plan.dayCount;

  bool isCompletedThrough(int dayIndex) =>
      plan.dayIndexes.take(dayIndex + 1).every((index) => isDayComplete(dayIndex: index)) &&
      !hasProgressAfter(dayIndex);

  bool hasProgressAfter(int dayIndex) =>
      plan.dayIndexes.skip(dayIndex + 1).any((index) => progress.days.elementAtOrNull(index)?.hasProgress ?? false);

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
