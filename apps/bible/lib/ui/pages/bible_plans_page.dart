import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/bible_plan_history_provider.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/flows/bible_plan_reminder_flow.dart';
import 'package:bible/ui/pages/bible_plan_history_page.dart';
import 'package:bible/ui/pages/bible_plan_read_page.dart';
import 'package:bible/ui/pages/bible_plan_search_page.dart';
import 'package:bible/ui/sheets/bible_plan_annotations_sheet.dart';
import 'package:bible/ui/sheets/bible_plan_pace_sheet.dart';
import 'package:bible/ui/widgets/bible_plan_file_list_items.dart';
import 'package:bible/ui/widgets/bible_plan_history_list_items.dart';
import 'package:bible/ui/widgets/bible_plan_progress_card.dart';
import 'package:bible/utils/bible_hook_utils.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class BiblePlansPage extends HookConsumerWidget implements StyledRoute<VerseSelection> {
  const BiblePlansPage({super.key});

  @override
  String get path => '/bible-plans';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final plans = ref.watch(biblePlansProvider);
    final history = ref.watch(biblePlanHistoryProvider);

    final progresses = user.getHydratedPlanProgresses(plans);

    useMessage(user, .renamedBiblePlans);

    final visibleUser = useWhenVisible(user);
    final isProcessingRef = useRef(false);
    useWhenValueChanged(visibleUser, (prevUser, currUser) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!context.mounted || isProcessingRef.value) return;

        final completedPlanTypes = currUser.planProgressById
            .where((planId, progress) => progress.hasCompletedDaySince(prevUser.planProgressById[planId]))
            .keys
            .toList();
        if (completedPlanTypes.isEmpty) return;

        isProcessingRef.value = true;
        try {
          for (final planId in completedPlanTypes.where(
            (planId) => currUser.planProgressById[planId]?.reminder == null,
          )) {
            if (!context.mounted) break;
            await BiblePlanReminderFlow.showDiscoveryPrompt(context: context, planId: planId);
          }
          await ref.read(userProvider.notifier).requestReviewIfEligible();
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
          if (progresses.isEmpty)
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
            onReorder: (a, b) => ref.updateUser(
              (user) => user.withReorderedPlans(progresses.map((progress) => progress.id).toList().withReorder(a, b)),
            ),
            children: progresses.map((progress) {
              final plan = progress.plan;
              final planId = progress.id;
              final displayName = plan.getDisplayName(planId);
              final dailyReminderTime = progress.progress.reminder?.dailyTime;
              final pace = progress.progress.pace;
              final daysAheadOfPace = progress.daysAheadOfPace;

              Future<void> editPace({required String title, required BiblePlanPace initialPace}) async {
                final newPace = await BiblePlanPaceSheet.showEdit(
                  context,
                  title: title,
                  progress: progress,
                  initialPace: initialPace,
                );
                if (newPace != null) ref.updateUser((user) => user.withPlanPace(planId, newPace));
              }

              return SafeArea(
                key: ValueKey(progress.instanceId),
                bottom: false,
                child: Padding(
                  padding: .only(left: 16, right: 16, bottom: 16),
                  child: BiblePlanProgressCard(
                    progress: progress,
                    initialDayIndex: progress.currentDayIndex,
                    caption: switch (daysAheadOfPace) {
                      null => null,
                      0 => t.biblePlans.onTrack.toText(),
                      final days when days < 0 => t.biblePlans.daysBehind(count: -days).toText(),
                      final days => t.biblePlans.daysAhead(count: days).toText(),
                    },
                    onNavigateToVerseSelection: (selection) {
                      context.pop();
                      context.pop(selection);
                    },
                    onPassagePressed: (dayIndex, passageIndex) async {
                      final result = await context.push(
                        BiblePlanReadPage(planId: planId, dayIndex: dayIndex, initialPassageIndex: passageIndex),
                      );
                      if (result != null && context.mounted) context.pop(result);
                    },
                    onPassageToggled: (dayIndex, passage) => ref.updateUser(
                      (user) => user.withPassageToggled(
                        planId: planId,
                        dayIndex: dayIndex,
                        day: plan.days[dayIndex],
                        passage: passage,
                      ),
                    ),
                    onReviewDayToggled: (dayIndex) =>
                        ref.updateUser((user) => user.withPlanDayToggled(planId: planId, dayIndex: dayIndex)),
                    menuItems: [
                      StyledListItem(
                        leading: pace.type.icon.toIcon(),
                        title: t.biblePlans.pace.toText(),
                        subtitle: pace.format().toText(),
                        onPressed: () {
                          context.pop();
                          editPace(title: t.biblePlans.pace, initialPace: pace);
                        },
                      ),
                      StyledListItem(
                        leading: Icon(
                          dailyReminderTime == null ? Symbols.notifications_off : Symbols.notifications_active,
                        ),
                        title: t.biblePlans.dailyReminders.toText(),
                        subtitle: dailyReminderTime == null
                            ? t.biblePlans.dailyRemindersDescription.toText()
                            : t.biblePlans.dailyAt(time: dailyReminderTime.format(format: context.timeFormat)).toText(),
                        onPressed: () async {
                          context.pop();
                          final newTime = await context.showStyledSheet(
                            (context, _) => StyledTimeDialSheet(
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
                                            body: t.biblePlans.deleteReminderConfirmation(name: displayName).toText(),
                                          ),
                                        );
                                        if (shouldDelete == true) {
                                          ref.updateUser((user) => user.withPlanReminder(planId, .none()));
                                        }
                                      },
                                    ),
                            ),
                          );

                          if (newTime != null && context.mounted) {
                            await BiblePlanReminderFlow.save(context: context, planId: planId, time: newTime);
                          }
                        },
                      ),
                      if (user.getPlanInstanceAnnotations(progress.instanceId).isNotEmpty)
                        BiblePlanAnnotationsListItem(
                          onPressed: () {
                            context.pop();
                            BiblePlanAnnotationsSheet.showInstance(
                              context,
                              instanceId: progress.instanceId,
                              planName: displayName,
                              onNavigateToVerseSelection: (selection) {
                                context.pop();
                                context.pop(selection);
                              },
                            );
                          },
                        ),
                      if (history.hasEntriesForPlan(planId))
                        BiblePlanHistoryListItem(
                          onPressed: () {
                            context.pop();
                            context.push(BiblePlanHistoryPage(planId: planId));
                          },
                        ),
                      BiblePlanShareListItem(plan: plan, displayName: displayName),
                      BiblePlanDownloadListItem(plan: plan, displayName: displayName),

                      StyledListItem(
                        leading: Symbols.stop_circle.toIcon(),
                        title: t.biblePlans.stopPlan.toText(),
                        subtitle: t.biblePlans.stopPlanDescription.toText(),
                        onPressed: () async {
                          context.pop();
                          final confirmed = await context.showStyledDialog(
                            (context) => StyledDialog.confirmOrCancel(
                              title: t.biblePlans.stopPlan.toText(),
                              body: t.biblePlans.stopConfirmation(name: displayName).toText(),
                              confirmLabel: t.common.stop.toText(),
                              cancelLabel: t.common.nevermind.toText(),
                            ),
                          );
                          if (confirmed == true) ref.read(biblePlanHistoryProvider.notifier).moveToHistory(planId);
                        },
                      ),
                    ],
                    footer: progress.isCompleted
                        ? StyledRectButton.primary(
                            label: t.common.finish.toText(),
                            onPressed: () {
                              ref.read(biblePlanHistoryProvider.notifier).moveToHistory(planId);
                              context.showStyledSnackbar(
                                message: t.biblePlans.completed(name: displayName).toText(),
                                action: StyledTextAction(
                                  label: t.biblePlans.startNew.toText(),
                                  onPressed: () => context.push(BiblePlanSearchPage()),
                                ),
                                duration: Duration(seconds: 10),
                              );
                            },
                          )
                        : daysAheadOfPace != null && daysAheadOfPace < 0
                        ? StyledRectButton.secondary(
                            label: t.biblePlans.catchUp.toText(),
                            onPressed: () => editPace(
                              title: t.biblePlans.catchUp,
                              initialPace: BiblePlanPace.paced(endDate: progress.naturalEndDate),
                            ),
                          )
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
          Builder(builder: (context) => SizedBox(height: MediaQuery.paddingOf(context).bottom)),
        ],
      ),
    );
  }
}
