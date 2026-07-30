import 'package:bible/models/main_action.dart';
import 'package:bible/models/reference/chapter_position.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/study_panel.dart';
import 'package:bible/models/user/onboarding_step.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/chapter_reference_search_page.dart';
import 'package:bible/ui/pages/main_toolbar_settings_page.dart';
import 'package:bible/ui/sheets/compare_sheet.dart';
import 'package:bible/ui/widgets/audio_bible_panel.dart';
import 'package:bible/ui/widgets/bible_selection.dart';
import 'package:bible/ui/widgets/chapter_builder.dart';
import 'package:bible/ui/widgets/chapter_page_view.dart';
import 'package:bible/ui/widgets/hook_consumer_builder.dart';
import 'package:bible/ui/widgets/keep_alive_container.dart';
import 'package:bible/ui/widgets/linked_study_panel.dart';
import 'package:bible/ui/widgets/main_toolbar.dart';
import 'package:bible/ui/widgets/onboarding_panel.dart';
import 'package:bible/ui/widgets/resizable_container.dart';
import 'package:bible/ui/widgets/selection_toolbar.dart';
import 'package:bible/ui/widgets/swipe_page_view.dart';
import 'package:bible/ui/widgets/visible_verse_utils.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/controller_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/key_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/hook_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:utils_core/utils_core.dart';

const topBarHeight = 30.0;

class BibleBody extends HookConsumerWidget {
  const BibleBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    final initialPosition = user.lastPosition;

    final isSideLayout = MediaQuery.sizeOf(context).width - MediaQuery.paddingOf(context).horizontal >= 700;

    final pageController = usePageController(
      initialPage: initialPosition.reference.bibleChapterIndex,
      keys: [isSideLayout],
    );

    final currentPage = (pageController.pageOrNull ?? initialPosition.reference.bibleChapterIndex).round();
    final currentChapterReference = ChapterReference.fromBibleChapterIndex(currentPage);

    final selection = useBibleSelection();

    final navigationHistoryState = useState(
      NavigationHistory(
        current: NavigationState(position: initialPosition, bookmarkId: user.currentBookmarkId),
      ),
    );

    final passageKey = useMemoized(() => GlobalKey());
    final currentScrollController = useScrollController(keys: [currentChapterReference]);
    final scrollPercentByReferenceRef = useRef({initialPosition.reference: initialPosition.scrollPercent});

    void saveScroll() {
      final reference = currentChapterReference;
      final position = currentScrollController.positionOrNull;
      if (position == null || position.maxScrollExtent == 0) {
        return;
      }

      final percent = (position.pixels / position.maxScrollExtent).clamp(0.0, 1.0);
      if (user.lastPosition.scrollPercent == percent) {
        return;
      }

      scrollPercentByReferenceRef.value[reference] = percent;
      navigationHistoryState.value = navigationHistoryState.value.withScrollPercent(percent);
      ref.updateUser((user) => user.withScrollPercent(percent));
    }

    usePeriodic(Duration(seconds: 5), () => saveScroll());

    final keyByReference = useMemoized(
      () => currentChapterReference.references.mapToMap((reference) => MapEntry(reference, GlobalKey())),
      [currentChapterReference],
    );
    final keyBySectionReference = useMemoized(
      () => currentChapterReference.references.mapToMap((reference) => MapEntry(reference, GlobalKey())),
      [currentChapterReference],
    );
    final keyByReferencePassthrough = usePassthrough(keyByReference);

    void softNavigateTo(ChapterReference reference) {
      saveScroll();

      final scrollPosition = currentScrollController.positionOrNull;
      final position = ChapterPosition(
        reference: reference,
        scrollPercent: scrollPosition == null
            ? 0
            : (scrollPosition.pixels / scrollPosition.maxScrollExtent).clamp(0, 1),
      );

      ref.updateUser((user) => user.withSoftNavigation(position));
      ref.markOnboardingStep(.swipeChapter);
      navigationHistoryState.value = navigationHistoryState.value.withCurrent(
        NavigationState(position: position, bookmarkId: user.currentBookmarkId),
      );
    }

    void hardNavigateTo(ChapterPosition position, {String? bookmarkId, bool updateNavigationState = true}) {
      saveScroll();
      scrollPercentByReferenceRef.value[position.reference] = position.scrollPercent;
      pageController.jumpToPage(position.reference.bibleChapterIndex);
      ref.updateUser((user) => user.withHardNavigation(position, bookmarkId: bookmarkId));
      if (updateNavigationState) {
        navigationHistoryState.value = navigationHistoryState.value.withPush(
          NavigationState(position: position, bookmarkId: bookmarkId),
        );
      }
    }

    void navigateToVerseSelection(VerseSelection verseSelection) async {
      final chapterReference = verseSelection.references.first.toChapterReference();
      hardNavigateTo(ChapterPosition(reference: chapterReference));
      selection.selectReferences(verseSelection.references);

      await ref.read(
        chapterProvider(
          translation: user.getTranslationFor(chapterReference.book),
          chapterReference: chapterReference,
        ).future,
      );
      await Future.delayed(Duration(milliseconds: 200));

      final keyByReference = keyByReferencePassthrough.value;
      keyByReference[verseSelection.references.first]?.scrollIntoView(
        alignment: 0.35,
        duration: Duration(milliseconds: 500),
      );
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
      final scrollPosition = currentScrollController.positionOrNull;
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
      if (user.studyPanels.contains(studyPanel)) {
        studyPanelsPageController.animateToPage(
          user.studyPanels.indexOf(studyPanel) + onboardingOffset,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
        );
      } else {
        ref.updateUser((user) => user.withStudyPanel(studyPanel));
      }
    }

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
                  final result = await context.pushDialog<ChapterReferenceSearchPageResult>(
                    ChapterReferenceSearchPage(initialReference: currentChapterReference),
                  );
                  if (result != null) {
                    // addPostFrameCallback until https://github.com/rrousselGit/riverpod/issues/4812
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      hardNavigateTo(result.position, bookmarkId: result.bookmarkId);
                      ref.markOnboardingStep(.navigateChapter);
                    });
                  }
                },
                onLongPressed: () => user.mainToolbar.longPressShortcut.onPressed(
                  context,
                  reference: currentChapterReference,
                  onNavigateToVerseSelection: navigateToVerseSelection,
                  onAddStudyPanel: addStudyPanel,
                ),
                onShorcutPressed: (shortcutIndex, shortcut) => shortcut.onPressed(
                  context,
                  reference: currentChapterReference,
                  onNavigateToVerseSelection: navigateToVerseSelection,
                  onAddStudyPanel: addStudyPanel,
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
                      ),
                    ),
                  )
                : SizedBox.shrink(key: ValueKey('empty')),
          ),
        ),
      ],
    );

    Widget biblePages({Key? key}) => ChapterPageView(
      key: key,
      controller: pageController,
      user: user,
      onSwipe: (reference) {
        softNavigateTo(reference);
        ref.markOnboardingStep(.swipeChapter);
      },
      onPageChanged: (reference) {
        isScrollingDownState.value = true;
        selection.clear();
      },
      itemBuilder: (context, chapterReference, chapter) => SafeArea(
        top: false,
        bottom: false,
        left: true,
        right: true,
        child: HookBuilder(
          builder: (context) {
            final scrollController = chapterReference == currentChapterReference ? currentScrollController : null;

            final isLoaded = useOnContentLoaded(
              controller: scrollController,
              onContentLoaded: (maxScrollExtent) {
                final target = scrollPercentByReferenceRef.value[chapterReference] ?? 0;
                scrollController?.jumpTo((target * maxScrollExtent).clamp(0.0, maxScrollExtent));
              },
            );

            final showTopBar = useListenableSelector(
              scrollController,
              () => scrollController != null && scrollController.hasClients && scrollController.position.pixels > 60,
            );

            return AnimatedOpacity(
              opacity: isLoaded ? 1 : 0,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              child: Stack(
                fit: .expand,
                children: [
                  StyledScrollbar(
                    controller: scrollController,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: scrollController,
                      padding: .symmetric(horizontal: 24, vertical: 8),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Builder(builder: (context) => SizedBox(height: MediaQuery.paddingOf(context).top + 32)),
                          ChapterBuilder(
                            chapterReference: chapterReference,
                            user: user,
                            chapter: chapter,
                            selection: selection,
                            onNavigateToVerseSelection: navigateToVerseSelection,
                            keyByReference: keyByReference,
                            keyBySectionReference: keyBySectionReference,
                          ),
                          Builder(builder: (context) => SizedBox(height: MediaQuery.paddingOf(context).bottom + 88)),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: AnimatedOpacity(
                      key: ValueKey(scrollController?.hasClients),
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
              ),
            );
          },
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

    Widget studyPanelSection() => MediaQuery.removeViewPadding(
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

          final chapterValue = ref.watch(
            chapterProvider(
              chapterReference: currentChapterReference,
              translation: user.getTranslationFor(currentChapterReference.book),
            ),
          );

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
                    CompareStudyPanel(:final translation) => LinkedStudyPanel(
                      key: ValueKey((i, currentChapterReference)),
                      chapterReference: currentChapterReference,
                      passageTopReference: visibleVerseSelection.references.firstOrNull,
                      onScrollToReference: (reference) {
                        final key = keyBySectionReference[reference]?.currentContext != null
                            ? keyBySectionReference[reference]
                            : keyByReference[reference];
                        if (key != null) {
                          key.scrollIntoView(
                            axis: .vertical,
                            duration: Duration(milliseconds: 200),
                            alignment:
                                ((key == keyBySectionReference[reference] ? 24 : 0) +
                                    MediaQuery.paddingOf(context).top +
                                    topBarHeight) /
                                (passageKey.renderBox?.size.height ?? 128),
                          );
                        }
                      },
                      isActive: currentCarouselPage == i + onboardingOffset,
                      showDragHandle: !isSideLayout,
                      subtitle: 'Compare with ${translation.title()}'.toText(),
                      onClose: () =>
                          ref.updateUser((user) => user.copyWith(studyPanels: user.studyPanels.withRemovedAt(i))),
                      childrenBuilder: (context, ref, keyByReference, keyBySectionReference, onContentLoaded) =>
                          CompareSheet.buildSheetChildren(
                            context,
                            verseSelection: currentChapterReference.toVerseSelection(),
                            translation: translation,
                            user: user,
                            keyByReference: keyByReference,
                            keyBySectionReference: keyBySectionReference,
                            onContentLoaded: onContentLoaded,
                          ),
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

            return Padding(
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
    );

    return isSideLayout
        ? Row(
            children: [
              Expanded(
                flex: 4,
                child: MediaQuery.removeViewPadding(context: context, child: mainArea(), removeRight: panelCount > 0),
              ),
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
  NavigationHistory withScrollPercent(double percent) =>
      withCurrent(current.copyWith(position: current.position.copyWith(scrollPercent: percent)));

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
