import 'package:bible/models/user/onboarding_step.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension WidgetRefExtension on WidgetRef {
  Future<void> updateUser(User Function(User) updater) => read(userProvider.notifier).update(updater);

  Future<void> markOnboardingStep(OnboardingStep step) => updateUser((user) => user.withOnboardingStepCompleted(step));
}

extension ProviderContainerExtension on ProviderContainer {
  Future<void> updateUser(User Function(User) updater) => read(userProvider.notifier).update(updater);

  Future<void> markOnboardingStep(OnboardingStep step) => updateUser((user) => user.withOnboardingStepCompleted(step));
}
