import 'package:bible/models/bible_plan.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/keyed_scroll_transformer.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/chapter_preview_page.dart';
import 'package:bible/ui/widgets/bible_selection.dart';
import 'package:bible/ui/widgets/paragraphs_builder.dart';
import 'package:bible/ui/widgets/selection_toolbar.dart';
import 'package:bible/ui/widgets/swipe_tab_view.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

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

    final selection = useBibleSelection();
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
      title: 'Day ${dayIndex + 1}'.toText(),
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
              children: passages.map((passage) {
                final chapterReference = passage.references.first.toChapterReference();
                final translation = user.translation.effectiveFor(chapterReference.book);

                final paragraphs = ref
                    .watch(verseSelectionParagraphsProvider(selection: passage, translation: translation))
                    .value;

                return KeyedScrollTransformer(
                  scrollKey: 'passage',
                  child: AnimatedOpacity(
                    opacity: paragraphs == null ? 0 : 1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    child: StyledScrollbar(
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: .symmetric(horizontal: 24, vertical: 16),
                        child: Column(
                          crossAxisAlignment: .start,
                          spacing: 16,
                          children: [
                            ParagraphsBuilder(
                              paragraphs: paragraphs ?? [],
                              chapterReference: chapterReference,
                              user: user,
                              translation: translation,
                              selection: selection,
                              onNavigateToVerseSelection: navigateToVerseSelection,
                            ),
                            StyledRectButton.secondary(
                              label: 'Read entire chapter'.toText(),
                              onPressed: () => ChapterPreviewPage.show(
                                context,
                                verseSelection: passage,
                                onNavigateToPassage: () => context.pop(passage),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
        aboveButtons: selection.hasSelection
            ? SelectionToolbar(selection: selection, onNavigateToVerseSelection: navigateToVerseSelection)
            : null,
        buttonsBuilder: (context) => [
          StyledRectButton.primary(
            label: (nextIncompletePassageIndex == null ? 'Done' : 'Next').toText(),
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
