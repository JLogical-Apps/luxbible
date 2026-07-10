import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/bible_plan_page.dart';
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
      body: StyledDock(
        shrinkWrap: false,
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
            children: user.getHydratedPlanProgresses(plans).map((progress) {
              final plan = progress.plan;
              final planType = progress.type;
              final currentDayIndex = progress.currentDayIndex;
              final currentDay = progress.plan.days[currentDayIndex];
              final isCompleted = progress.isCompleted;

              return Padding(
                key: ValueKey(progress.type),
                padding: .only(left: 16, right: 16, bottom: 16),
                child: StyledCard.child(
                  child: StyledExpandablePanel(
                    leading: BiblePlanThumbnail(plan: plan),
                    title: plan.name.toText(),
                    subtitle: (isCompleted ? 'Completed' : 'Day ${currentDayIndex + 1} of ${plan.dayCount}').toText(),
                    isInitiallyExpanded: progress.progress.isExpanded,
                    onExpandedChanged: (isExpanded) =>
                        ref.updateUser((user) => user.withPlanExpanded(planType, isExpanded)),
                    onHeaderPressed: () async {
                      final result = await context.push<VerseSelection>(BiblePlanPage(planType: planType));
                      if (result != null && context.mounted) context.pop(result);
                    },
                    children: currentDay.passages
                        .mapIndexed(
                          (passageIndex, passage) => StyledListItem(
                            title: passage.format().toText(),
                            onPressed: () async {
                              final result = await context.push<VerseSelection>(
                                BiblePlanReadPage(
                                  planType: planType,
                                  dayIndex: currentDayIndex,
                                  initialPassageIndex: passageIndex,
                                ),
                              );
                              if (result != null && context.mounted) context.pop(result);
                            },
                            trailing: StyledCheckbox(
                              isSelected: progress.isPassageComplete(dayIndex: currentDayIndex, passage: passage),
                              onChanged: (_) => ref.updateUser(
                                (user) => user.withPassageToggled(
                                  planType: planType,
                                  dayIndex: currentDayIndex,
                                  passage: passage,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
        buttonsBuilder: (context) => [
          StyledRectButton.primary(label: 'Find Plans'.toText(), onPressed: () => context.push(BiblePlanSearchPage())),
        ],
      ),
    );
  }
}
