import 'package:bible/models/calendar_date_time.dart';
import 'package:bible/models/reminder.dart';
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

  const factory BiblePlan({
    required String name,
    required List<BiblePlanDay> days,
    @JsonKey(name: 'color', includeIfNull: false) BiblePlanColor? colorOverride,
  }) = _BiblePlan;

  factory BiblePlan.fromJson(Map<String, dynamic> json) => _$BiblePlanFromJson(json);

  static BiblePlan? tryFromJson(Object? json) {
    try {
      final plan = BiblePlan.fromJson(json as Map<String, dynamic>);
      return plan.isValid ? plan : null;
    } catch (_) {
      return null;
    }
  }

  bool get isValid =>
      name.trim().isNotEmpty &&
      days.isNotEmpty &&
      days.length <= 365 &&
      days.any((day) => day.passages.isNotEmpty) &&
      days.every(
        (day) =>
            day.passages.toSet().length == day.passages.length &&
            day.passages.every((passage) => passage.isNotEmpty && VerseSelection.isOsisId(passage.osisId())),
      );

  BiblePlanColor get color => colorOverride ?? BiblePlanColor.values[name.codeUnits.sum % BiblePlanColor.values.length];

  String getDisplayName(String id) => BiblePlanType.getById(id)?.title() ?? name;

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

  const factory BiblePlanProgress({
    required List<BiblePlanDayProgress> days,
    Reminder? reminder,
    CalendarDateTime? lastCompletedAt,
  }) = _BiblePlanProgress;

  factory BiblePlanProgress.fromJson(Map<String, dynamic> json) => _$BiblePlanProgressFromJson(json);

  bool get hasDailyReminder => reminder is DailyReminder;

  bool wasCompletedOnLocalDate(DateTime date) => lastCompletedAt?.isOnSameLocalDateAs(date) ?? false;
  bool wasCompletedToday() => wasCompletedOnLocalDate(.now());

  BiblePlanProgress withDayUpdated({
    required int dayIndex,
    required BiblePlanDayProgress Function(BiblePlanDayProgress) updater,
  }) {
    if (dayIndex < 0 || dayIndex >= days.length) return this;
    final previousDay = days[dayIndex];
    final updatedDay = updater(previousDay);
    return copyWith(
      days: days.withUpdateAt(dayIndex, (_) => updatedDay),
      lastCompletedAt: !previousDay.isComplete && updatedDay.isComplete ? .now() : lastCompletedAt,
    );
  }
}

@freezed
sealed class BiblePlanDayProgress with _$BiblePlanDayProgress {
  const BiblePlanDayProgress._();

  const factory BiblePlanDayProgress.incomplete({@Default({}) Set<VerseSelection> completedPassages}) =
      IncompleteBiblePlanDayProgress;

  const factory BiblePlanDayProgress.complete() = CompleteBiblePlanDayProgress;

  factory BiblePlanDayProgress.fromJson(Map<String, dynamic> json) => _$BiblePlanDayProgressFromJson(json);

  bool isPassageComplete(VerseSelection passage) => switch (this) {
    IncompleteBiblePlanDayProgress(:final completedPassages) => completedPassages.has(passage),
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
    return day.passages.every((passage) => completedPassages.has(passage))
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
  equipping_godly_women_through_the_bible,
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

  static BiblePlanType? getById(String id) => values.firstWhereOrNull((type) => type.name == id);

  String get assetPath => 'assets/bible_plans/$name.json';

  String title() => switch (this) {
    equipping_godly_women_through_the_bible => t.planTypes.throughTheBible,
    esv_through_the_bible => t.planTypes.oldAndNewTestament,
    one_year_chronological => t.planTypes.chronological,
    heartlight_ot_and_nt => t.planTypes.historicallyBlended,
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

  String description() => switch (this) {
    equipping_godly_women_through_the_bible => t.planTypes.throughTheBibleDescription,
    mcheyne => t.planTypes.mcheyneDescription,
    one_year_chronological => t.planTypes.chronologicalDescription,
    esv_through_the_bible => t.planTypes.oldAndNewTestamentDescription,
    esv_gospels_and_epistles => t.planTypes.gospelsAndEpistlesDescription,
    esv_every_day_in_word => t.planTypes.everyDayInTheWordDescription,
    esv_literary_study_bible => t.planTypes.literaryStudyDescription,
    esv_chronicles_and_prophets => t.planTypes.chroniclesAndProphetsDescription,
    esv_pentateuch_and_history_of_israel => t.planTypes.pentateuchAndHistoryDescription,
    esv_psalms_and_wisdom_literature => t.planTypes.psalmsAndWisdomDescription,
    heartlight_ot_and_nt => t.planTypes.historicallyBlendedDescription,
    heartlight_different_topics => t.planTypes.differentTopicsDescription,
    heartlight_nt_psalms_proverbs => t.planTypes.newTestamentPsalmsProverbsDescription,
    navigators_5x5x5_nt => t.planTypes.fiveByFiveByFiveDescription,
  };

  BiblePlanSource? get source => switch (this) {
    equipping_godly_women_through_the_bible => BiblePlanSource(
      name: 'Equipping Godly Women',
      link: 'https://equippinggodlywomen.com/faith/read-the-bible-in-a-year/',
    ),
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
  wholeBible,
  mixed;

  String title() => switch (this) {
    oldTestament => t.testaments.old,
    newTestament => t.testaments.newTestament,
    wholeBible => t.testaments.wholeBible,
    mixed => t.biblePlans.mixed,
  };

  String description() => switch (this) {
    oldTestament => t.planTypes.oldScopeDescription,
    newTestament => t.planTypes.newScopeDescription,
    wholeBible => t.planTypes.wholeScopeDescription,
    mixed => t.biblePlans.mixedScopeDescription,
  };
}

extension BiblePlanScopeExtension on BiblePlan {
  BiblePlanScope get scope {
    final books = days
        .expand((day) => day.passages)
        .expand((passage) => passage.spans)
        .map((span) => span.start.startReference.book)
        .distinct;
    if (books.containsAll(BookType.values)) return .wholeBible;
    if (books.every((book) => book.testament == .oldTestament)) return .oldTestament;
    if (books.every((book) => book.testament == .newTestament)) return .newTestament;
    return .mixed;
  }
}

class BiblePlanSource {
  final String name;
  final String link;

  const BiblePlanSource({required this.name, required this.link});
}

enum BiblePlanColor { red, orange, yellow, green, blue, violet }

extension BiblePlanDraftDaysExtension on List<BiblePlanDay> {
  List<BiblePlanDay> withPassageAdded(int dayIndex, VerseSelection passage) {
    final day = this[dayIndex];
    return day.passages.contains(passage)
        ? this
        : withUpdateAt(dayIndex, (day) => day.copyWith(passages: [...day.passages, passage]));
  }

  List<BiblePlanDay> withPassageRemoved(int dayIndex, VerseSelection passage) =>
      withUpdateAt(dayIndex, (day) => day.copyWith(passages: day.passages.withRemoved(passage)));

  List<BiblePlanDay> withPassageReordered(int dayIndex, int oldIndex, int newIndex) =>
      withUpdateAt(dayIndex, (day) => day.copyWith(passages: day.passages.withReorder(oldIndex, newIndex)));

  List<BiblePlanDay> withPassageMoved({
    required int sourceDayIndex,
    required int destinationDayIndex,
    required VerseSelection passage,
  }) => withPassageRemoved(sourceDayIndex, passage).withUpdateAt(
    destinationDayIndex,
    (day) =>
        this[destinationDayIndex].passages.contains(passage) ? day : day.copyWith(passages: [...day.passages, passage]),
  );
}
