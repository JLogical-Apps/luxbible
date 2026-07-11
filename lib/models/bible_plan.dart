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
    mcheyne =>
      'A classic plan with four short readings a day. You read through the Old Testament once and the New Testament and Psalms twice in a year.',
    one_year_chronological => 'Read the whole Bible in a year, arranged in the order the events actually happened.',
    esv_through_the_bible => 'Read straight through the whole Bible in a year, from Genesis to Revelation.',
    esv_gospels_and_epistles =>
      'Spend the year in the New Testament, journeying through the Gospels and the letters of the apostles.',
    esv_every_day_in_word =>
      'Four readings a day from the Old Testament, New Testament, Psalms, and Proverbs, covering the whole Bible in a year, with Psalms & Proverbs twice.',
    esv_literary_study_bible =>
      'Experience the Bible over a year grouped by its literary styles, moving through story, poetry, and letters.',
    esv_chronicles_and_prophets => 'A year that pairs the history in Chronicles with the messages of the Prophets.',
    esv_pentateuch_and_history_of_israel =>
      'Journey through the five books of Moses and the history of Israel over a year.',
    esv_psalms_and_wisdom_literature =>
      'Spend the year in the Psalms and wisdom books like Proverbs, Job, and Ecclesiastes.',
    heartlight_ot_and_nt =>
      'Read through both the Old and New Testaments together, with a passage from each every day.',
    heartlight_different_topics =>
      'Rotate through a different section of Scripture each day, exploring every book of the Bible over a year.',
    heartlight_nt_psalms_proverbs => 'Read the New Testament alongside Psalms and Proverbs over the course of a year.',
    navigators_5x5x5_nt =>
      'Read one New Testament chapter a day, five days a week, followed by two days to review and reflect.',
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

class BiblePlanSource {
  final String name;
  final String link;

  const BiblePlanSource({required this.name, required this.link});
}
