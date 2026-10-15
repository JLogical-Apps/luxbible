// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnboardingProgress _$OnboardingProgressFromJson(Map<String, dynamic> json) =>
    _OnboardingProgress(
      tour: $enumDecode(_$OnboardingTourEnumMap, json['tour']),
      completedSteps: json['completedSteps'] == null
          ? const []
          : const KnownOnboardingSteps().fromJson(
              json['completedSteps'] as List,
            ),
    );

Map<String, dynamic> _$OnboardingProgressToJson(_OnboardingProgress instance) =>
    <String, dynamic>{
      'tour': _$OnboardingTourEnumMap[instance.tour]!,
      'completedSteps': const KnownOnboardingSteps().toJson(
        instance.completedSteps,
      ),
    };

const _$OnboardingTourEnumMap = {
  OnboardingTour.getStarted: 'getStarted',
  OnboardingTour.advanced: 'advanced',
};
