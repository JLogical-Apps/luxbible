import 'package:bible/models/bible_plan.dart';
import 'package:bible/models/main_action.dart';
import 'package:bible/models/study_panel.dart';
import 'package:bible/models/user/main_toolbar_shortcut.dart';
import 'package:bible/providers/audio_bible_player_provider.dart';
import 'package:bible/providers/audio_bible_provider.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/providers/viewed_bible_plan_day_provider.dart';
import 'package:bible/services/analytics_service.dart';
import 'package:bible/ui/flows/bible_plan_reflection_flow.dart';
import 'package:bible/ui/hooks/audio_bible_passage_sync.dart';
import 'package:bible/ui/hooks/reader_bottom_bar_visibility.dart';
import 'package:bible/ui/hooks/study_panel_carousel.dart';
import 'package:bible/ui/pages/bible_plans_page.dart';
import 'package:bible/ui/sheets/main_actions_sheet.dart';
import 'package:bible/ui/widgets/audio_bible_panel.dart';
import 'package:bible/ui/widgets/bible_plan_reflection_view.dart';
import 'package:bible/ui/widgets/bible_plan_study_notes_view.dart';
import 'package:bible/ui/widgets/main_toolbar.dart';
import 'package:bible/ui/widgets/reader_bottom_bar.dart';
import 'package:bible/ui/widgets/selection_toolbar.dart';
import 'package:bible/ui/widgets/side_layout_scope.dart';
import 'package:bible/ui/widgets/study_panel_layout.dart';
import 'package:bible/ui/widgets/titled_toolbar.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class BiblePlanReadPage extends HookConsumerWidget implements StyledRoute<VerseSelection> {
  final String planId;
  final int dayIndex;
  final int initialItemIndex;

  const BiblePlanReadPage({super.key, required this.planId, required this.dayIndex, required this.initialItemIndex});

  @override
  String get path => '/bible-plans/read';

  List<StyledRoute<dynamic>> get pageStack => [
    BiblePlansPage(),
    BiblePlanReadPage(planId: planId, dayIndex: dayIndex, initialItemIndex: initialItemIndex),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(biblePlansProvider);
    final plan = plans[planId];
    if (plan == null || dayIndex < 0 || dayIndex >= plan.days.length) {
      return SizedBox.shrink();
    }

    final day = plan.days[dayIndex];
    final passages = day.passages;

    final user = ref.watch(userProvider);
    final progress = user.getHydratedPlanProgress(planId: planId, planById: plans);
    // Kept for the visit, so skipping every reflection from the reflection tab doesn't pull the tab out from under it.
    final items = useMemoized(() => progress?.getDayItems(dayIndex) ?? day.getItems(includesReflection: false));
    if (items.isEmpty) {
      return SizedBox.shrink();
    }

    final readerConfiguration = ref.watch(luxReaderConfigurationProvider);
    final currentProgress = user.getPlanDayProgress(planId: planId, dayIndex: dayIndex);

    final planDay = progress?.getDayId(dayIndex);
    useEffect(() {
      if (planDay == null) return null;
      final viewedPlanDayNotifier = ref.read(viewedBiblePlanDayProvider.notifier);
      WidgetsBinding.instance.addPostFrameCallback((_) => viewedPlanDayNotifier.view(planDay));
      return () => WidgetsBinding.instance.addPostFrameCallback((_) => viewedPlanDayNotifier.leave(planDay));
    }, [planDay]);

    final isSideLayout = SideLayoutScope.isSideLayoutOf(context);
    final selectionController = usePassageSelectionController(readerConfiguration.selection);

    final planAudio = ref.watch(audioBibleProvider(context: .plan));
    final planAudioPlayer = ref.watch(audioBiblePlayerProvider(context: .plan));
    final audioBibleController = ref.read(audioBibleControllerProvider.notifier);

    void navigateToVerseSelection(VerseSelection verseSelection) => context.pop(verseSelection);

    final tabController = useTabController(
      initialLength: items.length,
      initialIndex: initialItemIndex.clamp(0, items.length - 1),
    );
    final currentIndex = useListenableSelector(tabController, () => tabController.index);
    final currentItem = items[currentIndex];
    // Study notes and reflection tabs come after the passages, so they keep the last passage for study panels.
    final currentPassage = switch (currentItem) {
      BiblePlanPassageItem(:final passage) => passage,
      BiblePlanDayStep() => passages.lastOrNull,
    };
    final nextIncompleteItemIndex = currentProgress.getNextIncompleteItemIndex(
      items: items,
      currentIndex: currentIndex,
    );

    final passageControllerRegistry = useRegistry<ChapterPassage, PassageController>();
    final currentPassageController = currentItem is BiblePlanPassageItem
        ? passageControllerRegistry[currentItem.passage]
        : null;
    final studyNotesScrollController = useScrollController();
    final readItems = useMemoized(() => <BiblePlanDayItem>{});
    final passageAreaKey = useMemoized(() => GlobalKey());

    void playPassage(ChapterPassage passage) async {
      final translation = user.getTranslationFor(passage.chapter.book);
      if (!translation.hasAudioBible) {
        audioBibleController.remove(context: .plan);

        final shouldContinue = await context.showStyledDialog(
          (_) => StyledDialog(
            title: t.audio.unavailable.toText(),
            body: t.audio.switchRequired.toText(),
            buttonsBuilder: (buttonContext) => [
              StyledRectButton.secondary(
                label: t.common.switchTo(translation: user.audioTranslation.title()).toText(),
                onPressed: () {
                  buttonContext.pop(true);
                  ref.updateUser((user) => user.withTranslation(user.audioTranslation));
                },
              ),
              StyledRectButton.primary(label: t.common.ok.toText(), onPressed: () => buttonContext.pop(false)),
            ],
          ),
        );

        if (shouldContinue != true) {
          return;
        }
      }

      selectionController.clear();
      if (await audioBibleController.play(context: .plan, passage: passage)) {
        AnalyticsEvent.audioPlayed.log();
      }
    }

    final audioBibleSync = useAudioBiblePassageSync(
      ref: ref,
      context: .plan,
      audioBible: planAudio,
      selection: selectionController,
      passageControllers: passageControllerRegistry,
      getPassageControllerKey: (passage) => passage,
      onPassageChanged: (passage) {
        final passageIndex = items.indexOfOrNull(BiblePlanPassageItem(passage));
        if (passageIndex != null && passageIndex != tabController.index) {
          tabController.animateTo(passageIndex);
        }
      },
      onCompleteAndNext: (completedPassage) {
        final completedItem = BiblePlanPassageItem(completedPassage);
        final newUser = ref.updateUser(
          (user) => user.withPlanItemCompleted(planId: planId, dayIndex: dayIndex, day: day, item: completedItem),
        );

        final completedIndex = items.indexOfOrNull(completedItem);
        final nextIndex = completedIndex == null
            ? null
            : newUser
                  .getPlanDayProgress(planId: planId, dayIndex: dayIndex)
                  .getNextIncompleteItemIndex(items: items, currentIndex: completedIndex);

        // Audio only reads passages, so it stops before the study notes and reflection.
        return switch (nextIndex == null ? null : items[nextIndex]) {
          BiblePlanPassageItem(:final passage) => passage,
          _ => null,
        };
      },
      removeOnDispose: true,
    );

    final bottomBarVisibility = useReaderBottomBarVisibility(
      scrollController: switch (currentItem) {
        BiblePlanPassageItem() => currentPassageController?.scrollController,
        BiblePlanDayStep.studyNotes => studyNotesScrollController,
        BiblePlanDayStep.reflection => null,
      },
      isPinned: user.mainToolbar.pinToBottom,
      hasSelection: selectionController.hasSelection,
      keys: [currentIndex],
    );

    useWhenValueChanged(currentIndex, (oldIndex, currentIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        bottomBarVisibility.show();
        selectionController.clear();
        final session = ref.read(audioBibleProvider(context: .plan));
        if (session != null) {
          if (items[currentIndex] case BiblePlanPassageItem(:final passage) when session.passage != passage) {
            await audioBibleController.pause(context: .plan);
            await audioBibleController.replacePassage(context: .plan, passage: passage);
          } else if (items[currentIndex] is BiblePlanDayStep) {
            await audioBibleController.pause(context: .plan);
          }
        }
        final oldItem = items[oldIndex];
        if (readItems.contains(oldItem)) {
          ref.updateUser(
            (user) => user.withPlanItemCompleted(planId: planId, dayIndex: dayIndex, day: day, item: oldItem),
          );
        }
      });
    });

    final studyPanelCarousel = useStudyPanelCarousel(
      ref: ref,
      isSideLayout: isSideLayout,
      trailingPanelBuilder: planAudio == null
          ? null
          : (showDragHandle) => AudioBiblePanel(context: .plan, showDragHandle: showDragHandle),
    );

    Future<List<Paragraph>> getParagraphs(ChapterPassage passage) => ref.read(
      verseSelectionParagraphsProvider(
        selection: passage.verseSelection,
        translation: user.getTranslationFor(passage.chapter.book),
      ).future,
    );

    void scrollMainToReference(ChapterPassage passage, Reference reference) async {
      final paragraphs = await getParagraphs(passage);
      if (!context.mounted) return;
      final sizeMultiplier = readerConfiguration
          .paragraphsConfiguration(context, user.getTranslationFor(passage.chapter.book))
          .sizeMultiplier;
      final sectionHeight = paragraphs.getSectionTypeForVerse(reference.verseNum)?.getHeight(sizeMultiplier) ?? 0;
      currentPassageController?.scrollToReference(
        reference,
        paragraphs: paragraphs,
        alignment: sectionHeight / (passageAreaKey.renderBox?.size.height ?? 128),
      );
    }

    void addStudyPanel(ChapterPassage passage, StudyPanel studyPanel) async {
      final verseSelection = selectionController.verseSelection;
      studyPanelCarousel.addStudyPanel(studyPanel);
      selectionController.clear();
      if (verseSelection != null) {
        final paragraphs = await getParagraphs(passage);
        await Future.delayed(Duration(milliseconds: 200));
        currentPassageController?.scrollToReference(
          verseSelection.start,
          paragraphs: paragraphs,
          alignment: 0.2,
          duration: Duration(milliseconds: 500),
        );
      }
    }

    final reflectionAnswer = progress?.progress.getReflectionAnswer(dayIndex) ?? '';

    void completeItemAndContinue() async {
      if (currentItem == BiblePlanDayStep.reflection) {
        await BiblePlanReflectionFlow.complete(context: context, planId: planId, dayIndex: dayIndex);
      } else {
        ref.updateUser(
          (user) => user.withPlanItemCompleted(planId: planId, dayIndex: dayIndex, day: day, item: currentItem),
        );
      }
      if (!context.mounted) return;

      if (nextIncompleteItemIndex != null) {
        tabController.animateTo(nextIncompleteItemIndex);
      } else {
        context.pop();
      }
    }

    void onMainActionPressed(ChapterPassage passage, MainAction action) async {
      switch (action) {
        case .audio:
          if (planAudioPlayer.isPlaying) {
            await audioBibleController.pause(context: .plan);
          } else {
            playPassage(passage);
          }
        case .bookmark:
          await context.showStyledDialog(
            (_) => StyledDialog.confirm(
              title: t.biblePlans.unavailableWhileReadingTitle.toText(),
              body: t.biblePlans.bookmarkUnavailableWhileReading.toText(),
            ),
          );
        case .plans:
          await context.showStyledDialog(
            (_) => StyledDialog.confirm(
              title: t.biblePlans.unavailableWhileReadingTitle.toText(),
              body: t.biblePlans.unavailableWhileReading.toText(),
            ),
          );
        default:
          await action.onPressed(
            context,
            passage: passage,
            onNavigateToVerseSelection: navigateToVerseSelection,
            onAddStudyPanel: (studyPanel) => addStudyPanel(passage, studyPanel),
            onBookmarkAdded: (_) {},
          );
      }
    }

    void onShortcutPressed(ChapterPassage passage, MainToolbarShortcut shortcut) {
      if (shortcut.toMainAction() case final action?) {
        onMainActionPressed(passage, action);
      } else {
        shortcut.onPressed(
          context,
          passage: passage,
          onNavigateToVerseSelection: navigateToVerseSelection,
          onAddStudyPanel: (studyPanel) => addStudyPanel(passage, studyPanel),
          onBookmarkAdded: (_) {},
        );
      }
    }

    final nextOrDoneButton = StyledCircleButton.sm(
      colorBuilder: .primary,
      child: Icon(nextIncompleteItemIndex == null ? Symbols.check : Symbols.arrow_forward),
      onPressed: completeItemAndContinue,
    );

    final content = Column(
      children: [
        ColoredBox(
          color: context.colors.surfacePrimary,
          child: StyledTabBar.scrollable(
            tabController: tabController,
            onTabPressed: (index) {
              if (index != currentIndex) return;
              if (items[index] == BiblePlanDayStep.reflection && !currentProgress.isItemComplete(items[index])) {
                BiblePlanReflectionFlow.complete(context: context, planId: planId, dayIndex: dayIndex);
                return;
              }
              ref.updateUser(
                (user) => user.withPlanItemToggled(planId: planId, dayIndex: dayIndex, day: day, item: items[index]),
              );
            },
            tabTitles: items.map((item) {
              final isCompleted = currentProgress.isItemComplete(item);
              return Row(
                spacing: 8,
                children: [
                  item.title().toText(),
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
        ),
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: KeyedSubtree(
                  key: passageAreaKey,
                  child: SwipeTabView(
                    controller: tabController,
                    children: items
                        .map(
                          (item) => switch (item) {
                            BiblePlanPassageItem(:final passage) => HookBuilder(
                              builder: (context) {
                                final passageController = usePassageController(passage.chapter);
                                useRegistryItem(passageControllerRegistry, passage, passageController);

                                final listController = passageController.listController;
                                useOnListenableChange(listController, () {
                                  if (listController.isAttached &&
                                      listController.visibleRange?.$2 == listController.numberOfItems - 1) {
                                    readItems.add(item);
                                  }
                                });

                                return SafeArea(
                                  top: false,
                                  bottom: false,
                                  right: !isSideLayout || !studyPanelCarousel.hasPanels,
                                  child: PassageBuilder(
                                    verseSelection: passage.verseSelection,
                                    selection: selectionController,
                                    emphasizedReference: audioBibleSync.getEmphasizedReferenceForPassage(passage),
                                    controller: passageController,
                                    onNavigateToVerseSelection: navigateToVerseSelection,
                                    padding: .only(
                                      left: 24,
                                      top: 16,
                                      right: 24,
                                      bottom: MediaQuery.viewPaddingOf(context).bottom + 96,
                                    ),
                                    showLoading: false,
                                    contentBuilder: (context, passageContent) =>
                                        NotificationListener<ScrollStartNotification>(
                                          onNotification: (notification) {
                                            if (notification.dragDetails != null && planAudioPlayer.isPlaying) {
                                              audioBibleController.pause(context: .plan);
                                            }
                                            return false;
                                          },
                                          child: passageContent,
                                        ),
                                    footer: StyledRectButton.secondary(
                                      label:
                                          (passage.isWholeChapter
                                                  ? t.biblePlans.readInContext
                                                  : t.biblePlans.readEntireChapter)
                                              .toText(),
                                      onPressed: () => PassagePreviewPage.show(
                                        context,
                                        verseSelection: passage.verseSelection,
                                        onNavigateToVerseSelection: (selection) => context.pop(selection),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            BiblePlanDayStep.studyNotes => BiblePlanStudyNotesView(
                              title: day.title,
                              content: day.studyNotesContent,
                              // Follows the Bible text size setting so the notes read at the same scale.
                              sizeMultiplier: user.themeLayout
                                  .getFontSizeSpacingOrSystem(context.textScaling)
                                  .multiplier,
                              scrollController: studyNotesScrollController,
                              onReadToEnd: () => readItems.add(item),
                              onNavigateToVerseSelection: navigateToVerseSelection,
                            ),
                            BiblePlanDayStep.reflection => switch (day.reflectionQuestion) {
                              final question? => BiblePlanReflectionView(
                                question: question,
                                answer: reflectionAnswer,
                                // Others are only discussing it on Discord while the plan's season is underway.
                                hasDiscussion: BiblePlanType.getById(planId)?.season?.isActiveOn(.now()) ?? false,
                                onAnswerChanged: (answer) => ref.updateUser(
                                  (user) =>
                                      user.withPlanReflectionAnswer(planId: planId, dayIndex: dayIndex, answer: answer),
                                ),
                              ),
                              null => SizedBox.shrink(),
                            },
                          },
                        )
                        .toList(),
                  ),
                ),
              ),
              ReaderBottomBar(
                isToolbarVisible: bottomBarVisibility.isVisible,
                hasStudyPanels: currentPassage != null && studyPanelCarousel.hasPanels,
                isSideLayout: isSideLayout,
                toolbar: switch (currentItem) {
                  BiblePlanDayStep() => TitledToolbar(leading: nextOrDoneButton, title: currentItem.title()),
                  BiblePlanPassageItem(:final passage) => MainToolbar(
                    bookTitle: passage.chapter.book.title(),
                    location: passage.format().replaceFirst('${passage.chapter.book.title()}\u{00A0}', ''),
                    mainToolbar: user.mainToolbar,
                    translation: user.getTranslationFor(passage.chapter.book),
                    user: user,
                    audioContext: .plan,
                    leading: nextOrDoneButton,
                    onPressed: () => onShortcutPressed(passage, .switchBible),
                    onShorcutPressed: (_, shortcut) => onShortcutPressed(passage, shortcut),
                    onMorePressed: () async {
                      final action = await MainActionsSheet.show(
                        context,
                        audioContext: .plan,
                        hiddenActions: {.verseOfTheDay, .bookmark, .plans},
                      );
                      if (action != null && context.mounted) {
                        onMainActionPressed(passage, action);
                      }
                    },
                  ),
                },
                selectionToolbar: switch (currentItem) {
                  BiblePlanPassageItem(:final passage) when selectionController.hasSelection => SelectionToolbar(
                    selectionController: selectionController,
                    onNavigateToVerseSelection: navigateToVerseSelection,
                    onAddStudyPanel: (studyPanel) => addStudyPanel(passage, studyPanel),
                  ),
                  _ => null,
                },
              ),
            ],
          ),
        ),
      ],
    );

    return StyledPage(
      backgroundColor: .backgroundPrimary,
      title: t.biblePlans.day(day: dayIndex + 1).toText(),
      // A day without passages has no verses to study, so it leaves out the study panels.
      body: switch (currentPassage) {
        final passage? => StudyPanelLayout(
          carousel: studyPanelCarousel,
          isSideLayout: isSideLayout,
          passage: passage,
          passageController: currentPassageController,
          selectionController: selectionController,
          getViewportTop: () => passageAreaKey.globalBounds?.top ?? 0,
          onScrollMainToReference: (reference) => scrollMainToReference(passage, reference),
          onNavigateToVerseSelection: navigateToVerseSelection,
          child: content,
        ),
        null => content,
      },
    );
  }
}
