import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/hook_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class BiblePlanPage extends HookConsumerWidget {
  final BiblePlanType planType;

  const BiblePlanPage({super.key, required this.planType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final plans = ref.watch(biblePlansProvider);
    final plan = plans[planType]!;
    final progress = user.getHydratedPlanProgress(planType: planType, planByType: plans);

    final dayKeys = useMemoized(() => plan.days.map((_) => GlobalKey()).toList());
    usePostFrameEffect(() {
      if (progress == null) {
        return;
      }

      final currentDayContext = dayKeys[progress.currentDayIndex].currentContext;
      if (currentDayContext != null) {
        Scrollable.ensureVisible(currentDayContext, duration: .zero, curve: Curves.easeInOutCubic, alignment: 0.4);
      }
    });

    return StyledPage(
      title: plan.name.toText(),
      trailing: progress == null
          ? null
          : StyledCircleButton.lg(
              child: Symbols.more_vert.toIcon(),
              onPressed: () => context.showStyledSheet(
                (_) => StyledSheet(
                  title: plan.name.toText(),
                  children: [
                    StyledListItem(
                      leading: Icon(Symbols.stop_circle, color: context.colors.contentCritical),
                      title: 'Stop Plan'.toText(),
                      subtitle: 'Remove this plan and its progress.'.toText(),
                      onPressed: () async {
                        context.pop();
                        final confirmed = await context.showStyledDialog(
                          (context) => StyledDialog.confirmDelete(
                            title: 'Stop Plan'.toText(),
                            body: 'Are you sure you want to stop "${plan.name}"? Your progress will be lost.'.toText(),
                            deleteLabel: 'Stop'.toText(),
                          ),
                        );
                        if (confirmed == true) {
                          ref.updateUser((user) => user.withStoppedPlan(planType));
                          if (context.mounted) context.pop();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
      body: StyledDock(
        shrinkWrap: false,
        children: [
          StyledSection(
            padding: .only(top: 24),
            title: 'Days'.toText(),
            children: plan.days.mapIndexed<Widget>((dayIndex, day) {
              final isCurrent = dayIndex == progress?.currentDayIndex;

              return StyledListItem(
                key: dayKeys[dayIndex],
                isEnabled: progress == null || isCurrent,
                title: 'Day ${dayIndex + 1}'.toText(),
                subtitle: Text(day.passages.map((passage) => passage.format()).join(' • ')),
                trailing: progress == null
                    ? null
                    : StyledCheckbox(
                        isSelected: progress.isDayComplete(dayIndex: dayIndex),
                        isPartial: progress.isDayPartial(dayIndex: dayIndex),
                        isEnabled: isCurrent,
                      ),
                onPressed: progress == null
                    ? null
                    : () async {
                        final confirmed = await context.showStyledDialog(
                          (context) => StyledDialog.confirmOrCancel(
                            title: 'Jump to Day ${dayIndex + 1}?'.toText(),
                            body:
                                'This marks every earlier day as complete and makes Day ${dayIndex + 1} your current day.'
                                    .toText(),
                          ),
                        );
                        if (confirmed == true) {
                          ref.updateUser(
                            (user) => user.withJumpedToDay(planType: planType, plan: plan, dayIndex: dayIndex),
                          );
                        }
                      },
              );
            }).toList(),
          ),
        ],
        buttonsBuilder: (context) => [
          if (progress == null)
            StyledRectButton.primary(
              label: 'Start Plan'.toText(),
              onPressed: () {
                ref.updateUser((user) => user.withStartedPlan(planType: planType, plan: plan));
                context.pop(planType);
              },
            ),
        ],
      ),
    );
  }
}
