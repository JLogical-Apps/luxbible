import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:utils_core/utils_core.dart';

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

  int? nextIncompletePassageIndex({required List<VerseSelection> passages, required int currentIndex}) => passages
      .asMap()
      .where((index, passage) => index != currentIndex && !completedPassages.contains(passage))
      .sortedBy((index, passage) => index - currentIndex)
      .keys
      .firstOrNull;
}

// ignore_for_file: constant_identifier_names
enum BiblePlanType {
  esv_through_the_bible,
  one_year_chronological,
  heartlight_ot_and_nt,
  esv_every_day_in_word,
  mcheyne,
  esv_literary_study_bible,
  esv_gospels_and_epistles,
  esv_pentateuch_and_history_of_israel,
  esv_chronicles_and_prophets,
  esv_psalms_and_wisdom_literature;

  String get assetPath => 'assets/bible_plans/$name.json';

  BiblePlanScope get scope => switch (this) {
    mcheyne ||
    one_year_chronological ||
    esv_through_the_bible ||
    esv_every_day_in_word ||
    esv_literary_study_bible ||
    heartlight_ot_and_nt => .wholeBible,
    esv_gospels_and_epistles => .newTestament,
    esv_chronicles_and_prophets ||
    esv_pentateuch_and_history_of_israel ||
    esv_psalms_and_wisdom_literature => .oldTestament,
  };

  BiblePlanSearchType get searchType => switch (this) {
    esv_chronicles_and_prophets || esv_pentateuch_and_history_of_israel || esv_psalms_and_wisdom_literature => .focused,
    mcheyne ||
    one_year_chronological ||
    esv_through_the_bible ||
    esv_gospels_and_epistles ||
    esv_every_day_in_word ||
    esv_literary_study_bible ||
    heartlight_ot_and_nt => .comprehensive,
  };
}

enum BiblePlanScope {
  oldTestament,
  newTestament,
  wholeBible;

  String title() => switch (this) {
    oldTestament => 'Old Testament',
    newTestament => 'New Testament',
    wholeBible => 'Whole Bible',
  };

  String description() => switch (this) {
    oldTestament => 'Reads from books in the Old Testament.',
    newTestament => 'Reads from books in the New Testament.',
    wholeBible => 'Reads from both the Old and New Testaments.',
  };
}

enum BiblePlanSearchType {
  focused,
  comprehensive;

  String title() => switch (this) {
    focused => 'Focused',
    comprehensive => 'Comprehensive',
  };

  String description() => switch (this) {
    focused => 'Covers a specific section or collection within its scope.',
    comprehensive => 'Covers every book within its scope.',
  };
}
