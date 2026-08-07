import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:utils_core/utils_core.dart';

part 'bible_plan.freezed.dart';
part 'bible_plan.g.dart';

@freezed
sealed class BiblePlan with _$BiblePlan {
  const BiblePlan._();

  const factory BiblePlan({required String name, required List<BiblePlanDay> days}) = _BiblePlan;

  factory BiblePlan.fromJson(Map<String, dynamic> json) => _$BiblePlanFromJson(json);

  int get dayCount => days.length;

  List<int> get dayIndexes => List.generate(dayCount, (i) => i);
}

@freezed
sealed class BiblePlanDay with _$BiblePlanDay {
  const BiblePlanDay._();

  const factory BiblePlanDay({@Default([]) List<VerseSelection> passages}) = _BiblePlanDay;

  factory BiblePlanDay.fromJson(Map<String, dynamic> json) => _$BiblePlanDayFromJson(json);

  bool get isReviewAndReflect => passages.isEmpty;
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

  const factory BiblePlanDayProgress.incomplete({@Default({}) Set<VerseSelection> completedPassages}) =
      IncompleteBiblePlanDayProgress;

  const factory BiblePlanDayProgress.complete() = CompleteBiblePlanDayProgress;

  factory BiblePlanDayProgress.fromJson(Map<String, dynamic> json) => _$BiblePlanDayProgressFromJson(json);

  bool isPassageComplete(VerseSelection passage) => switch (this) {
    IncompleteBiblePlanDayProgress(:final completedPassages) => completedPassages.contains(passage),
    CompleteBiblePlanDayProgress() => true,
  };

  bool get isComplete => this is CompleteBiblePlanDayProgress;

  BiblePlanDayProgress withCompletionToggled() =>
      isComplete ? BiblePlanDayProgress.incomplete() : BiblePlanDayProgress.complete();

  int? getNextIncompletePassageIndex({required List<VerseSelection> passages, required int currentIndex}) => passages
      .asMap()
      .where((index, passage) => index != currentIndex && !isPassageComplete(passage))
      .sortedBy((index, passage) => index - currentIndex)
      .keys
      .firstOrNull;

  BiblePlanDayProgress withPassageCompleted({required BiblePlanDay day, required VerseSelection passage}) {
    final completedPassages = switch (this) {
      IncompleteBiblePlanDayProgress(:final completedPassages) => {...completedPassages, passage},
      CompleteBiblePlanDayProgress() => day.passages.toSet(),
    };
    return day.passages.every((passage) => completedPassages.contains(passage))
        ? BiblePlanDayProgress.complete()
        : BiblePlanDayProgress.incomplete(completedPassages: completedPassages);
  }

  BiblePlanDayProgress withPassageUncompleted({required BiblePlanDay day, required VerseSelection passage}) =>
      BiblePlanDayProgress.incomplete(
        completedPassages: {
          ...switch (this) {
            IncompleteBiblePlanDayProgress(:final completedPassages) => completedPassages,
            CompleteBiblePlanDayProgress() => day.passages.toSet(),
          },
        }..remove(passage),
      );
}

// ignore_for_file: constant_identifier_names
enum BiblePlanType {
  esv_through_the_bible,
  one_year_chronological,
  heartlight_ot_and_nt,
  esv_every_day_in_word,
  mcheyne,
  esv_literary_study_bible,
  heartlight_different_topics,
  heartlight_nt_psalms_proverbs,
  navigators_5x5x5_nt,
  esv_gospels_and_epistles,
  esv_pentateuch_and_history_of_israel,
  esv_chronicles_and_prophets,
  esv_psalms_and_wisdom_literature;

  String get assetPath => 'assets/bible_plans/$name.json';

  String title() => switch (this) {
    esv_through_the_bible => t.planTypes.throughTheBible,
    one_year_chronological => t.planTypes.chronological,
    heartlight_ot_and_nt => t.planTypes.oldAndNewTestament,
    esv_every_day_in_word => t.planTypes.everyDayInTheWord,
    mcheyne => t.planTypes.mcheyne,
    esv_literary_study_bible => t.planTypes.literaryStudy,
    heartlight_different_topics => t.planTypes.differentTopics,
    heartlight_nt_psalms_proverbs => t.planTypes.newTestamentPsalmsProverbs,
    navigators_5x5x5_nt => t.planTypes.fiveByFiveByFive,
    esv_gospels_and_epistles => t.planTypes.gospelsAndEpistles,
    esv_pentateuch_and_history_of_israel => t.planTypes.pentateuchAndHistory,
    esv_chronicles_and_prophets => t.planTypes.chroniclesAndProphets,
    esv_psalms_and_wisdom_literature => t.planTypes.psalmsAndWisdom,
  };

  BiblePlanScope get scope => switch (this) {
    mcheyne ||
    one_year_chronological ||
    esv_through_the_bible ||
    esv_every_day_in_word ||
    esv_literary_study_bible ||
    heartlight_ot_and_nt => .wholeBible,
    heartlight_different_topics || heartlight_nt_psalms_proverbs => .wholeBible,
    esv_gospels_and_epistles || navigators_5x5x5_nt => .newTestament,
    esv_chronicles_and_prophets ||
    esv_pentateuch_and_history_of_israel ||
    esv_psalms_and_wisdom_literature => .oldTestament,
  };

  BiblePlanSearchType get searchType => switch (this) {
    esv_chronicles_and_prophets ||
    esv_pentateuch_and_history_of_israel ||
    esv_psalms_and_wisdom_literature ||
    heartlight_nt_psalms_proverbs => .focused,
    mcheyne ||
    one_year_chronological ||
    esv_through_the_bible ||
    esv_gospels_and_epistles ||
    esv_every_day_in_word ||
    esv_literary_study_bible ||
    heartlight_ot_and_nt ||
    heartlight_different_topics ||
    navigators_5x5x5_nt => .comprehensive,
  };

  String description() => switch (this) {
    mcheyne => t.planTypes.mcheyneDescription,
    one_year_chronological => t.planTypes.chronologicalDescription,
    esv_through_the_bible => t.planTypes.throughTheBibleDescription,
    esv_gospels_and_epistles => t.planTypes.gospelsAndEpistlesDescription,
    esv_every_day_in_word => t.planTypes.everyDayInTheWordDescription,
    esv_literary_study_bible => t.planTypes.literaryStudyDescription,
    esv_chronicles_and_prophets => t.planTypes.chroniclesAndProphetsDescription,
    esv_pentateuch_and_history_of_israel => t.planTypes.pentateuchAndHistoryDescription,
    esv_psalms_and_wisdom_literature => t.planTypes.psalmsAndWisdomDescription,
    heartlight_ot_and_nt => t.planTypes.oldAndNewTestamentDescription,
    heartlight_different_topics => t.planTypes.differentTopicsDescription,
    heartlight_nt_psalms_proverbs => t.planTypes.newTestamentPsalmsProverbsDescription,
    navigators_5x5x5_nt => t.planTypes.fiveByFiveByFiveDescription,
  };

  BiblePlanSource? get source => switch (this) {
    mcheyne => null,
    one_year_chronological => BiblePlanSource(name: 'Tyndale', link: 'https://www.oneyearbibleonline.com'),
    esv_through_the_bible ||
    esv_every_day_in_word ||
    esv_literary_study_bible ||
    esv_gospels_and_epistles ||
    esv_pentateuch_and_history_of_israel ||
    esv_chronicles_and_prophets ||
    esv_psalms_and_wisdom_literature => BiblePlanSource(
      name: 'Crossway',
      link: 'https://www.esv.org/learn-more/reading-plans/',
    ),
    heartlight_ot_and_nt => BiblePlanSource(
      name: 'Heartlight',
      link: 'https://www.heartlight.org/devotionals/reading_plans/otandnt/',
    ),
    heartlight_different_topics => BiblePlanSource(
      name: 'Heartlight',
      link: 'https://www.heartlight.org/devotionals/reading_plans/topics/',
    ),
    heartlight_nt_psalms_proverbs => BiblePlanSource(
      name: 'Heartlight',
      link: 'https://www.heartlight.org/devotionals/reading_plans/ntpp/',
    ),
    navigators_5x5x5_nt => BiblePlanSource(
      name: 'The Navigators',
      link: 'https://www.navigators.org/resource/bible-reading-plans/',
    ),
  };
}

enum BiblePlanScope {
  oldTestament,
  newTestament,
  wholeBible;

  String title() => switch (this) {
    oldTestament => t.testaments.old,
    newTestament => t.testaments.newTestament,
    wholeBible => t.testaments.wholeBible,
  };

  String description() => switch (this) {
    oldTestament => t.planTypes.oldScopeDescription,
    newTestament => t.planTypes.newScopeDescription,
    wholeBible => t.planTypes.wholeScopeDescription,
  };
}

enum BiblePlanSearchType {
  focused,
  comprehensive;

  String title() => switch (this) {
    focused => t.planTypes.focused,
    comprehensive => t.planTypes.comprehensive,
  };

  String description() => switch (this) {
    focused => t.planTypes.focusedDescription,
    comprehensive => t.planTypes.comprehensiveDescription,
  };
}

class BiblePlanSource {
  final String name;
  final String link;

  const BiblePlanSource({required this.name, required this.link});
}
