import 'package:bible/models/main_action.dart';
import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/chapter_position.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/study_panel.dart';
import 'package:bible/models/text_selection_action.dart';
import 'package:bible/models/verse_selection_action.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/chapter_reference_search_page.dart';
import 'package:bible/ui/pages/main_toolbar_settings_page.dart';
import 'package:bible/ui/pages/text_selection_settings_page.dart';
import 'package:bible/ui/pages/verse_selection_settings_page.dart';
import 'package:bible/ui/widgets/chapter_builder.dart';
import 'package:bible/ui/widgets/hook_consumer_builder.dart';
import 'package:bible/ui/widgets/main_toolbar.dart';
import 'package:bible/ui/widgets/resizable_container.dart';
import 'package:bible/ui/widgets/text_selection_bottom_bar.dart';
import 'package:bible/ui/widgets/verse_selection_bottom_bar.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/controller_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/hook_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:utils_core/utils_core.dart';

class BibleBody extends HookConsumerWidget {
  const BibleBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    final initialPosition = user.lastPosition;

    final isSideLayout = MediaQuery.sizeOf(context).width >= 800;

    final pageController = usePageController(
      initialPage: initialPosition.reference.bibleChapterIndex,
      keys: [isSideLayout],
    );

    final currentPage = (pageController.pageOrNull ?? initialPosition.reference.bibleChapterIndex).round();
    final currentChapterReference = ChapterReference.fromBibleChapterIndex(currentPage);

    final navigationHistoryState = useState(
      NavigationHistory(
        current: NavigationState(position: initialPosition, bookmarkId: user.currentBookmarkId),
      ),
    );

    final isScrollingDownState = useState(true);
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

    useOnStickyScrollDirectionChanged(
      currentScrollController,
      (direction) => isScrollingDownState.value = direction == ScrollDirection.forward,
      [pageController.pageOrNull],
    );

    final selectedReferencesState = useState(<Reference>[]);
    final selectedVerseSelection = selectedReferencesState.value.isEmpty
        ? null
        : VerseSelection.fromReferences(selectedReferencesState.value);

    final textSelectionState = useState<BibleTextSelection?>(null);
    final textSelection = textSelectionState.value;

    final keyByReference = useMemoized(
      () => currentChapterReference.references.mapToMap((reference) => MapEntry(reference, GlobalKey())),
      [currentChapterReference],
    );
    final keyByReferencePassthrough = usePassthrough(keyByReference);

    void onClosePressed() {
      textSelectionState.value = null;
      selectedReferencesState.value = [];
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
      textSelectionState.value = null;
      selectedReferencesState.value = verseSelection.references;

      await ref.read(chapterProvider(translation: user.translation, chapterReference: chapterReference).future);
      await Future.delayed(Duration(milliseconds: 200));

      final keyByReference = keyByReferencePassthrough.value;
      final verseContext = keyByReference[verseSelection.references.first]?.currentContext;
      if (verseContext != null && verseContext.mounted) {
        Scrollable.ensureVisible(
          verseContext,
          alignment: 0.35,
          curve: Curves.easeInOutCubic,
          duration: Duration(milliseconds: 500),
        );
      }
    }

    final studyPanels = user.studyPanels;
    final studyPanelsPageController = usePageController(
      initialPage: user.studyPanelIndex ?? (studyPanels.length - 1),
      keys: [studyPanels.join(','), isSideLayout],
    );

    void addStudyPanel(StudyPanel studyPanel) {
      if (user.studyPanels.contains(studyPanel)) {
        studyPanelsPageController.animateToPage(
          user.studyPanels.indexOf(studyPanel),
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
          controller: studyPanelsPageController,
          count: studyPanels.length,
          effect: WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: context.colors.contentPrimary,
            dotColor: context.colors.surfacePrimary,
          ),
        ),
      ),
    );

    Widget bottom() {
      final textSelection = textSelectionState.value;
      final isAtBottom = useListenableSelector(currentScrollController, () {
        final scrollPosition = currentScrollController.positionOrNull;
        return scrollPosition == null || !scrollPosition.hasContentDimensions
            ? false
            : scrollPosition.pixels >= scrollPosition.maxScrollExtent;
      });

      final showBottomBar =
          (isScrollingDownState.value || user.mainToolbar.pinToBottom || isAtBottom) &&
          selectedVerseSelection == null &&
          textSelection == null;

      return Stack(
        children: [
          Builder(
            builder: (context) => AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              bottom: showBottomBar
                  ? studyPanels.isEmpty
                        ? 0
                        : 4
                  : -72 - MediaQuery.paddingOf(context).bottom,
              right: 0,
              left: 0,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(boxShadow: [StyledShadow.down(context)]),
                padding:
                    EdgeInsets.symmetric(horizontal: 16) + .only(bottom: MediaQuery.paddingOf(context).bottom + 16),
                child: MainToolbar(
                  chapterReference: currentChapterReference,
                  mainToolbar: user.mainToolbar,
                  translation: user.translation,
                  user: user,
                  onSwipeLeft: user.mainToolbar.swipeToUndo
                      ? () {
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
                        }
                      : null,
                  onSwipeRight: user.mainToolbar.swipeToUndo
                      ? () {
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
                        }
                      : null,
                  onPressed: () async {
                    final result = await context.pushDialog<ChapterReferenceSearchPageResult>(
                      ChapterReferenceSearchPage(initialReference: currentChapterReference),
                    );
                    if (result != null) {
                      hardNavigateTo(result.position, bookmarkId: result.bookmarkId);
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
                      trailing: StyledCircleButton.lg(
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
              child: selectedVerseSelection == null && textSelection == null
                  ? SizedBox.shrink(key: ValueKey('empty'))
                  : Builder(
                      builder: (context) => Container(
                        decoration: BoxDecoration(
                          boxShadow: [StyledShadow.up(context)],
                          color: context.colors.surfacePrimary,
                        ),
                        padding: .only(bottom: MediaQuery.paddingOf(context).bottom),
                        child: selectedVerseSelection != null
                            ? VerseSelectionBottomBar(
                                verseSelection: selectedVerseSelection,
                                configuration: user.verseSelection,
                                user: user,
                                onClosePressed: onClosePressed,
                                onMorePressed: () => context.showStyledSheet(
                                  (context) => StyledSheet(
                                    title: 'Verse Selection'.toText(),
                                    subtitle: selectedVerseSelection.format().toText(),
                                    trailing: StyledCircleButton.lg(
                                      child: Symbols.tune.toIcon(),
                                      onPressed: () {
                                        context.pop();
                                        context.push(VerseSelectionSettingsPage());
                                      },
                                    ),
                                    children: VerseSelectionAction.values
                                        .map(
                                          (action) => StyledListItem(
                                            title: action.title().toText(),
                                            subtitle: action.description().toText(),
                                            leading: action.icon.toIcon(),
                                            trailing: action.isNavigation ? Icon(Symbols.chevron_right) : null,
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              action.onPressed(
                                                context,
                                                selectedVerseSelection: selectedVerseSelection,
                                                onDeselect: () => selectedReferencesState.value = [],
                                                onNavigateToVerseSelection: navigateToVerseSelection,
                                              );
                                            },
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                onShorcutPressed: (shortcutIndex, shortcut) => shortcut.onPressed(
                                  context,
                                  verseSelection: selectedVerseSelection,
                                  onDeselect: () => selectedReferencesState.value = [],
                                  onNavigateToVerseSelection: navigateToVerseSelection,
                                ),
                              )
                            : textSelection != null
                            ? TextSelectionBottomBar(
                                textSelection: textSelection,
                                configuration: user.textSelection,
                                user: user,
                                onClosePressed: onClosePressed,
                                onShorcutPressed: (shortcutIndex, shortcut) => shortcut.onPressed(
                                  context,
                                  textSelection: textSelection,
                                  onDeselect: () => textSelectionState.value = null,
                                  onNavigateToVerseSelection: navigateToVerseSelection,
                                ),
                                onMorePressed: () async {
                                  final selectionText = await ref.read(textSelectionTextProvider(textSelection).future);

                                  if (!context.mounted) return;
                                  await context.showStyledSheet(
                                    (context) => StyledSheet(
                                      title: 'Text Selection'.toText(),
                                      subtitle: '"$selectionText"'.toText(),
                                      trailing: StyledCircleButton.lg(
                                        child: Symbols.tune.toIcon(),
                                        onPressed: () {
                                          context.pop();
                                          context.push(TextSelectionSettingsPage());
                                        },
                                      ),
                                      children: TextSelectionAction.values
                                          .map(
                                            (action) => StyledListItem(
                                              title: action.title().toText(),
                                              subtitle: action.description().toText(),
                                              leading: action.icon.toIcon(),
                                              trailing: action.isNavigation ? Icon(Symbols.chevron_right) : null,
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                action.onPressed(
                                                  context,
                                                  textSelection: textSelection,
                                                  onDeselect: () => textSelectionState.value = null,
                                                  onNavigateToVerseSelection: navigateToVerseSelection,
                                                );
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  );
                                },
                              )
                            : null,
                      ),
                    ),
            ),
          ),
        ],
      );
    }

    Widget biblePages() {
      ChapterPosition positionOf(ChapterReference reference) {
        final position = currentScrollController.positionOrNull;
        return ChapterPosition(
          reference: reference,
          scrollPercent: position == null ? 0 : (position.pixels / position.maxScrollExtent).clamp(0, 1),
        );
      }

      return GestureDetector(
        onHorizontalDragUpdate: (details) async {
          const sensitivity = 8;

          final newPageIndex = details.delta.dx > sensitivity
              ? pageController.page!.round() - 1
              : details.delta.dx < -sensitivity
              ? pageController.page!.round() + 1
              : null;

          if (newPageIndex == null || newPageIndex < 0 || newPageIndex >= ChapterReference.values.length) {
            return;
          }

          saveScroll();

          final reference = ChapterReference.fromBibleChapterIndex(newPageIndex);
          final position = positionOf(reference);

          await pageController.animateToPage(
            newPageIndex,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
          );

          ref.updateUser((user) => user.withSoftNavigation(position));
          navigationHistoryState.value = navigationHistoryState.value.withCurrent(
            NavigationState(position: position, bookmarkId: user.currentBookmarkId),
          );
        },
        child: PageView.builder(
          controller: pageController,
          allowImplicitScrolling: false,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (pageIndex) {
            isScrollingDownState.value = true;
            selectedReferencesState.value = [];
            textSelectionState.value = null;
          },
          itemBuilder: (context, pageIndex) {
            final chapterReference = ChapterReference.fromBibleChapterIndex(pageIndex);

            return HookConsumerBuilder(
              builder: (context, ref) {
                final scrollController = chapterReference == currentChapterReference ? currentScrollController : null;
                final chapterValue = ref.watch(
                  chapterProvider(translation: user.translation, chapterReference: chapterReference),
                );
                final chapter = chapterValue.value;

                if (chapterValue.hasError) {
                  return Padding(
                    padding: .symmetric(horizontal: 16),
                    child: Column(
                      spacing: 12,
                      children: [
                        Builder(builder: (context) => SizedBox(height: MediaQuery.paddingOf(context).top + 24)),
                        StyledTile.message(
                          leading: Symbols.error.toIcon(),
                          title: 'Something went wrong'.toText(),
                          subtitle: 'Make sure you are connected to the internet or try again later.'.toText(),
                        ),
                        if (user.translation != .bsb)
                          StyledRectButton.secondary(
                            label: 'Switch to BSB'.toText(),
                            onPressed: () => ref.updateUser((user) => user.copyWith(translation: .bsb)),
                          ),
                        StyledRectButton.secondary(
                          label: 'Try Again'.toText(),
                          onPressed: () => ref.invalidate(
                            chapterProvider(translation: user.translation, chapterReference: chapterReference),
                            asReload: true,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final isLoadedState = useState(false);
                usePostFrameEffect(() {
                  if (scrollController == null) {
                    return;
                  }

                  final target = scrollPercentByReferenceRef.value[chapterReference] ?? 0;
                  final position = currentScrollController.positionOrNull;
                  if (!isLoadedState.value && chapter != null && position != null) {
                    scrollController.jumpTo((target * position.maxScrollExtent).clamp(0.0, position.maxScrollExtent));
                    isLoadedState.value = true;
                  }
                }, [chapter != null, scrollController != null, currentScrollController.positionOrNull != null]);

                final showTopBar = useListenableSelector(
                  scrollController,
                  () =>
                      scrollController != null && scrollController.hasClients && scrollController.position.pixels > 60,
                );

                return AnimatedOpacity(
                  opacity: isLoadedState.value ? 1 : 0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  child: Stack(
                    children: [
                      StyledScrollbar(
                        controller: scrollController,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: .symmetric(horizontal: 24, vertical: 8),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              Builder(builder: (context) => SizedBox(height: MediaQuery.paddingOf(context).top + 24)),
                              ChapterBuilder(
                                chapterReference: chapterReference,
                                user: user,
                                underlinedReferences: selectedReferencesState.value,
                                onReferencePressed: (reference) {
                                  if (textSelectionState.value != null) {
                                    textSelectionState.value = null;
                                  } else if (selectedReferencesState.value.isEmpty &&
                                      user.verseSelection.expandToAnnotation) {
                                    selectedReferencesState.value = user.getExpandedReferences(reference);
                                  } else if (!selectedReferencesState.value.contains(reference) &&
                                      selectedReferencesState.value.isNotEmpty &&
                                      user.verseSelection.rangeSelection) {
                                    final anchorReference = selectedReferencesState.value.first;
                                    final referenceAnchors = [anchorReference, reference];

                                    selectedReferencesState.value = Reference.getReferencesBetween(
                                      referenceAnchors.min,
                                      referenceAnchors.max,
                                    ).toList().withRemoved(anchorReference).withInsert(0, anchorReference);
                                  } else {
                                    selectedReferencesState.value = selectedReferencesState.value.withToggle(reference);
                                  }
                                },
                                onHandleLongPress: (newSelection) {
                                  if (selectedVerseSelection != null &&
                                      newSelection.isInVerseSelection(selectedVerseSelection)) {
                                    user.verseSelection.longPressShortcut.onPressed(
                                      context,
                                      verseSelection: VerseSelection.fromReferences(selectedReferencesState.value),
                                      onDeselect: () => selectedReferencesState.value = [],
                                      onNavigateToVerseSelection: navigateToVerseSelection,
                                    );
                                    return false;
                                  } else if (textSelection != null && textSelection.intersects(newSelection)) {
                                    user.textSelection.longPressShortcut.onPressed(
                                      context,
                                      textSelection: textSelection,
                                      onDeselect: () => textSelectionState.value = null,
                                      onNavigateToVerseSelection: navigateToVerseSelection,
                                    );
                                    return false;
                                  }

                                  return true;
                                },
                                textSelection: textSelectionState.value,
                                onTextSelectionUpdated: (textSelection, isNewSelection) {
                                  selectedReferencesState.value = [];
                                  if (isNewSelection &&
                                      user.textSelection.expandToAnnotation &&
                                      textSelection != null) {
                                    textSelectionState.value = user.getExpandedTextSelection(textSelection);
                                  } else {
                                    textSelectionState.value = textSelection;
                                  }
                                },
                                keyByReference: keyByReference,
                              ),
                              Builder(
                                builder: (context) => SizedBox(height: MediaQuery.paddingOf(context).bottom + 88),
                              ),
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
                                    EdgeInsets.only(top: MediaQuery.paddingOf(context).top) +
                                    .symmetric(horizontal: 16),
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
            );
          },
        ),
      );
    }

    Widget mainArea() => Stack(
      children: [
        biblePages(),
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
              end: studyPanels.isEmpty || isSideLayout ? MediaQuery.of(context).viewPadding : EdgeInsets.zero,
            ),
            builder: (context, insets, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(padding: insets, viewPadding: insets, viewInsets: insets),
              child: child!,
            ),
            child: bottom(),
          ),
        ),
        if (!isSideLayout && studyPanels.length > 1)
          Positioned(bottom: 2, left: 0, right: 0, child: studyPanelIndicator()),
      ],
    );

    Widget studyPanelSection() => HookConsumerBuilder(
      builder: (context, ref) {
        final minStudyPanelHeight = 82.0;
        final maxStudyPanelHeight = MediaQuery.sizeOf(context).height * 0.75;

        final studyPanelHeightRef = useRef(
          (maxStudyPanelHeight * user.studyPanelBottomPosition).clamp(minStudyPanelHeight, maxStudyPanelHeight),
        );
        final isResizingState = useState(false);

        final visibleVerseSelectionState = useState(VerseSelection.empty());
        final visibleVerseSelection = selectedVerseSelection ?? visibleVerseSelectionState.value;

        void computeVisibleVerses() {
          const topBarHeight = 30.0;
          final viewportTop = MediaQuery.paddingOf(context).top + topBarHeight;
          final studyPanelHeight = studyPanelHeightRef.value.clamp(minStudyPanelHeight, maxStudyPanelHeight);
          final viewportBottom = isSideLayout
              ? MediaQuery.sizeOf(context).height - MediaQuery.paddingOf(context).bottom
              : MediaQuery.sizeOf(context).height - studyPanelHeight;

          final visibleReferences = currentChapterReference.references.where((reference) {
            final top = (keyByReference[reference]?.currentContext?.findRenderObject() as RenderBox?)
                ?.localToGlobal(Offset.zero)
                .dy;
            return top != null && top >= viewportTop && top <= viewportBottom;
          }).toList();

          if (visibleReferences.isNotEmpty) {
            visibleVerseSelectionState.value = VerseSelection.fromReferences(visibleReferences);
          }
        }

        final chapterValue = ref.watch(
          chapterProvider(chapterReference: currentChapterReference, translation: user.translation),
        );
        useOnListenableChange(currentScrollController, computeVisibleVerses);
        useOnListenableChange(isResizingState, computeVisibleVerses);
        usePostFrameEffect(computeVisibleVerses, [currentScrollController, chapterValue.value]);

        usePeriodic(Duration(seconds: 1), () {
          if (isSideLayout) {
            return;
          }

          final studyPanelPercentVisible = studyPanelHeightRef.value / maxStudyPanelHeight;
          if (studyPanelPercentVisible != user.studyPanelBottomPosition) {
            ref.updateUser((user) => user.copyWith(studyPanelBottomPosition: studyPanelPercentVisible));
          }
        });

        Widget carousel() => PageView(
          key: ValueKey(studyPanels.join(',')),
          controller: studyPanelsPageController,
          onPageChanged: (page) => ref.updateUser((user) => user.copyWith(studyPanelIndex: page)),
          children: studyPanels
              .mapIndexed(
                (i, studyPanel) => Padding(
                  padding: isSideLayout ? .symmetric(horizontal: 4) : .zero,
                  child: StyledSheet(
                    key: ValueKey((i, visibleVerseSelection)),
                    showDragHandle: !isSideLayout,
                    title: visibleVerseSelection.format().toText(),
                    subtitle: studyPanel.title().toText(),
                    leading: StyledCircleButton.lg(
                      child: Symbols.close.toIcon(),
                      onPressed: () =>
                          ref.updateUser((user) => user.copyWith(studyPanels: user.studyPanels.withRemovedAt(i))),
                    ),
                    children: studyPanel.buildSheetChildren(
                      context,
                      verseSelection: visibleVerseSelection,
                      onNavigateToVerseSelection: navigateToVerseSelection,
                      user: user,
                    ),
                  ),
                ),
              )
              .toList(),
        );

        if (isSideLayout) {
          if (studyPanels.isEmpty) {
            return SizedBox.shrink();
          }

          return Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.paddingOf(context).top + 8,
              bottom: MediaQuery.paddingOf(context).bottom + 8,
              left: 4,
              right: 4,
            ),
            child: Stack(
              children: [
                carousel(),
                if (studyPanels.length > 1) Positioned(bottom: 2, left: 0, right: 0, child: studyPanelIndicator()),
              ],
            ),
          );
        }

        return AnimatedGrow(
          duration: isResizingState.value ? Duration(milliseconds: 1) : Duration(milliseconds: 300),
          child: studyPanels.isEmpty
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
    );

    return isSideLayout
        ? Row(
            children: [
              Expanded(flex: 3, child: mainArea()),
              if (studyPanels.isNotEmpty) Expanded(flex: 2, child: studyPanelSection()),
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
