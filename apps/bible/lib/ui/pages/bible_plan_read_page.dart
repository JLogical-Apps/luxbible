import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/widgets/selection_toolbar.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class BiblePlanReadPage extends HookConsumerWidget {
  final BiblePlanType planType;
  final int dayIndex;
  final int initialPassageIndex;

  const BiblePlanReadPage({
    super.key,
    required this.planType,
    required this.dayIndex,
    required this.initialPassageIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(biblePlansProvider);
    final plan = plans[planType];
    if (plan == null) {
      return SizedBox.shrink();
    }

    final day = plan.days[dayIndex];
    final passages = day.passages;

    final user = ref.watch(userProvider);
    final progress = user.getHydratedPlanProgress(planType: planType, planByType: plans);
    final currentProgress = progress?.progress.days[dayIndex] ?? BiblePlanDayProgress.incomplete();

    final selection = usePassageSelection(ref.watch(luxReaderConfigurationProvider).selection);
    void navigateToVerseSelection(VerseSelection verseSelection) => context.pop(verseSelection);

    final tabController = useTabController(
      initialLength: passages.isEmpty ? 1 : passages.length,
      initialIndex: initialPassageIndex.clamp(0, passages.isEmpty ? 0 : passages.length - 1),
    );
    final currentIndex = useListenableSelector(tabController, () => tabController.index);
    final nextIncompletePassageIndex = currentProgress.getNextIncompletePassageIndex(
      passages: passages,
      currentIndex: currentIndex,
    );

    useValueChanged<int, void>(currentIndex, (oldIndex, _) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        selection.clear();
        ref.updateUser(
          (user) =>
              user.withPassageCompleted(planType: planType, dayIndex: dayIndex, day: day, passage: passages[oldIndex]),
        );
      });
    });

    return StyledPage(
      title: t.biblePlans.day(day: dayIndex + 1).toText(),
      body: StyledDock(
        forceHeight: true,
        activeScrollKey: 'passage',
        children: [
          StyledTabBar.scrollable(
            tabController: tabController,
            tabTitles: passages.map((passage) {
              final isCompleted = currentProgress.isPassageComplete(passage);
              return Row(
                spacing: 8,
                children: [
                  passage.format().toText(),
                  Icon(
                    isCompleted ? Symbols.check_circle : Symbols.circle,
                    fill: isCompleted ? 1 : 0,
                    color: isCompleted ? context.colors.contentPrimary : context.colors.contentSecondary,
                    size: 16,
                  ),
                ],
              );
            }).toList(),
          ),
          Expanded(
            child: SwipeTabView(
              controller: tabController,
              children: passages
                  .map(
                    (passage) => SafeArea(
                      top: false,
                      bottom: false,
                      child: PassageBuilder(
                        verseSelection: passage,
                        selection: selection,
                        onNavigateToVerseSelection: navigateToVerseSelection,
                        contentBuilder: (context, passageContent) => KeyedScrollTransformer(
                          scrollKey: 'passage',
                          child: StyledScrollbar(
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              padding: .symmetric(horizontal: 24, vertical: 16),
                              child: Column(
                                crossAxisAlignment: .start,
                                spacing: 16,
                                children: [
                                  passageContent,
                                  StyledRectButton.secondary(
                                    label:
                                        (passage.isChapter
                                                ? t.biblePlans.readInContext
                                                : t.biblePlans.readEntireChapter)
                                            .toText(),
                                    onPressed: () => PassagePreviewPage.show(
                                      context,
                                      verseSelection: passage,
                                      onNavigateToVerseSelection: (selection) => context.pop(selection),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
        aboveButtons: selection.hasSelection
            ? SelectionToolbar(selection: selection, onNavigateToVerseSelection: navigateToVerseSelection)
            : null,
        buttonsBuilder: (context) => [
          StyledRectButton.primary(
            label: (nextIncompletePassageIndex == null ? t.common.done : t.common.next).toText(),
            onPressed: () {
              ref.updateUser(
                (user) => user.withPassageCompleted(
                  planType: planType,
                  dayIndex: dayIndex,
                  day: day,
                  passage: passages[currentIndex],
                ),
              );
              if (nextIncompletePassageIndex != null) {
                tabController.animateTo(nextIncompletePassageIndex);
              } else {
                context.pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
