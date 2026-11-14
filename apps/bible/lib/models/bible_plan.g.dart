// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BiblePlan _$BiblePlanFromJson(Map<String, dynamic> json) => _BiblePlan(
  name: json['name'] as String,
  days: (json['days'] as List<dynamic>)
      .map((e) => BiblePlanDay.fromJson(e as Map<String, dynamic>))
      .toList(),
  colorOverride: $enumDecodeNullable(_$BiblePlanColorEnumMap, json['color']),
);

Map<String, dynamic> _$BiblePlanToJson(_BiblePlan instance) =>
    <String, dynamic>{
      'name': instance.name,
      'days': instance.days.map((e) => e.toJson()).toList(),
      'color': ?_$BiblePlanColorEnumMap[instance.colorOverride],
    };

const _$BiblePlanColorEnumMap = {
  BiblePlanColor.red: 'red',
  BiblePlanColor.orange: 'orange',
  BiblePlanColor.yellow: 'yellow',
  BiblePlanColor.green: 'green',
  BiblePlanColor.blue: 'blue',
  BiblePlanColor.violet: 'violet',
};

_BiblePlanDay _$BiblePlanDayFromJson(Map<String, dynamic> json) =>
    _BiblePlanDay(
      passages: json['passages'] == null
          ? const []
          : ChapterPassage.listFromJson(json['passages'] as List),
    );

Map<String, dynamic> _$BiblePlanDayToJson(_BiblePlanDay instance) =>
    <String, dynamic>{
      'passages': instance.passages.map((e) => e.toJson()).toList(),
    };

_BiblePlanProgress _$BiblePlanProgressFromJson(Map<String, dynamic> json) =>
    _BiblePlanProgress(
      instanceId: json['instanceId'] as String?,
      days: (json['days'] as List<dynamic>)
          .map((e) => BiblePlanDayProgress.fromJson(e as Map<String, dynamic>))
          .toList(),
      reminder: json['reminder'] == null
          ? null
          : Reminder.fromJson(json['reminder'] as Map<String, dynamic>),
      lastCompletedAt: json['lastCompletedAt'] == null
          ? null
          : CalendarDateTime.fromJson(json['lastCompletedAt'] as String),
      pace: json['pace'] == null
          ? const BiblePlanPace.relaxed()
          : BiblePlanPace.fromJson(json['pace'] as Map<String, dynamic>),
      isSkippingReflections: json['isSkippingReflections'] as bool? ?? false,
      hasOfferedToSkipReflections:
          json['hasOfferedToSkipReflections'] as bool? ?? false,
      reflectionAnswerByDayIndex:
          (json['reflectionAnswerByDayIndex'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(int.parse(k), e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$BiblePlanProgressToJson(_BiblePlanProgress instance) =>
    <String, dynamic>{
      'instanceId': instance.instanceId,
      'days': instance.days.map((e) => e.toJson()).toList(),
      'reminder': instance.reminder?.toJson(),
      'lastCompletedAt': instance.lastCompletedAt?.toJson(),
      'pace': instance.pace.toJson(),
      'isSkippingReflections': instance.isSkippingReflections,
      'hasOfferedToSkipReflections': instance.hasOfferedToSkipReflections,
      'reflectionAnswerByDayIndex': instance.reflectionAnswerByDayIndex.map(
        (k, e) => MapEntry(k.toString(), e),
      ),
    };

RelaxedBiblePlanPace _$RelaxedBiblePlanPaceFromJson(
  Map<String, dynamic> json,
) => RelaxedBiblePlanPace($type: json['runtimeType'] as String?);

Map<String, dynamic> _$RelaxedBiblePlanPaceToJson(
  RelaxedBiblePlanPace instance,
) => <String, dynamic>{'runtimeType': instance.$type};

PacedBiblePlanPace _$PacedBiblePlanPaceFromJson(Map<String, dynamic> json) =>
    PacedBiblePlanPace(
      endDate: decodeIsoDate(json['endDate'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$PacedBiblePlanPaceToJson(PacedBiblePlanPace instance) =>
    <String, dynamic>{
      'endDate': encodeIsoDate(instance.endDate),
      'runtimeType': instance.$type,
    };

_BiblePlanHistoryEntry _$BiblePlanHistoryEntryFromJson(
  Map<String, dynamic> json,
) => _BiblePlanHistoryEntry(
  planId: json['planId'] as String,
  progress: BiblePlanProgress.fromJson(
    json['progress'] as Map<String, dynamic>,
  ),
  endedAt: CalendarDateTime.fromJson(json['endedAt'] as String),
);

Map<String, dynamic> _$BiblePlanHistoryEntryToJson(
  _BiblePlanHistoryEntry instance,
) => <String, dynamic>{
  'planId': instance.planId,
  'progress': instance.progress.toJson(),
  'endedAt': instance.endedAt.toJson(),
};

_BiblePlanDayId _$BiblePlanDayIdFromJson(Map<String, dynamic> json) =>
    _BiblePlanDayId(
      instanceId: json['instanceId'] as String,
      dayIndex: (json['dayIndex'] as num).toInt(),
    );

Map<String, dynamic> _$BiblePlanDayIdToJson(_BiblePlanDayId instance) =>
    <String, dynamic>{
      'instanceId': instance.instanceId,
      'dayIndex': instance.dayIndex,
    };

IncompleteBiblePlanDayProgress _$IncompleteBiblePlanDayProgressFromJson(
  Map<String, dynamic> json,
) => IncompleteBiblePlanDayProgress(
  completedPassages: json['completedPassages'] == null
      ? const {}
      : ChapterPassage.setFromJson(json['completedPassages'] as List),
  completedSteps:
      (json['completedSteps'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$BiblePlanDayStepEnumMap, e))
          .toSet() ??
      const {},
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$IncompleteBiblePlanDayProgressToJson(
  IncompleteBiblePlanDayProgress instance,
) => <String, dynamic>{
  'completedPassages': instance.completedPassages
      .map((e) => e.toJson())
      .toList(),
  'completedSteps': instance.completedSteps
      .map((e) => _$BiblePlanDayStepEnumMap[e]!)
      .toList(),
  'runtimeType': instance.$type,
};

const _$BiblePlanDayStepEnumMap = {
  BiblePlanDayStep.studyNotes: 'studyNotes',
  BiblePlanDayStep.reflection: 'reflection',
};

CompleteBiblePlanDayProgress _$CompleteBiblePlanDayProgressFromJson(
  Map<String, dynamic> json,
) => CompleteBiblePlanDayProgress($type: json['runtimeType'] as String?);

Map<String, dynamic> _$CompleteBiblePlanDayProgressToJson(
  CompleteBiblePlanDayProgress instance,
) => <String, dynamic>{'runtimeType': instance.$type};
