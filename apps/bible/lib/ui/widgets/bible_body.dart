import 'package:bible/models/study_panel.dart';
import 'package:bible/models/user/onboarding_step.dart';
import 'package:bible/providers/audio_bible_player_provider.dart';
import 'package:bible/providers/audio_bible_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/bible_navigation_service.dart';
import 'package:bible/ui/hooks/audio_bible_passage_sync.dart';
import 'package:bible/ui/hooks/reader_bottom_bar_visibility.dart';
import 'package:bible/ui/hooks/study_panel_carousel.dart';
import 'package:bible/ui/pages/position_page.dart';
import 'package:bible/ui/sheets/main_actions_sheet.dart';
import 'package:bible/ui/widgets/audio_bible_panel.dart';
import 'package:bible/ui/widgets/main_toolbar.dart';
import 'package:bible/ui/widgets/onboarding_panel.dart';
import 'package:bible/ui/widgets/reader_bottom_bar.dart';
import 'package:bible/ui/widgets/selection_toolbar.dart';
import 'package:bible/ui/widgets/side_layout_scope.dart';
import 'package:bible/ui/widgets/study_panel_layout.dart';
import 'package:bible/ui/widgets/visible_verse_utils.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

const topBarHeight = 30.0;

class BibleBody extends HookConsumerWidget {
  const BibleBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final bibleNavigationService = ref.watch(bibleNavigationServiceProvider);
    final readerConfiguration = ref.watch(luxReaderConfigurationProvider);

    final initialPosition = user.lastPosition;

    final isSideLayout = SideLayoutScope.isSideLayoutOf(context);

    final pageController = usePageController(
      initialPage: initialPosition.reference.bibleChapterIndex,
      keys: [isSideLayout],
    );
    final pageControllerPassthrough = usePassthrough(pageController);

    final currentPage = (pageController.pageOrNull ?? initialPosition.reference.bibleChapterIndex).round();
    final currentChapterReference = ChapterReference.fromBibleChapterIndex(currentPage);

    final selectionController = usePassageSelectionController(readerConfiguration.selection);

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
      selection: selectionController,
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
        viewportTop: context.untrackedMediaQuery.padding.top + topBarHeight,
        viewportBottom: context.untrackedMediaQuery.size.height - context.untrackedMediaQuery.padding.bottom,
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
      final pageController = pageControllerPassthrough.value;
      if (pageController.hasClients) pageController.jumpToPage(position.reference.bibleChapterIndex);
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
      selectionController.selectReferences(verseSelection.references);
      await scrollVerseSelectionIntoView(verseSelection);
    }

    useOnListenableChange(bibleNavigationService, () {
      if (bibleNavigationService.requestedSelection case final selection?) {
        bibleNavigationService.clearRequest();
        context.goToRoot();
        navigateToVerseSelection(selection);
      }
    });

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

    final bottomBarVisibility = useReaderBottomBarVisibility(
      scrollController: currentScrollController,
      isPinned: user.mainToolbar.pinToBottom,
      hasSelection: selectionController.hasSelection,
      keys: [pageController.pageOrNull],
    );

    final onboardingPanelKey = useMemoized(() => GlobalKey());

    final studyPanelCarousel = useStudyPanelCarousel(
      ref: ref,
      isSideLayout: isSideLayout,
      leadingPanelBuilder: user.isOnboardingActive
          ? (showDragHandle, isVisible) => OnboardingPanel(
              key: onboardingPanelKey,
              showDragHandle: showDragHandle,
              state: OnboardingState(
                isVerseSelected: selectionController.verseSelection != null,
                isWordSelected: selectionController.textSelection != null,
                isMainToolbarVisible: bottomBarVisibility.isVisible,
                hasStudyPanel: user.studyPanels.isNotEmpty,
                hasHistory: navigationHistoryState.value.canUndo,
              ),
              isVisible: isVisible,
            )
          : null,
      trailingPanelBuilder: user.audio.isOpen
          ? (showDragHandle) => AudioBiblePanel(context: .bible, showDragHandle: showDragHandle)
          : null,
    );

    void addStudyPanel(StudyPanel studyPanel) {
      final verseSelection = selectionController.verseSelection;
      studyPanelCarousel.addStudyPanel(studyPanel);
      selectionController.clear();
      if (verseSelection != null) {
        scrollVerseSelectionIntoView(verseSelection);
      }
    }

    void scrollMainToReference(Reference reference) {
      final translation = user.getTranslationFor(currentChapterReference.book);
      final paragraphs =
          ref
              .read(chapterProvider(chapterReference: currentChapterReference, translation: translation))
              .value
              ?.paragraphs ??
          [];

      final sizeMultiplier = readerConfiguration.paragraphsConfiguration(context, translation).sizeMultiplier;
      final sectionHeight = paragraphs.getSectionTypeForVerse(reference.verseNum)?.getHeight(sizeMultiplier) ?? 0;
      currentPassageController?.scrollToReference(
        reference,
        paragraphs: paragraphs,
        alignment: (sectionHeight + topBarHeight - 6) / (passageKey.renderBox?.size.height ?? 128),
      );
    }

    void onBookmarkAdded(String bookmarkId) =>
        navigationHistoryState.value = navigationHistoryState.value.withBookmark(bookmarkId);

    Widget toolbar() => MainToolbar(
      bookTitle: currentChapterReference.book.title(),
      location: currentChapterReference.chapterNum.toString(),
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
        hardNavigateTo(currentState.position, bookmarkId: currentState.bookmarkId, updateNavigationState: false);
        ref.markOnboardingStep(.goBack);
      },
      onSwipeRight: () {
        if (!navigationHistoryState.value.canRedo) {
          return;
        }

        navigationHistoryState.value = navigationHistoryState.value.withRedo();
        final currentState = navigationHistoryState.value.current;
        hardNavigateTo(currentState.position, bookmarkId: currentState.bookmarkId, updateNavigationState: false);
      },
      onPressed: () async {
        final result = await context.pushDialog(PositionPage(initialReference: currentChapterReference));
        if (result != null) {
          switch (result.result) {
            case ChapterPositionResult(:final position):
              hardNavigateTo(position, bookmarkId: result.bookmarkId);
            case PassagePositionResult(:final selection):
              navigateToVerseSelection(selection.toVerseSelection());
          }
          ref.markOnboardingStep(.navigateChapter);
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
      onMorePressed: () async {
        final action = await MainActionsSheet.show(context);
        if (action != null && context.mounted) {
          action.onPressed(
            context,
            reference: currentChapterReference,
            onNavigateToVerseSelection: navigateToVerseSelection,
            onAddStudyPanel: addStudyPanel,
            onBookmarkAdded: onBookmarkAdded,
          );
        }
      },
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
          bottomBarVisibility.show();
          selectionController.clear();
        },
        itemBuilder: (context, chapterReference, chapter, passageController) => SafeArea(
          left: true,
          right: !isSideLayout || !studyPanelCarousel.hasPanels,
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
                        (passageKey.renderBox?.sizeOrNull?.height ?? 128),
                    emphasizedReference: audioBibleSync.getEmphasizedReferenceForChapter(chapterReference),
                    padding: .only(
                      left: 24,
                      top: MediaQuery.paddingOf(context).top + 40,
                      right: 24,
                      bottom: MediaQuery.viewPaddingOf(context).bottom + 96,
                    ),
                    chapterReference: chapterReference,
                    chapter: chapter,
                    selection: selectionController,
                    onNavigateToVerseSelection: navigateToVerseSelection,
                    removeScrollbarPadding: isSideLayout && studyPanelCarousel.hasPanels,
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
                        onTap: showTopBar ? bottomBarVisibility.show : null,
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
        ReaderBottomBar(
          isToolbarVisible: bottomBarVisibility.isVisible,
          hasStudyPanels: studyPanelCarousel.hasPanels,
          isSideLayout: isSideLayout,
          toolbar: toolbar(),
          selectionToolbar: selectionController.hasSelection
              ? SelectionToolbar(
                  selectionController: selectionController,
                  onNavigateToVerseSelection: navigateToVerseSelection,
                  onAddStudyPanel: addStudyPanel,
                )
              : null,
        ),
      ],
    );

    return StudyPanelLayout(
      carousel: studyPanelCarousel,
      isSideLayout: isSideLayout,
      passage: currentChapterReference.toVerseSelection(),
      passageController: currentPassageController,
      selectionController: selectionController,
      getViewportTop: () => context.untrackedMediaQuery.padding.top + topBarHeight,
      onScrollMainToReference: scrollMainToReference,
      onNavigateToVerseSelection: navigateToVerseSelection,
      child: mainArea(),
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
