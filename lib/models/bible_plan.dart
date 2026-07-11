import 'package:bible/models/reference/verse_selection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bible_plan.freezed.dart';
part 'bible_plan.g.dart';

@freezed
sealed class BiblePlan with _$BiblePlan {
  const BiblePlan._();

  const factory BiblePlan({required String name, @Default('') String description, required List<BiblePlanDay> days}) =
      _BiblePlan;

  factory BiblePlan.fromJson(Map<String, dynamic> json) => _$BiblePlanFromJson(json);

  int get dayCount => days.length;

  List<int> get dayIndexes => List.generate(dayCount, (i) => i);
}

@freezed
sealed class BiblePlanDay with _$BiblePlanDay {
  const BiblePlanDay._();

  const factory BiblePlanDay({@Default([]) List<VerseSelection> passages}) = _BiblePlanDay;

  factory BiblePlanDay.fromJson(Map<String, dynamic> json) => _$BiblePlanDayFromJson(json);
}

@freezed
sealed class BiblePlanProgress with _$BiblePlanProgress {
  const BiblePlanProgress._();

  const factory BiblePlanProgress({required List<BiblePlanDayProgress> days}) = _BiblePlanProgress;

  factory BiblePlanProgress.fromJson(Map<String, dynamic> json) => _$BiblePlanProgressFromJson(json);
}

@freezed
sealed class BiblePlanDayProgress with _$BiblePlanDayProgress {
  const BiblePlanDayProgress._();

  const factory BiblePlanDayProgress({@Default({}) Set<VerseSelection> completedPassages}) = _BiblePlanDayProgress;

  factory BiblePlanDayProgress.fromJson(Map<String, dynamic> json) => _$BiblePlanDayProgressFromJson(json);
}

// ignore_for_file: constant_identifier_names
enum BiblePlanType {
  mcheyne,
  one_year_chronological,
  esv_through_the_bible,
  esv_gospels_and_epistles,
  esv_every_day_in_word,
  esv_literary_study_bible,
  esv_chronicles_and_prophets,
  esv_pentateuch_and_history_of_israel,
  esv_psalms_and_wisdom_literature,
  heartlight_ot_and_nt;

  String get assetPath => 'assets/bible_plans/$name.json';
}
