import 'package:bible/models/user/onboarding_step.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/hook_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:utils_core/utils_core.dart';

class OnboardingPanel extends HookConsumerWidget {
  final bool showDragHandle;
  final OnboardingState state;
  final bool isVisible;

  const OnboardingPanel({super.key, required this.showDragHandle, required this.state, required this.isVisible});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final currentStepIndex = user.currentOnboardingStepIndex;
    final currentStep = user.currentOnboardingStep;
    final isComplete = currentStep == null;

    final keyByStep = useMemoized(() => OnboardingStep.values.mapToMap((step) => MapEntry(step, GlobalKey())));

    usePostFrameEffect(() async {
      if (currentStep == null || !isVisible) return;
      await Future.delayed(Duration(milliseconds: 200));
      final stepContext = keyByStep[currentStep]?.currentContext;
      if (stepContext != null && stepContext.mounted) {
        Scrollable.ensureVisible(
          stepContext,
          alignment: 0.5,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
        );
      }
    }, [currentStep]);

    return StyledSheet(
      showDragHandle: showDragHandle,
      leading: StyledCircleButton.lg(
        child: Symbols.close.toIcon(),
        onPressed: () async {
          final shouldSkip = await context.showStyledDialog(
            (context) => StyledDialog.confirmOrCancel(
              title: 'Skip Onboarding?'.toText(),
              body: 'Are you sure you want to skip the onboarding? You can restart it from Settings > Help.'.toText(),
            ),
          );
          if (shouldSkip == true) {
            ref.updateUser((user) => user.withOnboardingDismissed());
          }
        },
      ),
      title: 'Onboarding'.toText(),
      children: OnboardingStep.values.mapIndexed((stepIndex, step) {
        final isStepCompleted = user.isOnboardingStepCompleted(step);
        final isActiveStep = stepIndex == currentStepIndex;
        return StyledListItem(
          key: keyByStep[step],
          leading: step.icon.toIcon(),
          title: step.title().toText(),
          subtitle: isActiveStep ? step.instructions().toText() : null,
          thirdLine: step.microSteps.isEmpty || !isActiveStep
              ? null
              : Padding(
                  padding: .only(top: 8),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: step.microSteps.map((microStep) {
                      final isCompleted = microStep.isCompleted(state);
                      return IntrinsicWidth(
                        child: StyledTag.md(
                          colorBuilder: isCompleted ? .primary : .surfaceSecondary,
                          onPressed: () => context.showStyledDialog(
                            (context) => StyledDialog.confirm(
                              title: microStep.title().toText(),
                              body: microStep.detail().toText(),
                            ),
                          ),
                          leading: isCompleted ? Symbols.check.toIcon() : null,
                          child: microStep.title().toText(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
          trailing: StyledCheckbox(isSelected: isStepCompleted, isEnabled: false),
          isEnabled: isActiveStep,
        );
      }).toList(),
      buttonsBuilder: (context) => [
        if (isComplete)
          StyledRectButton.primary(
            label: 'Finish'.toText(),
            onPressed: () => ref.updateUser((user) => user.withOnboardingDismissed()),
          ),
      ],
    );
  }
}
