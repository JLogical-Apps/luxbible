import 'package:bible/providers/bible_plan_history_provider.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/bible_navigation_service.dart';
import 'package:bible/ui/sheets/bible_plan_annotations_sheet.dart';
import 'package:bible/ui/widgets/bible_plan_history_list_items.dart';
import 'package:bible/ui/widgets/bible_plan_progress_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class BiblePlanHistoryPage extends ConsumerWidget implements StyledRoute<String> {
  final String planId;

  const BiblePlanHistoryPage({super.key, required this.planId});

  @override
  String get path => '/bible-plans/history';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final plan = ref.watch(biblePlansProvider)[planId];
    final planHistory = ref.watch(biblePlanHistoryProvider).getEntriesForPlan(planId);

    return StyledPage(
      title: t.biblePlans.history.toText(),
      backgroundColor: .backgroundPrimary,
      body: StyledListView(
        children: [
          gapH16,
          if (plan != null)
            ...planHistory.sortedBy((_, history) => history.endedAt.value).reversed.mapToIterable((id, history) {
              final progress = history.hydrate(plan);
              final displayName = plan.getDisplayName(planId);
              final endedDate = history.endedAt.toDateTime().formatDate();

              return SafeArea(
                key: ValueKey(id),
                bottom: false,
                child: Padding(
                  padding: .only(left: 16, right: 16, bottom: 16),
                  child: BiblePlanProgressCard(
                    progress: progress,
                    initialDayIndex: progress.lastCompletedDayIndex ?? 0,
                    caption:
                        (progress.isCompleted
                                ? t.biblePlans.finishedOn(date: endedDate)
                                : t.biblePlans.stoppedOn(date: endedDate))
                            .toText(),
                    onNavigateToVerseSelection: ref.read(bibleNavigationServiceProvider).navigateTo,
                    menuItems: [
                      if (!progress.isCompleted)
                        StyledListItem(
                          leading: Symbols.play_circle.toIcon(),
                          title: t.biblePlans.resume.toText(),
                          subtitle: t.biblePlans.resumeDescription.toText(),
                          onPressed: () async {
                            context.pop();
                            if (user.hasStartedPlan(planId)) {
                              final shouldReplace = await context.showStyledDialog(
                                (context) => StyledDialog.confirmOrCancel(
                                  title: t.biblePlans.replacePlanQuestion.toText(),
                                  body: t.biblePlans.replacePlanConfirmation(name: displayName).toText(),
                                  confirmLabel: t.biblePlans.replace.toText(),
                                  cancelLabel: t.common.nevermind.toText(),
                                ),
                              );
                              if (shouldReplace != true || !context.mounted) return;
                            }
                            ref.read(biblePlanHistoryProvider.notifier).resume(id);
                            context.pop(planId);
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
                              onNavigateToVerseSelection: ref.read(bibleNavigationServiceProvider).navigateTo,
                            );
                          },
                        ),
                      StyledListItem(
                        leading: Icon(Symbols.delete, color: context.colors.contentCritical),
                        title: t.common.delete.toText(),
                        subtitle: t.biblePlans.deleteFromHistoryDescription.toText(),
                        onPressed: () async {
                          context.pop();
                          final shouldDelete = await context.showStyledDialog(
                            (context) => StyledDialog.confirmDelete(
                              title: t.biblePlans.deleteFromHistoryQuestion.toText(),
                              body: t.biblePlans.deleteFromHistoryConfirmation(name: displayName).toText(),
                              cancelLabel: t.common.nevermind.toText(),
                            ),
                          );
                          if (shouldDelete != true) return;

                          ref.read(biblePlanHistoryProvider.notifier).delete(id);
                          if (!ref.read(biblePlanHistoryProvider).hasEntriesForPlan(planId) && context.mounted) {
                            context.pop();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
          Builder(builder: (context) => SizedBox(height: MediaQuery.paddingOf(context).bottom)),
        ],
      ),
    );
  }
}
