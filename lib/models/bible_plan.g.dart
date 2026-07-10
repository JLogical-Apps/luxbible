// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BiblePlan _$BiblePlanFromJson(Map<String, dynamic> json) => _BiblePlan(
  name: json['name'] as String,
  description: json['description'] as String? ?? '',
  days: (json['days'] as List<dynamic>)
      .map((e) => BiblePlanDay.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$BiblePlanToJson(_BiblePlan instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
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
      isExpanded: json['isExpanded'] as bool? ?? true,
    );

Map<String, dynamic> _$BiblePlanProgressToJson(_BiblePlanProgress instance) =>
    <String, dynamic>{
      'days': instance.days.map((e) => e.toJson()).toList(),
      'isExpanded': instance.isExpanded,
    };

_BiblePlanDayProgress _$BiblePlanDayProgressFromJson(
  Map<String, dynamic> json,
) => _BiblePlanDayProgress(
  completedPassages:
      (json['completedPassages'] as List<dynamic>?)
          ?.map((e) => VerseSelection.fromJson(e as String))
          .toSet() ??
      const {},
);

Map<String, dynamic> _$BiblePlanDayProgressToJson(
  _BiblePlanDayProgress instance,
) => <String, dynamic>{
  'completedPassages': instance.completedPassages
      .map((e) => e.toJson())
      .toList(),
};
