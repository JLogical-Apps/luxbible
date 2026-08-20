import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/flows/bible_plan_reminder_flow.dart';
import 'package:bible/ui/pages/bible_plan_read_page.dart';
import 'package:bible/ui/pages/bible_plan_search_page.dart';
import 'package:bible/ui/widgets/bible_plan_thumbnail.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class BiblePlansPage extends HookConsumerWidget {
  const BiblePlansPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final plans = ref.watch(biblePlansProvider);

    final visibleUser = useWhenVisible(user);
    final isProcessingRef = useRef(false);
    useWhenValueChanged(visibleUser, (prevUser, currUser) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!context.mounted || isProcessingRef.value) return;

        final discoveredPlanTypes = currUser.planProgressByType
            .where((planType, progress) {
              final previousProgress = prevUser.planProgressByType[planType];
              return progress.reminder == null &&
                  previousProgress != null &&
                  progress.days.anyIndexed(
                    (dayIndex, day) => switch (previousProgress.days.elementAtOrNull(dayIndex)) {
                      final previousDay? => !previousDay.isComplete && day.isComplete,
                      null => false,
                    },
                  );
            })
            .keys
            .toList();
        if (discoveredPlanTypes.isEmpty) return;

        isProcessingRef.value = true;
        try {
          for (final planType in discoveredPlanTypes) {
            if (!context.mounted) break;
            await BiblePlanReminderFlow.showDiscoveryPrompt(context: context, planType: planType);
          }
        } finally {
          isProcessingRef.value = false;
        }
      });
    });

    return StyledPage(
      title: t.labels.biblePlans.toText(),
      backgroundColor: .backgroundPrimary,
      trailing: Tooltip(
        message: t.biblePlans.addPlan,
        child: StyledCircleButton.md(child: Symbols.add.toIcon(), onPressed: () => context.push(BiblePlanSearchPage())),
      ),
      body: StyledListView(
        children: [
          gapH16,
          if (user.planProgressByType.isEmpty)
            Padding(
              padding: .symmetric(horizontal: 16),
              child: StyledTile.message(
                leading: Symbols.calendar_month.toIcon(),
                title: t.emptyStates.noPlans.toText(),
              ),
            ),
          StyledReorderableList(
            shrinkWrap: true,
            showProxyBackground: false,
            onReorder: (a, b) =>
                ref.updateUser((user) => user.copyWith(planProgressByType: user.planProgressByType.withReorder(a, b))),
            children: user
                .getHydratedPlanProgresses(plans)
                .map(
                  (progress) => HookBuilder(
                    key: ValueKey(progress.type),
                    builder: (_) {
                      final plan = progress.plan;
                      final planType = progress.type;
                      final dailyReminderTime = progress.progress.reminder?.dailyTime;

                      final tabController = useTabController(
                        initialLength: plan.dayCount,
                        initialIndex: progress.currentDayIndex,
                      );
                      final dayIndex = useListenableSelector(tabController, () => tabController.index);
                      final day = plan.days[dayIndex];

                      return SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: .only(left: 16, right: 16, bottom: 16),
                          child: StyledCard(
                            children: [
                              StyledListItem(
                                leading: BiblePlanThumbnail(plan: plan, planType: planType),
                                title: planType.title().toText(),
                                subtitle: Padding(
                                  padding: .symmetric(vertical: 4),
                                  child: StyledProgressBar(
                                    value: progress.numCompletedDays / plan.dayCount,
                                    color: plan.getHue(context.colors).primary,
                                  ),
                                ),
                                showDividerOverride: false,
                                trailing: StyledCircleButton.md(
                                  child: Symbols.more_vert.toIcon(),
                                  onPressed: () => context.showStyledSheet(
                                    (_, ref) => StyledSheet(
                                      title: planType.title().toText(),
                                      children: [
                                        StyledListItem(
                                          leading: Icon(
                                            dailyReminderTime == null
                                                ? Symbols.notifications_off
                                                : Symbols.notifications_active,
                                          ),
                                          title: t.biblePlans.dailyReminders.toText(),
                                          subtitle: dailyReminderTime == null
                                              ? t.biblePlans.dailyRemindersDescription.toText()
                                              : t.biblePlans
                                                    .dailyAt(time: dailyReminderTime.format(format: context.timeFormat))
                                                    .toText(),
                                          onPressed: () async {
                                            context.pop();
                                            final newTime = await context.showStyledSheet(
                                              (context, ref) => StyledTimeDialSheet(
                                                title: t.biblePlans.dailyReminders.toText(),
                                                initialTime: dailyReminderTime,
                                                trailing: dailyReminderTime == null
                                                    ? null
                                                    : StyledCircleButton.md(
                                                        child: Symbols.delete.toIcon(),
                                                        onPressed: () async {
                                                          context.pop();

                                                          final shouldDelete = await context.showStyledDialog(
                                                            (dialogContext) => StyledDialog.confirmDelete(
                                                              cancelLabel: t.common.nevermind.toText(),
                                                              title: t.biblePlans.deleteReminder.toText(),
                                                              body: t.biblePlans
                                                                  .deleteReminderConfirmation(name: planType.title())
                                                                  .toText(),
                                                            ),
                                                          );
                                                          if (shouldDelete == true) {
                                                            ref.updateUser(
                                                              (user) => user.withPlanReminder(planType, .none()),
                                                            );
                                                          }
                                                        },
                                                      ),
                                              ),
                                            );

                                            if (newTime != null && context.mounted) {
                                              await BiblePlanReminderFlow.save(
                                                context: context,
                                                planType: planType,
                                                time: newTime,
                                              );
                                            }
                                          },
                                        ),
                                        StyledListItem(
                                          leading: Icon(Symbols.stop_circle, color: context.colors.contentCritical),
                                          title: t.biblePlans.stopPlan.toText(),
                                          subtitle: t.biblePlans.stopPlanDescription.toText(),
                                          onPressed: () async {
                                            context.pop();
                                            final confirmed = await context.showStyledDialog(
                                              (context) => StyledDialog.confirmDelete(
                                                cancelLabel: t.common.nevermind.toText(),
                                                title: t.biblePlans.stopPlan.toText(),
                                                body: t.biblePlans.stopConfirmation(name: planType.title()).toText(),
                                                deleteLabel: t.common.stop.toText(),
                                              ),
                                            );
                                            if (confirmed == true) {
                                              ref.updateUser((user) => user.withStoppedPlan(planType));
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
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
                                        StyledListItem.checkbox(
                                          title: t.biblePlans.reviewAndReflect.toText(),
                                          isSelected: progress.isDayComplete(dayIndex: dayIndex),
                                          onSelected: (_) => ref.updateUser(
                                            (user) => user.withPlanDayToggled(planType: planType, dayIndex: dayIndex),
                                          ),
                                        ),
                                      ]
                                    : day.passages
                                          .mapIndexed(
                                            (passageIndex, passage) => StyledListItem(
                                              title: passage.format().toText(),
                                              onPressed: () async {
                                                final result = await context.push<VerseSelection>(
                                                  BiblePlanReadPage(
                                                    planType: planType,
                                                    dayIndex: dayIndex,
                                                    initialPassageIndex: passageIndex,
                                                  ),
                                                );
                                                if (result != null && context.mounted) context.pop(result);
                                              },
                                              trailing: StyledCheckbox(
                                                isSelected: progress.isPassageComplete(
                                                  dayIndex: dayIndex,
                                                  passage: passage,
                                                ),
                                                onChanged: (_) => ref.updateUser(
                                                  (user) => user.withPassageToggled(
                                                    planType: planType,
                                                    dayIndex: dayIndex,
                                                    day: day,
                                                    passage: passage,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                              ),
                              if (progress.isCompleted)
                                Padding(
                                  padding: .all(16),
                                  child: StyledRectButton.primary(
                                    label: t.common.finish.toText(),
                                    onPressed: () {
                                      ref.updateUser((user) => user.withCompletedPlan(planType));
                                      context.showStyledSnackbar(
                                        message: t.biblePlans.completed(name: planType.title()).toText(),
                                        action: StyledTextAction(
                                          label: t.biblePlans.startNew.toText(),
                                          onPressed: () => context.push(BiblePlanSearchPage()),
                                        ),
                                        duration: Duration(seconds: 10),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
                .toList(),
          ),
          SizedBox(height: MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }
}
