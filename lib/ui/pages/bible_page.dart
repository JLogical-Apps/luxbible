import 'package:bible/models/passage_action.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/models/selection_action.dart';
import 'package:bible/models/toolbar_action.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/chapter_reference_search_page.dart';
import 'package:bible/ui/pages/passage_settings_page.dart';
import 'package:bible/ui/pages/selection_settings_page.dart';
import 'package:bible/ui/pages/toolbar_settings_page.dart';
import 'package:bible/ui/widgets/chapter_builder.dart';
import 'package:bible/ui/widgets/passage_bottom_bar.dart';
import 'package:bible/ui/widgets/selection_bottom_bar.dart';
import 'package:bible/ui/widgets/toolbar.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/controller_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:bible/utils/hook_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class BiblePage extends HookConsumerWidget {
  const BiblePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bibles = ref.watch(displayBiblesProvider);
    final user = ref.watch(userProvider);
    final bible = user.getDisplayBible(bibles);

    final initialReference = user.lastReference;

    final pageController = usePageController(initialPage: bible.getPageIndexByChapterReference(initialReference));

    final currentPage = (pageController.pageOrNull ?? bible.getPageIndexByChapterReference(initialReference)).round();
    final currentChapterReference = bible.getChapterReferenceByPageIndex(currentPage);

    final navigationHistoryState = useState(
      NavigationHistory(
        current: NavigationState(reference: initialReference, bookmarkId: user.currentBookmarkId),
      ),
    );

    final isScrollingDownState = useState(true);
    final scrollControllerByReferenceRef = useState(<ChapterReference, ScrollController>{});

    final currentScrollController = scrollControllerByReferenceRef.value[currentChapterReference];
    final isAtBottom = useListenableSelector(currentScrollController, () {
      final scrollPosition = currentScrollController?.positionsOrNull?.firstOrNull;
      return scrollPosition == null || !scrollPosition.hasContentDimensions
          ? false
          : scrollPosition.pixels >= scrollPosition.maxScrollExtent;
    });

    useOnStickyScrollDirectionChanged(
      currentScrollController,
      (direction) => isScrollingDownState.value = direction == ScrollDirection.forward,
      [pageController.pageOrNull],
    );

    final selectedReferencesState = useState(<Reference>[]);
    final selectedPassage = selectedReferencesState.value.isEmpty
        ? null
        : Passage.fromReferences(selectedReferencesState.value);

    final selectionState = useState<Selection?>(null);
    final selection = selectionState.value;

    final showBottomBar =
        (isScrollingDownState.value || user.toolbar.pinToBottom || isAtBottom) &&
        selectedPassage == null &&
        selection == null;

    final keyByReferenceRef = useRef(<Reference, GlobalKey>{});

    void onClosePressed() {
      selectionState.value = null;
      selectedReferencesState.value = [];
    }

    void hardNavigateTo(ChapterReference reference, {String? bookmarkId, bool updateNavigationState = true}) {
      final pageIndex = bible.getPageIndexByChapterReference(reference);
      pageController.jumpToPage(pageIndex);
      ref.updateUser((user) => user.withHardNavigation(reference, bookmarkId: bookmarkId));
      if (updateNavigationState) {
        navigationHistoryState.value = navigationHistoryState.value.withPush(
          NavigationState(reference: reference, bookmarkId: bookmarkId),
        );
      }
    }

    void navigateToPassage(Passage passage) async {
      final chapterReference = passage.references.first.toChapterReference();
      hardNavigateTo(chapterReference);
      selectionState.value = null;
      selectedReferencesState.value = passage.references;

      await Future.delayed(Duration(milliseconds: 200));

      final verseContext = keyByReferenceRef.value[passage.references.first]?.currentContext;
      if (verseContext != null && verseContext.mounted) {
        Scrollable.ensureVisible(
          verseContext,
          alignment: 0.35,
          curve: Curves.easeInOutCubic,
          duration: Duration(milliseconds: 500),
        );
      }
    }

    return StyledPage(
      body: Stack(
        children: [
          GestureDetector(
            onHorizontalDragUpdate: (details) async {
              const sensitivity = 8;

              final newPageIndex = details.delta.dx > sensitivity
                  ? pageController.page!.round() - 1
                  : details.delta.dx < -sensitivity
                  ? pageController.page!.round() + 1
                  : null;

              if (newPageIndex == null || newPageIndex < 0 || newPageIndex >= bible.chapterReferences.length) {
                return;
              }

              await pageController.animateToPage(
                newPageIndex,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
              );

              final reference = bible.getChapterReferenceByPageIndex(newPageIndex);
              ref.updateUser((user) => user.withSoftNavigation(reference));
              navigationHistoryState.value = navigationHistoryState.value.withCurrent(
                NavigationState(reference: reference, bookmarkId: user.currentBookmarkId),
              );
            },
            child: PageView.builder(
              controller: pageController,
              allowImplicitScrolling: false,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (pageIndex) {
                isScrollingDownState.value = true;
                selectionState.value = null;
              },
              itemBuilder: (context, pageIndex) {
                final chapterReference = bible.getChapterReferenceByPageIndex(pageIndex);

                return HookBuilder(
                  builder: (context) {
                    final scrollController = useDisposable(
                      useScrollController(),
                      (controller) => WidgetsBinding.instance.addPostFrameCallback(
                        (_) =>
                            scrollControllerByReferenceRef.value = {...scrollControllerByReferenceRef.value}
                              ..remove(chapterReference),
                      ),
                    );
                    if (!scrollControllerByReferenceRef.value.containsKey(chapterReference)) {
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => scrollControllerByReferenceRef.value = {
                          ...scrollControllerByReferenceRef.value,
                          chapterReference: scrollController,
                        },
                      );
                    }

                    final showTopBar = useListenableSelector(
                      scrollController,
                      () => scrollController.hasClients && scrollController.position.pixels > 60,
                    );

                    return Stack(
                      children: [
                        StyledScrollbar(
                          controller: scrollController,
                          child: SingleChildScrollView(
                            controller: scrollController,
                            padding:
                                EdgeInsets.symmetric(horizontal: 20, vertical: 8) +
                                .only(
                                  top: MediaQuery.paddingOf(context).top + 24,
                                  bottom: MediaQuery.paddingOf(context).bottom + 72,
                                ),
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                ChapterBuilder(
                                  chapterReference: chapterReference,
                                  bible: bible,
                                  user: user,
                                  underlinedReferences: selectedReferencesState.value,
                                  onReferencePressed: (reference) {
                                    if (selectionState.value != null) {
                                      selectionState.value = null;
                                    } else if (selectedReferencesState.value.isEmpty &&
                                        user.passage.expandToAnnotation) {
                                      selectedReferencesState.value = user.getExpandedReferences(reference);
                                    } else if (!selectedReferencesState.value.contains(reference) &&
                                        selectedReferencesState.value.isNotEmpty &&
                                        user.passage.rangeSelection) {
                                      final anchorReference = selectedReferencesState.value.first;
                                      final referenceAnchors = [anchorReference, reference];

                                      selectedReferencesState.value = Reference.getReferencesBetween(
                                        referenceAnchors.min,
                                        referenceAnchors.max,
                                      ).toList().withRemoved(anchorReference).withInsert(0, anchorReference);
                                    } else {
                                      selectedReferencesState.value = selectedReferencesState.value.withToggle(
                                        reference,
                                      );
                                    }
                                  },
                                  onHandleLongPress: (selection) {
                                    if (selectedPassage != null && selection.isInPassage(selectedPassage)) {
                                      user.passage.longPressShortcut.onPressed(
                                        context,
                                        ref,
                                        passage: Passage.fromReferences(selectedReferencesState.value),
                                        onDeselect: () => selectedReferencesState.value = [],
                                        onNavigateToPassage: navigateToPassage,
                                      );
                                      return false;
                                    }

                                    return true;
                                  },
                                  selection: selectionState.value,
                                  onSelectionUpdated: (selection, isNewSelection) {
                                    selectedReferencesState.value = [];
                                    if (isNewSelection && user.selection.expandToAnnotation && selection != null) {
                                      selectionState.value = user.getExpandedSelection(selection);
                                    } else {
                                      selectionState.value = selection;
                                    }
                                  },
                                  keyByReferenceRef: keyByReferenceRef,
                                ),
                                gapH16,
                              ],
                            ),
                          ),
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
                              child: Container(
                                color: context.colors.backgroundPrimary,
                                padding:
                                    EdgeInsets.only(top: MediaQuery.paddingOf(context).top) +
                                    .symmetric(horizontal: 16),
                                alignment: .centerLeft,
                                child: Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    Text(chapterReference.format(), style: context.textStyle.labelSm.subtle(context)),
                                    StyledDivider(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(height: MediaQuery.paddingOf(context).top, color: context.colors.backgroundPrimary),
          ),
          Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
                bottom: showBottomBar ? 0 : -72 - MediaQuery.paddingOf(context).bottom,
                right: 0,
                left: 0,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(boxShadow: [StyledShadow.down(context)]),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16) + .only(bottom: MediaQuery.paddingOf(context).bottom + 16),
                  child: Toolbar(
                    chapterReference: currentChapterReference,
                    toolbar: user.toolbar,
                    translation: user.translation,
                    user: user,
                    onSwipeLeft: user.toolbar.swipeToUndo
                        ? () {
                            if (!navigationHistoryState.value.canUndo) {
                              return;
                            }

                            navigationHistoryState.value = navigationHistoryState.value.withUndo();
                            final currentState = navigationHistoryState.value.current;
                            hardNavigateTo(
                              currentState.reference,
                              bookmarkId: currentState.bookmarkId,
                              updateNavigationState: false,
                            );
                          }
                        : null,
                    onSwipeRight: user.toolbar.swipeToUndo
                        ? () {
                            if (!navigationHistoryState.value.canRedo) {
                              return;
                            }

                            navigationHistoryState.value = navigationHistoryState.value.withRedo();
                            final currentState = navigationHistoryState.value.current;
                            hardNavigateTo(
                              currentState.reference,
                              bookmarkId: currentState.bookmarkId,
                              updateNavigationState: false,
                            );
                          }
                        : null,
                    onPressed: () async {
                      final result =
                          await context.pushDialog(
                                ChapterReferenceSearchPage(initialReference: currentChapterReference),
                              )
                              as ChapterReferenceSearchPageResult?;
                      if (result != null) {
                        hardNavigateTo(result.chapterReference, bookmarkId: result.bookmarkId);
                      }
                    },
                    onLongPressed: () => user.toolbar.longPressShortcut.onPressed(
                      context,
                      ref,
                      reference: currentChapterReference,
                      onNavigateToPassage: navigateToPassage,
                    ),
                    onShorcutPressed: (shortcutIndex, shortcut) => shortcut.onPressed(
                      context,
                      ref,
                      reference: currentChapterReference,
                      onNavigateToPassage: navigateToPassage,
                    ),
                    onMorePressed: () => context.showStyledSheet(
                      (context) => StyledSheet(
                        title: 'Chapter Actions'.toText(),
                        subtitle: currentChapterReference.format().toText(),
                        trailing: StyledCircleButton.lg(
                          child: Symbols.tune.toIcon(),
                          onPressed: () {
                            context.pop();
                            context.push(ToolbarSettingsPage());
                          },
                        ),
                        children: ToolbarAction.values
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
                                    ref,
                                    reference: currentChapterReference,
                                    onNavigateToPassage: navigateToPassage,
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
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: AnimatedGrow(
                  child: selectedPassage == null && selection == null
                      ? SizedBox.shrink(key: ValueKey('empty'))
                      : Container(
                          decoration: BoxDecoration(
                            boxShadow: [StyledShadow.up(context)],
                            color: context.colors.surfacePrimary,
                          ),
                          padding: .only(bottom: MediaQuery.paddingOf(context).bottom),
                          child: selectedPassage != null
                              ? PassageBottomBar(
                                  passage: selectedPassage,
                                  configuration: user.passage,
                                  user: user,
                                  onClosePressed: onClosePressed,
                                  onMorePressed: () => context.showStyledSheet(
                                    (context) => StyledSheet(
                                      title: 'Passage Actions'.toText(),
                                      subtitle: selectedPassage.format().toText(),
                                      trailing: StyledCircleButton.lg(
                                        child: Symbols.tune.toIcon(),
                                        onPressed: () {
                                          context.pop();
                                          context.push(PassageSettingsPage());
                                        },
                                      ),
                                      children: PassageAction.values
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
                                                  ref,
                                                  selectedPassage: selectedPassage,
                                                  onDeselect: () => selectedReferencesState.value = [],
                                                  onNavigateToPassage: navigateToPassage,
                                                );
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                  onShorcutPressed: (shortcutIndex, shortcut) => shortcut.onPressed(
                                    context,
                                    ref,
                                    passage: selectedPassage,
                                    onDeselect: () => selectedReferencesState.value = [],
                                    onNavigateToPassage: navigateToPassage,
                                  ),
                                )
                              : selection != null
                              ? SelectionBottomBar(
                                  selection: selection,
                                  configuration: user.selection,
                                  user: user,
                                  onClosePressed: onClosePressed,
                                  onShorcutPressed: (shortcutIndex, shortcut) => shortcut.onPressed(
                                    context,
                                    ref,
                                    selection: selection,
                                    onDeselect: () => selectionState.value = null,
                                    onNavigateToPassage: navigateToPassage,
                                  ),
                                  onMorePressed: () => context.showStyledSheet(
                                    (context) => StyledSheet(
                                      title: 'Selection Actions'.toText(),
                                      subtitle: '"${bible.getSelectionText(selection)}"'.toText(),
                                      trailing: StyledCircleButton.lg(
                                        child: Symbols.tune.toIcon(),
                                        onPressed: () {
                                          context.pop();
                                          context.push(SelectionSettingsPage());
                                        },
                                      ),
                                      children: SelectionAction.values
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
                                                  ref,
                                                  selection: selection,
                                                  onDeselect: () => selectionState.value = null,
                                                  onNavigateToPassage: navigateToPassage,
                                                );
                                              },
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                )
                              : null,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
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

  NavigationHistory copyWith({NavigationState? current, List<NavigationState>? undo, List<NavigationState>? redo}) =>
      NavigationHistory(current: current ?? this.current, undo: undo ?? this.undo, redo: redo ?? this.redo);
}

class NavigationState {
  final ChapterReference reference;
  final String? bookmarkId;

  const NavigationState({required this.reference, required this.bookmarkId});
}
