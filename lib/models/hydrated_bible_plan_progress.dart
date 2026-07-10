import 'package:bible/models/bible_plan.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:collection/collection.dart';

class HydratedBiblePlanProgress {
  final BiblePlanType type;
  final BiblePlan plan;
  final BiblePlanProgress progress;

  const HydratedBiblePlanProgress({required this.type, required this.plan, required this.progress});

  bool isPassageComplete({required int dayIndex, required VerseSelection passage}) =>
      progress.days[dayIndex].completedPassages.contains(passage);

  bool isDayComplete({required int dayIndex}) {
    final day = plan.days[dayIndex];
    return day.passages.isNotEmpty &&
        day.passages.every((passage) => isPassageComplete(dayIndex: dayIndex, passage: passage));
  }

  bool isDayPartial({required int dayIndex}) {
    final day = plan.days[dayIndex];
    final numCompleted = day.passages
        .where((passage) => isPassageComplete(dayIndex: dayIndex, passage: passage))
        .length;
    return numCompleted > 0 && numCompleted < day.passages.length;
  }

  int get currentDayIndex =>
      plan.dayIndexes.firstWhereOrNull((index) => !isDayComplete(dayIndex: index)) ?? (plan.days.length - 1);

  bool get isCompleted => plan.dayIndexes.every((index) => isDayComplete(dayIndex: index));
}
