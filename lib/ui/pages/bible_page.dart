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
    final bibles = ref.watch(biblesProvider);
    final user = ref.watch(userProvider);
    final bible = user.getBible(bibles);

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

    final selectedReferencesState = useState(<Reference>[]);
    final selectionState = useState<Selection?>(null);
    final keyByReferenceRef = useRef(<Reference, GlobalKey>{});

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
                                  book: chapterReference.book,
                                  chapter: bible.getChapterByReference(chapterReference),
                                  underlinedReferences: selectedReferencesState.value,
                                  onReferencePressed: (reference) {
                                    if (selectionState.value != null) {
                                      selectionState.value = null;
                                    } else if (selectedReferencesState.value.isEmpty &&
                                        user.passage.expandToAnnotation) {
                                      selectedReferencesState.value = user.getExpandedReferences(reference);
                                    } else {
                                      selectedReferencesState.value = selectedReferencesState.value.withToggle(
                                        reference,
                                      );
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
                            child: Container(
                              color: context.colors.backgroundPrimary,
                              padding:
                                  EdgeInsets.only(top: MediaQuery.paddingOf(context).top) + .symmetric(horizontal: 16),
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
          _Bottom(
            currentChapterReference: currentChapterReference,
            pageController: pageController,
            selectedReferencesState: selectedReferencesState,
            navigationStateState: navigationHistoryState,
            scrollController: scrollControllerByReferenceRef.value[currentChapterReference],
            isScrollingDownState: isScrollingDownState,
            selectionState: selectionState,
            keyByReferenceRef: keyByReferenceRef,
          ),
        ],
      ),
    );
  }
}

class _Bottom extends HookConsumerWidget {
  final ChapterReference currentChapterReference;
  final PageController pageController;
  final ValueNotifier<NavigationHistory> navigationStateState;
  final ValueNotifier<bool> isScrollingDownState;
  final ScrollController? scrollController;
  final ValueNotifier<List<Reference>> selectedReferencesState;
  final ValueNotifier<Selection?> selectionState;
  final ObjectRef<Map<Reference, GlobalKey>> keyByReferenceRef;

  const _Bottom({
    required this.currentChapterReference,
    required this.pageController,
    required this.navigationStateState,
    required this.isScrollingDownState,
    required this.scrollController,
    required this.selectedReferencesState,
    required this.selectionState,
    required this.keyByReferenceRef,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bibles = ref.watch(biblesProvider);
    final user = ref.watch(userProvider);
    final bible = user.getBible(bibles);

    useListenable(scrollController);
    useListenable(isScrollingDownState);
    final selection = useListenable(selectionState).value;

    final selectedPassage = selectedReferencesState.value.isEmpty
        ? null
        : Passage.fromReferences(selectedReferencesState.value);

    final scrollPosition = scrollController?.positionsOrNull?.firstOrNull;
    useOnStickyScrollDirectionChanged(
      scrollController,
      (direction) => isScrollingDownState.value = direction == ScrollDirection.forward,
      [pageController.page],
    );

    final isAtBottom = scrollPosition == null || !scrollPosition.hasContentDimensions
        ? false
        : scrollPosition.pixels >= scrollPosition.maxScrollExtent;
    final showBottomBar =
        (isScrollingDownState.value || user.toolbar.pinToBottom || isAtBottom) &&
        selectedPassage == null &&
        selection == null;

    void onClosePressed() {
      selectionState.value = null;
      selectedReferencesState.value = [];
    }

    void hardNavigateTo(ChapterReference reference, {String? bookmarkId, bool updateNavigationState = true}) {
      final pageIndex = bible.getPageIndexByChapterReference(reference);
      pageController.jumpToPage(pageIndex);
      ref.updateUser((user) => user.withHardNavigation(reference, bookmarkId: bookmarkId));
      if (updateNavigationState) {
        navigationStateState.value = navigationStateState.value.withPush(
          NavigationState(reference: reference, bookmarkId: bookmarkId),
        );
      }
    }

    void navigateToPassage(Passage passage) async {
      final chapterReference = passage.references.first.toChapterReference();
      hardNavigateTo(chapterReference);
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

    return Stack(
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
            padding: EdgeInsets.symmetric(horizontal: 16) + .only(bottom: MediaQuery.paddingOf(context).bottom + 16),
            child: Toolbar(
              chapterReference: currentChapterReference,
              toolbar: user.toolbar,
              translation: user.translation,
              user: user,
              onSwipeLeft: () {
                if (!navigationStateState.value.canUndo) {
                  return;
                }

                navigationStateState.value = navigationStateState.value.withUndo();
                final currentState = navigationStateState.value.current;
                hardNavigateTo(
                  currentState.reference,
                  bookmarkId: currentState.bookmarkId,
                  updateNavigationState: false,
                );
              },
              onSwipeRight: () {
                if (!navigationStateState.value.canRedo) {
                  return;
                }

                navigationStateState.value = navigationStateState.value.withRedo();
                final currentState = navigationStateState.value.current;
                hardNavigateTo(
                  currentState.reference,
                  bookmarkId: currentState.bookmarkId,
                  updateNavigationState: false,
                );
              },
              onPressed: () async {
                final result =
                    await context.pushDialog(ChapterReferenceSearchPage(initialReference: currentChapterReference))
                        as ChapterReferenceSearchPageResult?;
                if (result != null) {
                  hardNavigateTo(result.chapterReference, bookmarkId: result.bookmarkId);
                }
              },
              onLongPressed: () => user.toolbar.longPressShortcut.onPressed(
                context,
                ref,
                reference: currentChapterReference,
                user: user,
                bible: bible,
                onNavigateToPassage: navigateToPassage,
              ),
              onShorcutPressed: (shortcutIndex, shortcut) => shortcut.onPressed(
                context,
                ref,
                reference: currentChapterReference,
                bible: bible,
                user: user,
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
                              user: user,
                              reference: currentChapterReference,
                              bible: bible,
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
                                            user: user,
                                            selectedPassage: selectedPassage,
                                            bible: bible,
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
                              user: user,
                              passage: selectedPassage,
                              bible: bible,
                              onDeselect: () => selectedReferencesState.value = [],
                              onNavigateToPassage: navigateToPassage,
                            ),
                          )
                        : selection != null
                        ? SelectionBottomBar(
                            selection: selection,
                            configuration: user.selection,
                            user: user,
                            bible: bible,
                            onClosePressed: onClosePressed,
                            onShorcutPressed: (shortcutIndex, shortcut) => shortcut.onPressed(
                              context,
                              ref,
                              user: user,
                              selection: selection,
                              bible: bible,
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
                                            user: user,
                                            selection: selection,
                                            bible: bible,
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
