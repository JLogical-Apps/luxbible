import 'dart:async';

import 'package:bible/models/user/onboarding_step.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension RefExtension on Ref {
  void invalidateDaily() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final timer = Timer(tomorrow.difference(now), invalidateSelf);
    onDispose(timer.cancel);
  }
}

extension WidgetRefExtension on WidgetRef {
  User updateUser(User Function(User) updater) => read(userProvider.notifier).update(updater);

  User markOnboardingStep(OnboardingStep step) => updateUser((user) => user.withOnboardingStepCompleted(step));
}

extension ProviderContainerExtension on ProviderContainer {
  User updateUser(User Function(User) updater) => read(userProvider.notifier).update(updater);

  User markOnboardingStep(OnboardingStep step) => updateUser((user) => user.withOnboardingStepCompleted(step));
}
