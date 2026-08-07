import 'package:bible/models/bible_plan.dart';
import 'package:collection/collection.dart';
import 'package:lux/lux.dart';

class HydratedBiblePlanProgress {
  final BiblePlanType type;
  final BiblePlan plan;
  final BiblePlanProgress progress;

  const HydratedBiblePlanProgress({required this.type, required this.plan, required this.progress});

  bool isPassageComplete({required int dayIndex, required VerseSelection passage}) =>
      progress.days[dayIndex].isPassageComplete(passage);

  bool isDayComplete({required int dayIndex}) => progress.days[dayIndex].isComplete;

  int get currentDayIndex =>
      plan.dayIndexes.firstWhereOrNull((index) => !isDayComplete(dayIndex: index)) ?? (plan.days.length - 1);

  int get numCompletedDays => plan.dayIndexes.where((index) => isDayComplete(dayIndex: index)).length;

  bool get isCompleted => numCompletedDays == plan.dayCount;
}
