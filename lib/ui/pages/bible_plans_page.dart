import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/bible_plan_read_page.dart';
import 'package:bible/ui/pages/bible_plan_search_page.dart';
import 'package:bible/ui/widgets/bible_plan_thumbnail.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class BiblePlansPage extends ConsumerWidget {
  const BiblePlansPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final plans = ref.watch(biblePlansProvider);

    return StyledPage(
      title: 'Bible Plans'.toText(),
      backgroundColor: .backgroundPrimary,
      trailing: Tooltip(
        message: 'Add Bible plan',
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
                title: "You aren't following any reading plans yet. Find one to start reading through the Bible."
                    .toText(),
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
                                leading: BiblePlanThumbnail(plan: plan),
                                title: plan.name.toText(),
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
                                                body:
                                                    'Are you sure you want to stop "${plan.name}"? Your progress will be lost.'
                                                        .toText(),
                                                deleteLabel: 'Stop'.toText(),
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
                                        'Day ${dayIndex + 1}',
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
                                          title: 'Review & Reflect'.toText(),
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
                                    label: 'Finish'.toText(),
                                    onPressed: () {
                                      ref.updateUser((user) => user.withCompletedPlan(planType));
                                      context.showStyledSnackbar(
                                        message: '"${plan.name}" completed.'.toText(),
                                        action: StyledTextAction(
                                          label: 'Start New'.toText(),
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
