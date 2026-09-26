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
      passages:
          (json['passages'] as List<dynamic>?)
              ?.map((e) => VerseSelection.fromJson(e as String))
              .toList() ??
          const [],
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
    );

Map<String, dynamic> _$BiblePlanProgressToJson(_BiblePlanProgress instance) =>
    <String, dynamic>{
      'instanceId': instance.instanceId,
      'days': instance.days.map((e) => e.toJson()).toList(),
      'reminder': instance.reminder?.toJson(),
      'lastCompletedAt': instance.lastCompletedAt?.toJson(),
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
  completedPassages:
      (json['completedPassages'] as List<dynamic>?)
          ?.map((e) => VerseSelection.fromJson(e as String))
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
  'runtimeType': instance.$type,
};

CompleteBiblePlanDayProgress _$CompleteBiblePlanDayProgressFromJson(
  Map<String, dynamic> json,
) => CompleteBiblePlanDayProgress($type: json['runtimeType'] as String?);

Map<String, dynamic> _$CompleteBiblePlanDayProgressToJson(
  CompleteBiblePlanDayProgress instance,
) => <String, dynamic>{'runtimeType': instance.$type};
