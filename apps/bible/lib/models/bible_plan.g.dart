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
);

Map<String, dynamic> _$BiblePlanToJson(_BiblePlan instance) =>
    <String, dynamic>{
      'name': instance.name,
      'days': instance.days.map((e) => e.toJson()).toList(),
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
      'days': instance.days.map((e) => e.toJson()).toList(),
      'reminder': instance.reminder?.toJson(),
      'lastCompletedAt': instance.lastCompletedAt?.toJson(),
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
