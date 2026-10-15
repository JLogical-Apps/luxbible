import 'package:bible/models/user/onboarding_step.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lux/lux.dart';

part 'onboarding_progress.freezed.dart';
part 'onboarding_progress.g.dart';

@freezed
sealed class OnboardingProgress with _$OnboardingProgress {
  const OnboardingProgress._();

  const factory OnboardingProgress({
    required OnboardingTour tour,
    @Default([]) @KnownOnboardingSteps() List<OnboardingStep> completedSteps,
  }) = _OnboardingProgress;

  factory OnboardingProgress.fromJson(Map<String, dynamic> json) => _$OnboardingProgressFromJson(json);

  OnboardingStep? get currentStep => tour.steps.firstWhereOrNull((step) => !completedSteps.has(step));

  bool get isComplete => currentStep == null;

  OnboardingProgress withStepCompleted(OnboardingStep step) =>
      step.tour != tour || completedSteps.has(step) ? this : copyWith(completedSteps: [...completedSteps, step]);
}
