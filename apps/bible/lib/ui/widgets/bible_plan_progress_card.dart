import 'package:bible/models/hydrated_bible_plan_progress.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/sheets/bible_plan_annotations_sheet.dart';
import 'package:bible/ui/widgets/bible_plan_thumbnail.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class BiblePlanProgressCard extends HookConsumerWidget {
  final HydratedBiblePlanProgress progress;
  final int initialDayIndex;
  final Widget? caption;
  final List<Widget> menuItems;
  final Widget? footer;

  final Function(VerseSelection) onNavigateToVerseSelection;
  final Function(int dayIndex, int passageIndex)? onPassagePressed;
  final Function(int dayIndex, VerseSelection passage)? onPassageToggled;
  final Function(int dayIndex)? onReviewDayToggled;

  const BiblePlanProgressCard({
    super.key,
    required this.progress,
    required this.initialDayIndex,
    this.caption,
    required this.menuItems,
    this.footer,
    required this.onNavigateToVerseSelection,
    this.onPassagePressed,
    this.onPassageToggled,
    this.onReviewDayToggled,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final plan = progress.plan;
    final displayName = plan.getDisplayName(progress.id);

    final tabController = useTabController(initialLength: plan.dayCount, initialIndex: initialDayIndex);
    final dayIndex = useListenableSelector(tabController, () => tabController.index);
    final day = plan.days[dayIndex];
    final planDay = progress.getDayId(dayIndex);

    return StyledCard(
      children: [
        StyledListItem(
          leading: BiblePlanThumbnail.fromPlan(plan: plan, id: progress.id),
          title: displayName.toText(),
          subtitle: Padding(
            padding: .symmetric(vertical: 4),
            child: StyledProgressBar(
              value: progress.numCompletedDays / plan.dayCount,
              color: plan.getHue(context.colors).primary,
            ),
          ),
          thirdLine: caption,
          showDividerOverride: false,
          trailing: StyledCircleButton.md(
            child: Symbols.more_vert.toIcon(),
            onPressed: () =>
                context.showStyledSheet((_, _) => StyledSheet(title: displayName.toText(), children: menuItems)),
          ),
        ),
        StyledTabBar.scrollable(
          tabController: tabController,
          tabTitles: plan.dayIndexes.map((dayIndex) {
            final isCompleted = progress.isDayComplete(dayIndex: dayIndex);
            final isFuture = dayIndex > progress.currentDayIndex;

            return Row(
              spacing: 8,
              children: [
                Text(
                  t.biblePlans.day(day: dayIndex + 1),
                  style: TextStyle(color: isFuture ? context.colors.contentDisabled : null),
                ),
                Icon(
                  isCompleted ? Symbols.check_circle : Symbols.circle,
                  fill: isCompleted ? 1 : 0,
                  color: isCompleted
                      ? context.colors.contentPrimary
                      : isFuture
                      ? context.colors.contentDisabled
                      : context.colors.contentSecondary,
                  size: 16,
                ),
              ],
            );
          }).toList(),
        ),
        StyledList(
          children: day.isReviewAndReflect
              ? [
                  StyledListItem(
                    title: t.biblePlans.reviewAndReflect.toText(),
                    trailing: StyledCheckbox(isSelected: progress.isDayComplete(dayIndex: dayIndex)),
                    onPressed: switch (onReviewDayToggled) {
                      final onReviewDayToggled? => () => onReviewDayToggled(dayIndex),
                      null => null,
                    },
                  ),
                ]
              : day.passages
                    .mapIndexed(
                      (passageIndex, passage) => StyledListItem(
                        title: passage.format().toText(),
                        onPressed: switch (onPassagePressed) {
                          final onPassagePressed? => () => onPassagePressed(dayIndex, passageIndex),
                          null => null,
                        },
                        trailing: StyledCheckbox(
                          isSelected: progress.isPassageComplete(dayIndex: dayIndex, passage: passage),
                          onChanged: switch (onPassageToggled) {
                            final onPassageToggled? => (_) => onPassageToggled(dayIndex, passage),
                            null => null,
                          },
                        ),
                      ),
                    )
                    .toList(),
        ),
        if (user.getPlanDayAnnotations(planDay).isNotEmpty || footer != null)
          Padding(
            padding: .all(16),
            child: Column(
              spacing: 16,
              children: [
                if (user.getPlanDayAnnotations(planDay).isNotEmpty)
                  StyledRectButton.secondary(
                    label: t.biblePlans.reviewDayAnnotations.toText(),
                    onPressed: () => BiblePlanAnnotationsSheet.showDay(
                      context,
                      planDay: planDay,
                      planName: displayName,
                      onNavigateToVerseSelection: onNavigateToVerseSelection,
                    ),
                  ),
                ?footer,
              ],
            ),
          ),
      ],
    );
  }
}
