import 'package:bible/models/main_action.dart';
import 'package:bible/models/study_panel.dart';
import 'package:bible/models/user/onboarding_step.dart';
import 'package:bible/providers/app_bible_provider.dart';
import 'package:bible/providers/audio_bible_player_provider.dart';
import 'package:bible/providers/audio_bible_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/hooks/audio_bible_passage_sync.dart';
import 'package:bible/ui/pages/main_toolbar_settings_page.dart';
import 'package:bible/ui/pages/reference_search_page.dart';
import 'package:bible/ui/widgets/audio_bible_panel.dart';
import 'package:bible/ui/widgets/linked_study_panel.dart';
import 'package:bible/ui/widgets/main_toolbar.dart';
import 'package:bible/ui/widgets/onboarding_panel.dart';
import 'package:bible/ui/widgets/selection_toolbar.dart';
import 'package:bible/ui/widgets/visible_verse_utils.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

const topBarHeight = 30.0;

class BibleBody extends HookConsumerWidget {
  const BibleBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final readerConfiguration = ref.watch(luxReaderConfigurationProvider);

    final initialPosition = user.lastPosition;

    final isSideLayout = MediaQuery.sizeOf(context).width - MediaQuery.viewPaddingOf(context).horizontal >= 700;

    final pageController = usePageController(
      initialPage: initialPosition.reference.bibleChapterIndex,
      keys: [isSideLayout],
    );

    final currentPage = (pageController.pageOrNull ?? initialPosition.reference.bibleChapterIndex).round();
    final currentChapterReference = ChapterReference.fromBibleChapterIndex(currentPage);

    final selection = usePassageSelection(readerConfiguration.selection);

    final audioBible = ref.watch(audioBibleProvider(context: .bible));
    final audioBiblePlayer = ref.watch(audioBiblePlayerProvider(context: .bible));
    final audioBibleController = ref.read(audioBibleControllerProvider.notifier);
    final isAudioBiblePlaying = audioBiblePlayer.isPlaying;

    final navigationHistoryState = useState(
      NavigationHistory(
        current: NavigationState(position: initialPosition, bookmarkId: user.currentBookmarkId),
      ),
    );

    final passageKey = useMemoized(() => GlobalKey());
    final positionByReferenceRef = useRef({initialPosition.reference: initialPosition});

    final passageControllerRegistry = useRegistry<ChapterReference, PassageController>();

    final audioBibleSync = useAudioBiblePassageSync(
      ref: ref,
      context: .bible,
      audioBible: audioBible,
      selection: selection,
      passageControllers: passageControllerRegistry,
      getPassageControllerKey: (passage) => passage.references.first.toChapterReference(),
      onPassageChanged: (passage) {
        final chapterReference = passage.references.first.toChapterReference();
        if (chapterReference != user.lastReference) {
          final position =
              positionByReferenceRef.value[chapterReference] ??
              ChapterPosition(reference: chapterReference, verseNum: 1);
          ref.updateUser((user) => user.withSoftNavigation(position));
        }
      },
      onCompleteAndNext: (passage) {
        final nextChapter = passage.references.first.toChapterReference().next;
        if (nextChapter != null) {
          positionByReferenceRef.value[nextChapter] = ChapterPosition(reference: nextChapter, verseNum: 1);
        }
        return nextChapter?.toVerseSelection();
      },
    );

    final currentAudioTranslation = user.getTranslationFor(user.lastReference.book);
    usePostFrameEffect(() {
      final session = ref.read(audioBibleProvider(context: .bible));
      final passage = user.lastReference.toVerseSelection();
      if (session != null && (session.translation != currentAudioTranslation || session.passage != passage)) {
        audioBibleController.replacePassage(context: .bible, passage: passage);
      }
    }, [user.lastReference, currentAudioTranslation]);

    final currentPassageController = passageControllerRegistry[currentChapterReference];
    final currentScrollController = currentPassageController?.scrollController;

    final currentControllerPassthrough = usePassthrough(currentPassageController);

    final keyByReference = currentPassageController?.keyByReference ?? {};

    void saveScroll() {
      final topReference = getVisibleReferencesInViewport(
        keyByReference: keyByReference,
        viewportTop: MediaQuery.paddingOf(context).top + topBarHeight,
        viewportBottom: MediaQuery.sizeOf(context).height - MediaQuery.paddingOf(context).bottom,
      ).firstOrNull;

      final viewportBounds = passageKey.globalBounds;
      if (viewportBounds == null || topReference == null) {
        return;
      }

      final position = ChapterPosition(reference: currentChapterReference, verseNum: topReference.verseNum);
      if (user.lastPosition == position) {
        return;
      }

      positionByReferenceRef.value[currentChapterReference] = position;
      navigationHistoryState.value = navigationHistoryState.value.withScrollPosition(position);
      ref.updateUser((user) => user.withScrollVerse(position.verseNum ?? 0));
    }

    usePeriodic(Duration(seconds: 5), () => saveScroll());

    void softNavigateTo(ChapterReference reference) {
      saveScroll();

      final position = positionByReferenceRef.value[reference] ?? ChapterPosition(reference: reference);

      ref.updateUser((user) => user.withSoftNavigation(position));
      ref.markOnboardingStep(.swipeChapter);
      navigationHistoryState.value = navigationHistoryState.value.withCurrent(
        NavigationState(position: position, bookmarkId: user.currentBookmarkId),
      );
    }

    void hardNavigateTo(ChapterPosition position, {String? bookmarkId, bool updateNavigationState = true}) {
      saveScroll();
      positionByReferenceRef.value[position.reference] = position;
      pageController.jumpToPage(position.reference.bibleChapterIndex);
      ref.updateUser((user) => user.withHardNavigation(position, bookmarkId: bookmarkId));
      if (updateNavigationState) {
        navigationHistoryState.value = navigationHistoryState.value.withPush(
          NavigationState(position: position, bookmarkId: bookmarkId),
        );
      }
    }

    Future<void> scrollVerseSelectionIntoView(VerseSelection verseSelection) async {
      final chapterReference = verseSelection.references.first.toChapterReference();
      final chapter = await ref.read(
        chapterProvider(
          translation: user.getTranslationFor(chapterReference.book),
          chapterReference: chapterReference,
        ).future,
      );
      await Future.delayed(Duration(milliseconds: 200));

      final controller = currentControllerPassthrough.value;
      controller?.scrollToReference(
        verseSelection.references.first,
        paragraphs: chapter.paragraphs,
        alignment: 0.2,
        duration: Duration(milliseconds: 500),
      );
    }

    void navigateToVerseSelection(VerseSelection verseSelection) async {
      final chapterReference = verseSelection.references.first.toChapterReference();
      hardNavigateTo(ChapterPosition(reference: chapterReference));
      selection.selectReferences(verseSelection.references);
      await scrollVerseSelectionIntoView(verseSelection);
    }

    usePostFrameEffect(() {
      final currentPage = pageController.pageOrNull?.round();
      final targetPage = user.lastReference.bibleChapterIndex;
      if (currentPage != null && currentPage != targetPage && !pageController.position.isScrollingNotifier.value) {
        softNavigateTo(user.lastReference);
        if ((currentPage - targetPage).abs() == 1) {
          pageController.animateToPage(targetPage, duration: Duration(milliseconds: 300), curve: Curves.easeInOutCubic);
        } else {
          pageController.jumpToPage(targetPage);
        }
      }
    }, [pageController, user.lastReference]);

    final isScrollingDownState = useState(true);
    final isAtBottom = useListenableSelector(currentScrollController, () {
      final scrollPosition = currentScrollController?.positionOrNull;
      return scrollPosition == null || !scrollPosition.hasContentDimensions
          ? false
          : scrollPosition.pixels >= scrollPosition.maxScrollExtent;
    });

    final showBottomBar =
        (isScrollingDownState.value || user.mainToolbar.pinToBottom || isAtBottom) && !selection.hasSelection;

    useOnStickyScrollDirectionChanged(
      currentScrollController,
      (direction) => isScrollingDownState.value = direction == .forward,
      [pageController.pageOrNull],
    );

    final onboardingPanelKey = useMemoized(() => GlobalKey());

    final studyPanels = user.studyPanels;
    final onboardingOffset = user.isOnboardingActive ? 1 : 0;
    final panelCount = studyPanels.length + onboardingOffset + (user.audio.isOpen ? 1 : 0);
    final studyPanelsPageController = usePageController(
      initialPage: user.isOnboardingActive
          ? 0
          : user.audio.isOpen
          ? panelCount - 1
          : studyPanels.isEmpty
          ? 0
          : (user.studyPanelIndex ?? (studyPanels.length - 1)),
      keys: [studyPanels.join(','), user.isOnboardingActive, user.audio.isOpen, isSideLayout],
    );

    void addStudyPanel(StudyPanel studyPanel) {
      final verseSelection = selection.verseSelection;
      if (user.studyPanels.contains(studyPanel)) {
        studyPanelsPageController.animateToPage(
          user.studyPanels.indexOf(studyPanel) + onboardingOffset,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
        );
      } else {
        ref.updateUser((user) => user.withStudyPanel(studyPanel));
      }
      selection.clear();
      if (verseSelection != null) {
        scrollVerseSelectionIntoView(verseSelection);
      }
    }

    void onBookmarkAdded(String bookmarkId) =>
        navigationHistoryState.value = navigationHistoryState.value.withBookmark(bookmarkId);

    Widget studyPanelIndicator() => Center(
      child: Container(
        padding: .all(4),
        decoration: BoxDecoration(
          borderRadius: .circular(999),
          color: context.colors.surfaceSecondary.withValues(alpha: 0.5),
        ),
        child: SmoothPageIndicator(
          key: ValueKey(panelCount),
          controller: studyPanelsPageController,
          count: panelCount,
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: context.colors.contentPrimary,
            dotColor: context.colors.surfacePrimary,
          ),
        ),
      ),
    );

    Widget bottom() => Stack(
      clipBehavior: .none,
      children: [
        Builder(
          builder: (context) => AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            bottom: showBottomBar
                ? panelCount == 0
                      ? 0
                      : 4
                : -72 - MediaQuery.paddingOf(context).bottom,
            right: 0,
            left: 0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(boxShadow: [StyledShadow.down(context)]),
              padding: EdgeInsets.symmetric(horizontal: 16) + .only(bottom: MediaQuery.paddingOf(context).bottom + 16),
              child: MainToolbar(
                chapterReference: currentChapterReference,
                mainToolbar: user.mainToolbar,
                translation: user.translation,
                user: user,
                onSwipeLeft: () {
                  var history = navigationHistoryState.value;
                  if (!history.canUndo) {
                    return;
                  }

                  navigationHistoryState.value = navigationHistoryState.value.withUndo();
                  final currentState = navigationHistoryState.value.current;
                  hardNavigateTo(
                    currentState.position,
                    bookmarkId: currentState.bookmarkId,
                    updateNavigationState: false,
                  );
                  ref.markOnboardingStep(.goBack);
                },
                onSwipeRight: () {
                  if (!navigationHistoryState.value.canRedo) {
                    return;
                  }

                  navigationHistoryState.value = navigationHistoryState.value.withRedo();
                  final currentState = navigationHistoryState.value.current;
                  hardNavigateTo(
                    currentState.position,
                    bookmarkId: currentState.bookmarkId,
                    updateNavigationState: false,
                  );
                },
                onPressed: () async {
                  final result = await context.pushDialog<ReferenceSearchPageResult>(
                    ReferenceSearchPage(initialReference: currentChapterReference),
                  );
                  if (result != null) {
                    // addPostFrameCallback until https://github.com/rrousselGit/riverpod/issues/4812
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (result.shouldSelectVerse) {
                        navigateToVerseSelection(VerseSelection.reference(result.position.getReference()!));
                      } else {
                        hardNavigateTo(result.position, bookmarkId: result.bookmarkId);
                      }
                      ref.markOnboardingStep(.navigateChapter);
                    });
                  }
                },
                onLongPressed: () => user.mainToolbar.longPressShortcut.onPressed(
                  context,
                  reference: currentChapterReference,
                  onNavigateToVerseSelection: navigateToVerseSelection,
                  onAddStudyPanel: addStudyPanel,
                  onBookmarkAdded: onBookmarkAdded,
                ),
                onShorcutPressed: (shortcutIndex, shortcut) => shortcut.onPressed(
                  context,
                  reference: currentChapterReference,
                  onNavigateToVerseSelection: navigateToVerseSelection,
                  onAddStudyPanel: addStudyPanel,
                  onBookmarkAdded: onBookmarkAdded,
                ),
                onMorePressed: () => context.showStyledSheet(
                  (_) => StyledSheet(
                    trailing: StyledCircleButton.md(
                      child: Symbols.tune.toIcon(),
                      onPressed: () {
                        context.pop();
                        context.push(MainToolbarSettingsPage());
                      },
                    ),
                    children: MainAction.values
                        .map(
                          (action) => StyledListItem(
                            title: action.title().toText(),
                            subtitle: action.description(user: user).toText(),
                            leading: action.buildIcon(context, user: user),
                            trailing: action.isNavigation ? Icon(Symbols.chevron_right) : null,
                            onPressed: () {
                              context.pop();
                              action.onPressed(
                                context,
                                reference: currentChapterReference,
                                onNavigateToVerseSelection: navigateToVerseSelection,
                                onAddStudyPanel: addStudyPanel,
                                onBookmarkAdded: onBookmarkAdded,
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: ColoredBox(
            color: context.colors.surfacePrimary,
            child: AnimatedGrow(
              child: selection.hasSelection
                  ? Builder(
                      builder: (context) => Container(
                        decoration: BoxDecoration(
                          boxShadow: [StyledShadow.up(context)],
                          color: context.colors.surfacePrimary,
                        ),
                        padding: .only(bottom: MediaQuery.paddingOf(context).bottom),
                        child: SelectionToolbar(
                          selection: selection,
                          onNavigateToVerseSelection: navigateToVerseSelection,
                          onAddStudyPanel: addStudyPanel,
                        ),
                      ),
                    )
                  : SizedBox.shrink(key: ValueKey('empty')),
            ),
          ),
        ),
      ],
    );

    Widget biblePages({Key? key}) => NotificationListener<ScrollStartNotification>(
      onNotification: (notification) {
        if (notification.dragDetails != null && isAudioBiblePlaying) {
          audioBibleController.pause(context: .bible);
        }
        return false;
      },
      child: ChapterPageView(
        key: key,
        controller: pageController,
        onSwipe: (reference) {
          softNavigateTo(reference);
          ref.markOnboardingStep(.swipeChapter);
        },
        onPageChanged: (reference) {
          isScrollingDownState.value = true;
          selection.clear();
        },
        itemBuilder: (context, chapterReference, chapter, passageController) => SafeArea(
          left: true,
          right: !isSideLayout || panelCount == 0,
          bottom: false,
          child: HookBuilder(
            builder: (context) {
              useRegistryItem(passageControllerRegistry, chapterReference, passageController);

              final showTopBar = useListenableSelector(
                passageController.scrollController,
                () => (passageController.scrollController.positionOrNull?.pixels ?? 0) > 60,
              );
              final scrollPosition = positionByReferenceRef.value[chapterReference];

              return Stack(
                fit: .expand,
                children: [
                  ChapterBuilder(
                    controller: passageController,
                    scrollToSelection: scrollPosition?.getReference()?.mapIfNonNull(
                      (reference) => VerseSelection.reference(reference),
                    ),
                    scrollToSelectionAlignment:
                        (switch (scrollPosition?.verseNum) {
                              final verseNum? when chapter.paragraphs.verseHasSection(verseNum) => 24,
                              _ => 0,
                            } +
                            topBarHeight) /
                        (passageKey.renderBox?.size.height ?? 128),
                    emphasizedReference: audioBibleSync.getEmphasizedReferenceForChapter(chapterReference),
                    padding: .only(
                      left: 24,
                      top: MediaQuery.paddingOf(context).top + 40,
                      right: 24,
                      bottom: MediaQuery.paddingOf(context).bottom + 96,
                    ),
                    chapterReference: chapterReference,
                    chapter: chapter,
                    selection: selection,
                    onNavigateToVerseSelection: navigateToVerseSelection,
                    onReferencePressed: audioBibleSync.onReferencePressed,
                    removeScrollbarPadding: isSideLayout && panelCount > 0,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: AnimatedOpacity(
                      opacity: showTopBar ? 1 : 0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOutCubic,
                      child: GestureDetector(
                        onTap: showTopBar ? () => isScrollingDownState.value = true : null,
                        child: Builder(
                          builder: (context) => Container(
                            color: context.colors.backgroundPrimary,
                            padding:
                                EdgeInsets.only(top: MediaQuery.paddingOf(context).top) + .symmetric(horizontal: 16),
                            alignment: .centerLeft,
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Text(chapterReference.format(), style: context.textStyle.labelSm.subtle()),
                                StyledDivider(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );

    Widget mainArea() => Stack(
      children: [
        biblePages(key: passageKey),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: Builder(
            builder: (context) =>
                Container(height: MediaQuery.paddingOf(context).top, color: context.colors.backgroundPrimary),
          ),
        ),
        HookBuilder(
          builder: (context) => TweenAnimationBuilder(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            tween: Tween(
              begin: MediaQuery.of(context).viewPadding,
              end: panelCount == 0 || isSideLayout ? MediaQuery.of(context).viewPadding : EdgeInsets.zero,
            ),
            builder: (context, insets, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(padding: insets, viewPadding: insets, viewInsets: insets),
              child: child!,
            ),
            child: bottom(),
          ),
        ),
        if (!isSideLayout && panelCount > 1) Positioned(bottom: 2, left: 0, right: 0, child: studyPanelIndicator()),
      ],
    );

    Widget studyPanelSection() => Builder(
      builder: (context) => MediaQuery.removeViewPadding(
        context: context,
        removeLeft: true,
        removeRight: true,
        child: HookConsumerBuilder(
          builder: (context, ref) {
            final minStudyPanelHeight = 82.0;
            final maxStudyPanelHeight = MediaQuery.sizeOf(context).height * 0.75;

            final studyPanelHeightRef = useRef(
              (maxStudyPanelHeight * user.studyPanelBottomPosition).clamp(minStudyPanelHeight, maxStudyPanelHeight),
            );
            final isResizingState = useState(false);

            final visibleVerseSelectionState = useState(VerseSelection.empty());
            final visibleVerseSelection = selection.verseSelection ?? visibleVerseSelectionState.value;

            final mainTranslation = user.getTranslationFor(currentChapterReference.book);
            final chapterValue = ref.watch(
              chapterProvider(chapterReference: currentChapterReference, translation: mainTranslation),
            );
            final chapter = chapterValue.value;

            useOnPostFrameListenableChange(currentScrollController, () {
              final studyPanelHeight = studyPanelHeightRef.value.clamp(minStudyPanelHeight, maxStudyPanelHeight);

              final visibleReferences = getVisibleReferencesInViewport(
                keyByReference: keyByReference,
                viewportTop: MediaQuery.paddingOf(context).top + topBarHeight,
                viewportBottom: isSideLayout
                    ? MediaQuery.sizeOf(context).height - MediaQuery.paddingOf(context).bottom
                    : MediaQuery.sizeOf(context).height - studyPanelHeight,
              );

              visibleVerseSelectionState.value = VerseSelection.fromReferences(visibleReferences);
            }, [chapterValue.value, isResizingState.value, MediaQuery.sizeOf(context)]);

            usePeriodic(Duration(seconds: 1), () {
              if (isSideLayout) {
                return;
              }

              final studyPanelPercentVisible = studyPanelHeightRef.value / maxStudyPanelHeight;
              if (studyPanelPercentVisible != user.studyPanelBottomPosition) {
                ref.updateUser((user) => user.copyWith(studyPanelBottomPosition: studyPanelPercentVisible));
              }
            });

            final currentCarouselPage = useListenableSelector(
              studyPanelsPageController,
              () => studyPanelsPageController.pageOrNull?.round() ?? studyPanelsPageController.initialPage,
            );
            final onboardingState = OnboardingState(
              isVerseSelected: selection.verseSelection != null,
              isWordSelected: selection.textSelection != null,
              isMainToolbarVisible: showBottomBar,
              hasStudyPanel: studyPanels.isNotEmpty,
              hasHistory: navigationHistoryState.value.canUndo,
            );

            Widget carousel() => SwipePageView(
              controller: studyPanelsPageController,
              pageCount: panelCount,
              onPageChanged: (page) {
                final studyPanelIndex = page - onboardingOffset;
                if (studyPanelIndex >= 0 && studyPanelIndex < studyPanels.length) {
                  ref.updateUser((user) => user.copyWith(studyPanelIndex: studyPanelIndex));
                  ref.markOnboardingStep(.addStudyPanel);
                }
              },
              children: [
                if (user.isOnboardingActive)
                  Padding(
                    padding: isSideLayout ? .symmetric(horizontal: 4) : .zero,
                    child: OnboardingPanel(
                      key: onboardingPanelKey,
                      showDragHandle: !isSideLayout,
                      state: onboardingState,
                      isVisible: currentCarouselPage == 0,
                    ),
                  ),
                ...studyPanels.mapIndexed(
                  (i, studyPanel) => Padding(
                    key: ValueKey((i, studyPanel)),
                    padding: isSideLayout ? .symmetric(horizontal: 4) : .zero,
                    child: switch (studyPanel) {
                      CompareStudyPanel(:final translation) => HookBuilder(
                        builder: (context) {
                          final paragraphsState = useState<List<Paragraph>?>(null);

                          return LinkedStudyPanel(
                            key: ValueKey((i, currentChapterReference)),
                            chapterReference: currentChapterReference,
                            passageTopReference: visibleVerseSelection.references.firstOrNull,
                            onScrollMainToReference: (reference) {
                              final sizeMultiplier = readerConfiguration
                                  .paragraphsConfiguration(context, mainTranslation)
                                  .sizeMultiplier;
                              final sectionHeight =
                                  chapter?.paragraphs
                                      .getSectionTypeForVerse(reference.verseNum)
                                      ?.getHeight(sizeMultiplier) ??
                                  0;
                              currentPassageController?.scrollToReference(
                                reference,
                                paragraphs: chapter?.paragraphs ?? [],
                                alignment:
                                    (sectionHeight + topBarHeight - 6) / (passageKey.renderBox?.size.height ?? 128),
                              );
                            },
                            onScrollPanelToReference: (reference, panelHeight, controller) {
                              final sizeMultiplier = readerConfiguration
                                  .paragraphsConfiguration(context, translation)
                                  .sizeMultiplier;
                              final sectionHeight =
                                  paragraphsState.value
                                      ?.getSectionTypeForVerse(reference.verseNum)
                                      ?.getHeight(sizeMultiplier) ??
                                  0;
                              controller.scrollToReference(
                                reference,
                                paragraphs: paragraphsState.value ?? [],
                                alignment: sectionHeight / panelHeight,
                              );
                            },
                            isActive: currentCarouselPage == i + onboardingOffset,
                            showDragHandle: !isSideLayout,
                            subtitle: t.studyPanels.compareWith(translation: translation.title()).toText(),
                            onClose: () =>
                                ref.updateUser((user) => user.copyWith(studyPanels: user.studyPanels.withRemovedAt(i))),
                            builder: (context, controller, onContentLoaded) => PassageBuilder(
                              verseSelection: currentChapterReference.toVerseSelection(),
                              translation: translation,
                              controller: controller,
                              padding: .all(16),
                              onParagraphsLoaded: (paragraphs) {
                                paragraphsState.value = paragraphs;
                                onContentLoaded();
                              },
                            ),
                          );
                        },
                      ),
                      _ => StyledSheet.builder(
                        key: ValueKey((i, visibleVerseSelection)),
                        showDragHandle: !isSideLayout,
                        title: visibleVerseSelection.format().toText(),
                        subtitle: SingleChildScrollView(
                          scrollDirection: .horizontal,
                          child: Row(
                            mainAxisAlignment: .center,
                            spacing: 8,
                            children: [
                              studyPanel.title().toText(),
                              if (studyPanel.studyAction?.getTranslationOverride(user: user) case final override?)
                                StyledTag.sm(child: override.title().toText()),
                            ],
                          ),
                        ),
                        leading: StyledCircleButton.md(
                          child: Symbols.close.toIcon(),
                          onPressed: () =>
                              ref.updateUser((user) => user.copyWith(studyPanels: user.studyPanels.withRemovedAt(i))),
                        ),
                        childrenBuilder: (context, ref) {
                          final studyBible = ref.watch(studyBibleProvider).value;
                          if (studyBible == null) {
                            return [Padding(padding: .all(16), child: StyledLoading())];
                          }
                          return studyPanel.buildSheetChildren(
                            context,
                            ref,
                            verseSelection: visibleVerseSelection,
                            onNavigateToVerseSelection: navigateToVerseSelection,
                            user: user,
                            studyBible: studyBible,
                          );
                        },
                      ),
                    },
                  ),
                ),
                if (user.audio.isOpen)
                  Padding(
                    padding: isSideLayout ? .symmetric(horizontal: 4) : .zero,
                    child: AudioBiblePanel(showDragHandle: !isSideLayout),
                  ),
              ].map((child) => KeepAliveContainer(child: child)).toList(),
            );

            if (isSideLayout) {
              if (panelCount == 0) {
                return SizedBox.shrink();
              }

              return Builder(
                builder: (context) => Padding(
                  padding: .only(
                    top: MediaQuery.paddingOf(context).top + 8,
                    bottom: MediaQuery.paddingOf(context).bottom + 8,
                    left: 4,
                    right: 4,
                  ),
                  child: Stack(
                    children: [
                      carousel(),
                      if (panelCount > 1) Positioned(bottom: 2, left: 0, right: 0, child: studyPanelIndicator()),
                    ],
                  ),
                ),
              );
            }

            return AnimatedGrow(
              duration: isResizingState.value ? Duration(milliseconds: 1) : Duration(milliseconds: 300),
              child: panelCount == 0
                  ? SizedBox.shrink(key: ValueKey('empty'))
                  : ResizableContainer(
                      initialHeight: studyPanelHeightRef.value,
                      minHeight: minStudyPanelHeight,
                      maxHeight: maxStudyPanelHeight,
                      onResizeStart: () => isResizingState.value = true,
                      onResizeEnd: () => isResizingState.value = false,
                      onHeightUpdated: (size) => studyPanelHeightRef.value = size,
                      child: Container(width: double.infinity, color: context.colors.surfacePrimary, child: carousel()),
                    ),
            );
          },
        ),
      ),
    );

    return isSideLayout
        ? Row(
            children: [
              Expanded(flex: 4, child: mainArea()),
              if (panelCount > 0) ...[
                Expanded(flex: 3, child: studyPanelSection()),
                SizedBox(width: MediaQuery.viewPaddingOf(context).right),
              ],
            ],
          )
        : Column(
            children: [
              Expanded(child: mainArea()),
              studyPanelSection(),
            ],
          );
  }
}

class NavigationHistory {
  final NavigationState current;
  final List<NavigationState> undo;
  final List<NavigationState> redo;

  const NavigationHistory({required this.current, this.undo = const [], this.redo = const []});

  bool get canUndo => undo.isNotEmpty;
  bool get canRedo => redo.isNotEmpty;

  NavigationHistory withPush(NavigationState state) => copyWith(undo: [...undo, current], current: state, redo: []);

  NavigationHistory withCurrent(NavigationState state) => copyWith(current: state);
  NavigationHistory withUndo() => copyWith(undo: [...undo]..removeLast(), current: undo.last, redo: [current, ...redo]);
  NavigationHistory withRedo() => copyWith(undo: [...undo, current], current: redo.first, redo: [...redo]..removeAt(0));
  NavigationHistory withScrollPosition(ChapterPosition position) => withCurrent(current.copyWith(position: position));
  NavigationHistory withBookmark(String bookmarkId) => withCurrent(current.copyWith(bookmarkId: bookmarkId));

  NavigationHistory copyWith({NavigationState? current, List<NavigationState>? undo, List<NavigationState>? redo}) =>
      NavigationHistory(current: current ?? this.current, undo: undo ?? this.undo, redo: redo ?? this.redo);
}

class NavigationState {
  final ChapterPosition position;
  final String? bookmarkId;

  const NavigationState({required this.position, required this.bookmarkId});

  NavigationState copyWith({ChapterPosition? position, String? bookmarkId}) =>
      NavigationState(position: position ?? this.position, bookmarkId: bookmarkId ?? this.bookmarkId);
}
