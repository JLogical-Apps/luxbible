import 'package:bible/models/bible_plan.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'viewed_bible_plan_day_provider.g.dart';

@Riverpod(keepAlive: true)
class ViewedBiblePlanDay extends _$ViewedBiblePlanDay {
  @override
  BiblePlanDayId? build() => null;

  void view(BiblePlanDayId planDay) => state = planDay;

  void leave(BiblePlanDayId planDay) {
    if (state == planDay) state = null;
  }
}
