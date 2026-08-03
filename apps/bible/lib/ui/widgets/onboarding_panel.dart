import 'package:lux/i18n.dart';
import 'package:bible/models/user/onboarding_step.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:style/style.dart';
import 'package:lux/lux.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
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
      keyByStep[currentStep]?.scrollIntoView(alignment: 0.5, duration: Duration(milliseconds: 300));
    }, [currentStep]);

    return StyledSheet(
      showDragHandle: showDragHandle,
      leading: StyledCircleButton.md(
        child: Symbols.close.toIcon(),
        onPressed: () async {
          final shouldSkip = await context.showStyledDialog(
            (context) => StyledDialog.confirmOrCancel(
              cancelLabel: t.common.nevermind.toText(),
              title: t.onboarding.skipQuestion.toText(),
              body: t.onboarding.skipConfirmation.toText(),
            ),
          );
          if (shouldSkip == true) {
            ref.updateUser((user) => user.withOnboardingDismissed());
          }
        },
      ),
      title: t.onboarding.getStarted.toText(),
      subtitle: t.onboarding.learnLux.toText(),
      children: [
        Padding(
          padding: .all(16),
          child: StyledTile.message(
            leading: Symbols.info.toIcon(),
            title: t.onboarding.checklistDescription.toText(),
            subtitle: t.onboarding.skipHint.toText(),
          ),
        ),
        ...OnboardingStep.values.mapIndexed((stepIndex, step) {
          final isStepCompleted = user.isOnboardingStepCompleted(step);
          final isActiveStep = stepIndex == currentStepIndex;
          return StyledListItem.checkbox(
            key: keyByStep[step],
            leading: step.icon.toIcon(),
            title: step.title().toText(),
            subtitle: !isActiveStep
                ? null
                : Column(
                    crossAxisAlignment: .start,
                    children: step.microSteps
                        .map(
                          (microStep) => Row(
                            spacing: 4,
                            crossAxisAlignment: .start,
                            children: [
                              Text('•'),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(children: microStep.description(translation: user.translation)),
                                  style: TextStyle(decoration: microStep.isCompleted(state) ? .lineThrough : null),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
            isSelected: isStepCompleted,
            onSelected: null,
            isEnabled: isActiveStep,
          );
        }),
      ],
      buttonsBuilder: (context) => [
        if (isComplete)
          StyledRectButton.primary(
            label: t.common.finish.toText(),
            onPressed: () => ref.updateUser((user) => user.withOnboardingDismissed()),
          ),
      ],
    );
  }
}
