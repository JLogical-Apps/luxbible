import 'dart:math';

import 'package:bible/models/bible_plan_season.dart';
import 'package:bible/models/rich_content.dart';
import 'package:bible/models/calendar_date_time.dart';
import 'package:bible/models/hydrated_bible_plan_progress.dart';
import 'package:bible/models/reminder.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:utils_core/utils_core.dart';
import 'package:uuid/uuid.dart';

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

  BiblePlanValidationError? get validationError {
    if (name.trim().isEmpty) return .nameRequired;
    if (days.isEmpty || days.length > 365) return .invalidDayCount;
    if (!days.any((day) => day.passages.isNotEmpty)) return .readingRequired;
    if (days.any((day) => day.passages.toSet().length != day.passages.length)) return .duplicatePassage;
    if (days.any(
      (day) =>
          day.passages.any((passage) => passage.verseSelection.isEmpty || !VerseSelection.isOsisId(passage.toJson())),
    )) {
      return .invalidPassage;
    }
    return null;
  }

  bool get isValid => validationError == null;

  BiblePlanColor get color => colorOverride ?? BiblePlanColor.values[name.codeUnits.sum % BiblePlanColor.values.length];

  String getDisplayName(String id) => BiblePlanType.getById(id)?.title() ?? name;

  int get dayCount => days.length;

  List<int> get dayIndexes => List.generate(dayCount, (i) => i);

  bool get hasReflectionQuestions => days.any((day) => day.reflectionQuestion != null);
}

@freezed
sealed class BiblePlanDay with _$BiblePlanDay {
  const BiblePlanDay._();

  const factory BiblePlanDay({
    @nonBlankString String? title,
    @JsonKey(fromJson: ChapterPassage.listFromJson) @Default([]) List<ChapterPassage> passages,
    @nonBlankString String? studyNotes,
    @nonBlankString String? reflectionQuestion,
  }) = _BiblePlanDay;

  factory BiblePlanDay.fromJson(Map<String, dynamic> json) => _$BiblePlanDayFromJson(json);

  bool get isReviewAndReflect => getItems(includesReflection: true).isEmpty;

  List<RichContent> get studyNotesContent => RichContent.listFromMarkdown(studyNotes ?? '');

  List<BiblePlanDayStep> get steps => getItems(includesReflection: true).whereType<BiblePlanDayStep>().toList();

  String getSummary() => switch ((passages, steps)) {
    ([], []) => t.biblePlans.reviewAndReflect,
    ([], final steps) => steps.map((step) => step.title()).join(' • '),
    (final passages, _) => passages.map((passage) => passage.format()).join(' • '),
  };

  BiblePlanDay withStepRemoved(BiblePlanDayStep step) => switch (step) {
    .studyNotes => copyWith(studyNotes: null),
    .reflection => copyWith(reflectionQuestion: null),
  };

  List<BiblePlanDayItem> getItems({required bool includesReflection}) => [
    ...passages.map(BiblePlanPassageItem.new),
    if (studyNotes != null) BiblePlanDayStep.studyNotes,
    if (includesReflection && reflectionQuestion != null) BiblePlanDayStep.reflection,
  ];
}

sealed class BiblePlanDayItem {
  String title();
}

final class BiblePlanPassageItem extends Equatable implements BiblePlanDayItem {
  final ChapterPassage passage;

  const BiblePlanPassageItem(this.passage);

  @override
  List<Object?> get props => [passage];

  @override
  String title() => passage.format();
}

enum BiblePlanDayStep implements BiblePlanDayItem {
  studyNotes,
  reflection;

  @override
  String title() => switch (this) {
    studyNotes => t.biblePlans.studyNotes,
    reflection => t.biblePlans.reflectionQuestion,
  };

  IconData get icon => switch (this) {
    studyNotes => Symbols.auto_stories,
    reflection => Symbols.edit_note,
  };

  String get completedJsonKey => switch (this) {
    studyNotes => 'completedStudyNotes',
    reflection => 'completedReflectionQuestion',
  };
}

@freezed
sealed class BiblePlanProgress with _$BiblePlanProgress {
  const BiblePlanProgress._();

  const factory BiblePlanProgress({
    String? instanceId,
    required List<BiblePlanDayProgress> days,
    Reminder? reminder,
    CalendarDateTime? lastCompletedAt,
    @Default(BiblePlanPace.relaxed()) BiblePlanPace pace,
    @Default(false) bool isSkippingReflections,
    @Default(false) bool hasOfferedToSkipReflections,
    @Default({}) Map<int, String> reflectionAnswerByDayIndex,
  }) = _BiblePlanProgress;

  factory BiblePlanProgress.start(BiblePlan plan, {required BiblePlanPace pace, List<BiblePlanDayProgress>? days}) =>
      BiblePlanProgress(
        instanceId: Uuid().v4(),
        days: days ?? plan.days.map((day) => BiblePlanDayProgress.incomplete()).toList(),
        pace: pace,
      );

  factory BiblePlanProgress.fromJson(Map<String, dynamic> json) => _$BiblePlanProgressFromJson(json);

  bool get hasDailyReminder => reminder is DailyReminder;

  List<BiblePlanDayItem> getDayItems(BiblePlanDay day) => day.getItems(includesReflection: !isSkippingReflections);

  // A day with only a reflection question becomes Review & Reflect while reflections are skipped.
  bool isReviewAndReflect(BiblePlanDay day) => getDayItems(day).isEmpty;

  BiblePlanDayProgress getDayProgress(int dayIndex) =>
      days.elementAtOrNull(dayIndex) ?? BiblePlanDayProgress.incomplete();

  String? getReflectionAnswer(int dayIndex) => reflectionAnswerByDayIndex[dayIndex];

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

  // Leaves lastCompletedAt alone so marking days in bulk doesn't count as reading or as a new completion.
  BiblePlanProgress withCompletedThrough(BiblePlan plan, {required int dayIndex}) => copyWith(
    days: plan.dayIndexes
        .map((index) => index <= dayIndex ? BiblePlanDayProgress.complete() : BiblePlanDayProgress.incomplete())
        .toList(),
  );

  // Like completing in bulk, days this completes leave lastCompletedAt alone.
  BiblePlanProgress withReflectionsSkipped(BiblePlan plan, {required bool isSkipped}) {
    final progress = copyWith(isSkippingReflections: isSkipped);
    return progress.copyWith(
      days: plan.days
          .mapIndexed(
            (dayIndex, day) => progress
                .getDayProgress(dayIndex)
                .withItemsCompleted(items: progress.getDayItems(day), completedItems: []),
          )
          .toList(),
    );
  }

  BiblePlanProgress withReflectionAnswer({required int dayIndex, required String answer}) => copyWith(
    reflectionAnswerByDayIndex: answer.trim().isEmpty
        ? ({...reflectionAnswerByDayIndex}..remove(dayIndex))
        : {...reflectionAnswerByDayIndex, dayIndex: answer},
  );

  // A different instance means a run was swapped in, so its already-completed days aren't new completions.
  bool hasCompletedDaySince(BiblePlanProgress? previous) =>
      previous != null && previous.instanceId == instanceId && lastCompletedAt != previous.lastCompletedAt;
}

enum BiblePlanPaceType {
  relaxed,
  paced;

  String title() => switch (this) {
    relaxed => t.biblePlans.relaxed,
    paced => t.biblePlans.paced,
  };

  String description() => switch (this) {
    relaxed => t.biblePlans.relaxedDescription,
    paced => t.biblePlans.pacedDescription,
  };

  IconData get icon => switch (this) {
    relaxed => Symbols.directions_walk,
    paced => Symbols.sports_score,
  };
}

@freezed
sealed class BiblePlanPace with _$BiblePlanPace {
  const BiblePlanPace._();

  const factory BiblePlanPace.relaxed() = RelaxedBiblePlanPace;

  const factory BiblePlanPace.paced({@isoDate required DateTime endDate}) = PacedBiblePlanPace;

  factory BiblePlanPace.fromType(BiblePlanPaceType type, {required DateTime endDate}) => switch (type) {
    .relaxed => BiblePlanPace.relaxed(),
    .paced => BiblePlanPace.paced(endDate: endDate),
  };

  factory BiblePlanPace.initial({DateTime? targetDate}) => switch (targetDate) {
    final endDate? => BiblePlanPace.paced(endDate: endDate),
    null => BiblePlanPace.relaxed(),
  };

  factory BiblePlanPace.fromJson(Map<String, dynamic> json) => _$BiblePlanPaceFromJson(json);

  // A day already completed today counts as today's reading, so the remaining days start tomorrow.
  static DateTime getNaturalEndDate({
    required int dayCount,
    int completedDayCount = 0,
    bool hasCompletedToday = false,
  }) => DateTime.now().withoutTime().addDays(max(dayCount - completedDayCount, 1) - (hasCompletedToday ? 0 : 1));

  BiblePlanPaceType get type => switch (this) {
    RelaxedBiblePlanPace() => .relaxed,
    PacedBiblePlanPace() => .paced,
  };

  DateTime? get endDate => as<PacedBiblePlanPace>()?.endDate;

  String format() => switch (this) {
    RelaxedBiblePlanPace() => t.biblePlans.relaxed,
    PacedBiblePlanPace(:final endDate) => t.biblePlans.pacedToEnd(date: endDate.formatDate()),
  };
}

@freezed
sealed class BiblePlanHistoryEntry with _$BiblePlanHistoryEntry {
  const BiblePlanHistoryEntry._();

  const factory BiblePlanHistoryEntry({
    required String planId,
    required BiblePlanProgress progress,
    required CalendarDateTime endedAt,
  }) = _BiblePlanHistoryEntry;

  factory BiblePlanHistoryEntry.fromJson(Map<String, dynamic> json) => _$BiblePlanHistoryEntryFromJson(json);

  HydratedBiblePlanProgress hydrate(BiblePlan plan) =>
      HydratedBiblePlanProgress(id: planId, plan: plan, progress: progress);
}

@freezed
sealed class BiblePlanDayId with _$BiblePlanDayId {
  const factory BiblePlanDayId({required String instanceId, required int dayIndex}) = _BiblePlanDayId;

  factory BiblePlanDayId.fromJson(Map<String, dynamic> json) => _$BiblePlanDayIdFromJson(json);
}

@freezed
sealed class BiblePlanDayProgress with _$BiblePlanDayProgress {
  const BiblePlanDayProgress._();

  const factory BiblePlanDayProgress.incomplete({
    @JsonKey(fromJson: ChapterPassage.setFromJson) @Default({}) Set<ChapterPassage> completedPassages,
    @Default({}) Set<BiblePlanDayStep> completedSteps,
  }) = IncompleteBiblePlanDayProgress;

  const factory BiblePlanDayProgress.complete() = CompleteBiblePlanDayProgress;

  factory BiblePlanDayProgress.fromJson(Map<String, dynamic> json) => _$BiblePlanDayProgressFromJson(json);

  // A Review & Reflect day has no items, so it's only completed explicitly rather than by completing none.
  factory BiblePlanDayProgress.fromCompletedItems({
    required List<BiblePlanDayItem> items,
    required Set<BiblePlanDayItem> completedItems,
  }) => items.isNotEmpty && items.every(completedItems.has)
      ? BiblePlanDayProgress.complete()
      : BiblePlanDayProgress.incomplete(
          completedPassages: completedItems.whereType<BiblePlanPassageItem>().map((item) => item.passage).toSet(),
          completedSteps: completedItems.whereType<BiblePlanDayStep>().toSet(),
        );

  bool isItemComplete(BiblePlanDayItem item) => switch (this) {
    IncompleteBiblePlanDayProgress(:final completedPassages, :final completedSteps) => switch (item) {
      BiblePlanPassageItem(:final passage) => completedPassages.has(passage),
      BiblePlanDayStep() => completedSteps.has(item),
    },
    CompleteBiblePlanDayProgress() => true,
  };

  bool get isComplete => this is CompleteBiblePlanDayProgress;

  bool get hasProgress => switch (this) {
    IncompleteBiblePlanDayProgress(:final completedPassages, :final completedSteps) =>
      completedPassages.isNotEmpty || completedSteps.isNotEmpty,
    CompleteBiblePlanDayProgress() => true,
  };

  // A complete day stores no detail, so it stands for every item the day has.
  Set<BiblePlanDayItem> getCompletedItems(List<BiblePlanDayItem> items) => switch (this) {
    IncompleteBiblePlanDayProgress(:final completedPassages, :final completedSteps) => {
      ...completedPassages.map(BiblePlanPassageItem.new),
      ...completedSteps,
    },
    CompleteBiblePlanDayProgress() => items.toSet(),
  };

  BiblePlanDayProgress withCompletionToggled() =>
      isComplete ? BiblePlanDayProgress.incomplete() : BiblePlanDayProgress.complete();

  int? getNextIncompleteItemIndex({required List<BiblePlanDayItem> items, required int currentIndex}) => items
      .asMap()
      .where((index, item) => index != currentIndex && !isItemComplete(item))
      .sortedBy((index, item) => index - currentIndex)
      .keys
      .firstOrNull;

  // A Review & Reflect day has nothing to complete, so it keeps its explicit completion, such as when reflections are skipped.
  BiblePlanDayProgress withItemsCompleted({
    required List<BiblePlanDayItem> items,
    required Iterable<BiblePlanDayItem> completedItems,
  }) => items.isEmpty
      ? this
      : BiblePlanDayProgress.fromCompletedItems(
          items: items,
          completedItems: {...getCompletedItems(items), ...completedItems},
        );

  BiblePlanDayProgress withItemUncompleted({required List<BiblePlanDayItem> items, required BiblePlanDayItem item}) =>
      BiblePlanDayProgress.fromCompletedItems(items: items, completedItems: getCompletedItems(items)..remove(item));
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
  esv_psalms_and_wisdom_literature,
  advent;

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
    advent => t.planTypes.advent,
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
    advent => t.planTypes.adventDescription,
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
    advent => BiblePlanSource(name: 'Lux', link: 'https://www.luxbible.app'),
  };

  bool get isCuratedByLux => this == advent;

  BiblePlanSeason? get season => switch (this) {
    advent => .advent,
    _ => null,
  };

  // Seasonal plans stay out of search until their promotion so they can ship quietly, while their links still open them.
  bool isListedOn(DateTime date) => switch (season) {
    final season? => !date.isBefore(season.promotionStartDate),
    null => true,
  };

  DateTime? getUpcomingTargetDate(DateTime date) => season?.getUpcomingEndDate(date);
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
    final books = days.expand((day) => day.passages).map((passage) => passage.chapter.book).distinct;
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

enum BiblePlanValidationError { nameRequired, invalidDayCount, readingRequired, invalidPassage, duplicatePassage }

extension BiblePlanDayProgressesExtension on Iterable<BiblePlanDayProgress> {
  int get completedDayCount => where((day) => day.isComplete).length;
}

extension BiblePlanDraftDaysExtension on List<BiblePlanDay> {
  List<BiblePlanDay> withPassageAdded(int dayIndex, ChapterPassage passage) {
    final day = this[dayIndex];
    return day.passages.contains(passage)
        ? this
        : withUpdateAt(dayIndex, (day) => day.copyWith(passages: [...day.passages, passage]));
  }

  List<BiblePlanDay> withPassageRemoved(int dayIndex, ChapterPassage passage) =>
      withUpdateAt(dayIndex, (day) => day.copyWith(passages: day.passages.withRemoved(passage)));

  List<BiblePlanDay> withStepRemoved(int dayIndex, BiblePlanDayStep step) =>
      withUpdateAt(dayIndex, (day) => day.withStepRemoved(step));

  List<BiblePlanDay> withPassageReordered(int dayIndex, int oldIndex, int newIndex) =>
      withUpdateAt(dayIndex, (day) => day.copyWith(passages: day.passages.withReorder(oldIndex, newIndex)));

  List<BiblePlanDay> withPassageMoved({
    required int sourceDayIndex,
    required int destinationDayIndex,
    required ChapterPassage passage,
  }) => withPassageRemoved(sourceDayIndex, passage).withUpdateAt(
    destinationDayIndex,
    (day) =>
        this[destinationDayIndex].passages.contains(passage) ? day : day.copyWith(passages: [...day.passages, passage]),
  );
}
