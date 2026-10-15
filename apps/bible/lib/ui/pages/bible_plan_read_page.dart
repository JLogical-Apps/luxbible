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
import 'package:bible/ui/hooks/audio_bible_passage_sync.dart';
import 'package:bible/ui/hooks/reader_bottom_bar_visibility.dart';
import 'package:bible/ui/hooks/study_panel_carousel.dart';
import 'package:bible/ui/pages/bible_plans_page.dart';
import 'package:bible/ui/sheets/main_actions_sheet.dart';
import 'package:bible/ui/widgets/audio_bible_panel.dart';
import 'package:bible/ui/widgets/main_toolbar.dart';
import 'package:bible/ui/widgets/reader_bottom_bar.dart';
import 'package:bible/ui/widgets/selection_toolbar.dart';
import 'package:bible/ui/widgets/side_layout_scope.dart';
import 'package:bible/ui/widgets/study_panel_layout.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
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
  final int initialPassageIndex;

  const BiblePlanReadPage({super.key, required this.planId, required this.dayIndex, required this.initialPassageIndex});

  @override
  String get path => '/bible-plans/read';

  List<StyledRoute<dynamic>> get pageStack => [
    BiblePlansPage(),
    BiblePlanReadPage(planId: planId, dayIndex: dayIndex, initialPassageIndex: initialPassageIndex),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(biblePlansProvider);
    final plan = plans[planId];
    if (plan == null || dayIndex < 0 || dayIndex >= plan.days.length || plan.days[dayIndex].passages.isEmpty) {
      return SizedBox.shrink();
    }

    final day = plan.days[dayIndex];
    final passages = day.passages;

    final user = ref.watch(userProvider);
    final readerConfiguration = ref.watch(luxReaderConfigurationProvider);
    final progress = user.getHydratedPlanProgress(planId: planId, planById: plans);
    final currentProgress = progress?.progress.days.elementAtOrNull(dayIndex) ?? BiblePlanDayProgress.incomplete();

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
      initialLength: passages.length,
      initialIndex: initialPassageIndex.clamp(0, passages.length - 1),
    );
    final currentIndex = useListenableSelector(tabController, () => tabController.index);
    final currentPassage = passages[currentIndex];
    final nextIncompletePassageIndex = user.getNextIncompletePlanPassageIndex(
      planId: planId,
      dayIndex: dayIndex,
      day: day,
      currentIndex: currentIndex,
    );

    final passageControllerRegistry = useRegistry<VerseSelection, PassageController>();
    final currentPassageController = passageControllerRegistry[currentPassage];
    final readPassages = useMemoized(() => <VerseSelection>{});
    final passageAreaKey = useMemoized(() => GlobalKey());

    void playPassage(int passageIndex) async {
      final passage = passages[passageIndex];
      final translation = user.getTranslationFor(passage.references.first.book);
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
        final passageIndex = passages.indexOfOrNull(passage);
        if (passageIndex != null && passageIndex != tabController.index) {
          tabController.animateTo(passageIndex);
        }
      },
      onCompleteAndNext: (completedPassage) {
        final newUser = ref.updateUser(
          (user) => user.withPassageCompleted(planId: planId, dayIndex: dayIndex, day: day, passage: completedPassage),
        );

        final completedPassageIndex = passages.indexOfOrNull(completedPassage);
        final nextIndex = completedPassageIndex == null
            ? null
            : newUser.getNextIncompletePlanPassageIndex(
                planId: planId,
                dayIndex: dayIndex,
                day: day,
                currentIndex: completedPassageIndex,
              );

        return nextIndex == null ? null : passages[nextIndex];
      },
      removeOnDispose: true,
    );

    final bottomBarVisibility = useReaderBottomBarVisibility(
      scrollController: currentPassageController?.scrollController,
      isPinned: user.mainToolbar.pinToBottom,
      hasSelection: selectionController.hasSelection,
      keys: [currentIndex],
    );

    useWhenValueChanged(currentIndex, (oldIndex, currentIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        bottomBarVisibility.show();
        selectionController.clear();
        final session = ref.read(audioBibleProvider(context: .plan));
        if (session != null && session.passage != passages[currentIndex]) {
          await audioBibleController.pause(context: .plan);
          await audioBibleController.replacePassage(context: .plan, passage: passages[currentIndex]);
        }
        final oldPassage = passages[oldIndex];
        if (readPassages.contains(oldPassage)) {
          ref.updateUser(
            (user) => user.withPassageCompleted(planId: planId, dayIndex: dayIndex, day: day, passage: oldPassage),
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

    final currentTranslation = user.getTranslationFor(currentPassage.references.first.book);

    Future<List<Paragraph>> getCurrentParagraphs() =>
        ref.read(verseSelectionParagraphsProvider(selection: currentPassage, translation: currentTranslation).future);

    void scrollMainToReference(Reference reference) async {
      final paragraphs = await getCurrentParagraphs();
      if (!context.mounted) return;
      final sizeMultiplier = readerConfiguration.paragraphsConfiguration(context, currentTranslation).sizeMultiplier;
      final sectionHeight = paragraphs.getSectionTypeForVerse(reference.verseNum)?.getHeight(sizeMultiplier) ?? 0;
      currentPassageController?.scrollToReference(
        reference,
        paragraphs: paragraphs,
        alignment: sectionHeight / (passageAreaKey.renderBox?.size.height ?? 128),
      );
    }

    void addStudyPanel(StudyPanel studyPanel) async {
      final verseSelection = selectionController.verseSelection;
      studyPanelCarousel.addStudyPanel(studyPanel);
      selectionController.clear();
      if (verseSelection != null) {
        final paragraphs = await getCurrentParagraphs();
        await Future.delayed(Duration(milliseconds: 200));
        currentPassageController?.scrollToReference(
          verseSelection.references.first,
          paragraphs: paragraphs,
          alignment: 0.2,
          duration: Duration(milliseconds: 500),
        );
      }
    }

    void completePassageAndContinue() {
      ref.updateUser(
        (user) => user.withPassageCompleted(planId: planId, dayIndex: dayIndex, day: day, passage: currentPassage),
      );

      if (nextIncompletePassageIndex != null) {
        tabController.animateTo(nextIncompletePassageIndex);
      } else {
        context.pop();
      }
    }

    void onMainActionPressed(MainAction action) async {
      switch (action) {
        case .audio:
          if (planAudioPlayer.isPlaying) {
            await audioBibleController.pause(context: .plan);
          } else {
            playPassage(currentIndex);
          }
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
            reference: currentPassage.references.first.toChapterReference(),
            onNavigateToVerseSelection: navigateToVerseSelection,
            onAddStudyPanel: addStudyPanel,
            onBookmarkAdded: (_) {},
          );
      }
    }

    void onShortcutPressed(MainToolbarShortcut shortcut) {
      if (shortcut.toMainAction() case final action?) {
        onMainActionPressed(action);
      } else {
        shortcut.onPressed(
          context,
          reference: currentPassage.references.first.toChapterReference(),
          onNavigateToVerseSelection: navigateToVerseSelection,
          onAddStudyPanel: addStudyPanel,
          onBookmarkAdded: (_) {},
        );
      }
    }

    final bookTitle = currentPassage.references.first.book.title();

    return StyledPage(
      backgroundColor: .backgroundPrimary,
      title: t.biblePlans.day(day: dayIndex + 1).toText(),
      body: StudyPanelLayout(
        carousel: studyPanelCarousel,
        isSideLayout: isSideLayout,
        passage: currentPassage,
        passageController: currentPassageController,
        selectionController: selectionController,
        getViewportTop: () => passageAreaKey.globalBounds?.top ?? 0,
        onScrollMainToReference: scrollMainToReference,
        onNavigateToVerseSelection: navigateToVerseSelection,
        child: Column(
          children: [
            ColoredBox(
              color: context.colors.surfacePrimary,
              child: StyledTabBar.scrollable(
                tabController: tabController,
                onTabPressed: (index) {
                  if (index != currentIndex) return;
                  ref.updateUser(
                    (user) =>
                        user.withPassageToggled(planId: planId, dayIndex: dayIndex, day: day, passage: passages[index]),
                  );
                },
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
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: KeyedSubtree(
                      key: passageAreaKey,
                      child: SwipeTabView(
                        controller: tabController,
                        children: passages
                            .map(
                              (passage) => HookBuilder(
                                builder: (context) {
                                  final chapterReference = passage.references.first.toChapterReference();
                                  final passageController = usePassageController(chapterReference);
                                  useRegistryItem(passageControllerRegistry, passage, passageController);

                                  final listController = passageController.listController;
                                  useOnListenableChange(listController, () {
                                    if (listController.isAttached &&
                                        listController.visibleRange?.$2 == listController.numberOfItems - 1) {
                                      readPassages.add(passage);
                                    }
                                  });

                                  return SafeArea(
                                    top: false,
                                    bottom: false,
                                    right: !isSideLayout || !studyPanelCarousel.hasPanels,
                                    child: PassageBuilder(
                                      verseSelection: passage,
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
                                    ),
                                  );
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  ReaderBottomBar(
                    isToolbarVisible: bottomBarVisibility.isVisible,
                    hasStudyPanels: studyPanelCarousel.hasPanels,
                    isSideLayout: isSideLayout,
                    toolbar: MainToolbar(
                      bookTitle: bookTitle,
                      location: currentPassage.format().replaceFirst('$bookTitle\u{00A0}', ''),
                      mainToolbar: user.mainToolbar,
                      translation: currentTranslation,
                      user: user,
                      audioContext: .plan,
                      leading: StyledCircleButton.sm(
                        colorBuilder: .primary,
                        child: Icon(nextIncompletePassageIndex == null ? Symbols.check : Symbols.arrow_forward),
                        onPressed: completePassageAndContinue,
                      ),
                      onPressed: () => onShortcutPressed(.switchBible),
                      onShorcutPressed: (_, shortcut) => onShortcutPressed(shortcut),
                      onMorePressed: () async {
                        final action = await MainActionsSheet.show(context, audioContext: .plan);
                        if (action != null && context.mounted) {
                          onMainActionPressed(action);
                        }
                      },
                    ),
                    selectionToolbar: selectionController.hasSelection
                        ? SelectionToolbar(
                            selectionController: selectionController,
                            onNavigateToVerseSelection: navigateToVerseSelection,
                            onAddStudyPanel: addStudyPanel,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
