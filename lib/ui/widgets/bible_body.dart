import 'package:bible/models/main_action.dart';
import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
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
import 'package:bible/ui/widgets/main_toolbar.dart';
import 'package:bible/ui/widgets/text_selection_bottom_bar.dart';
import 'package:bible/ui/widgets/verse_selection_bottom_bar.dart';
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

class BibleBody extends HookConsumerWidget {
  const BibleBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    final initialReference = user.lastReference;

    final pageController = usePageController(initialPage: initialReference.bibleChapterIndex);

    final currentPage = (pageController.pageOrNull ?? initialReference.bibleChapterIndex).round();
    final currentChapterReference = ChapterReference.fromBibleChapterIndex(currentPage);

    final navigationHistoryState = useState(
      NavigationHistory(
        current: NavigationState(reference: initialReference, bookmarkId: user.currentBookmarkId),
      ),
    );

    final isScrollingDownState = useState(true);
    final scrollControllerByReferenceRef = useRef(<ChapterReference, ScrollController>{});

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
    final selectedVerseSelection = selectedReferencesState.value.isEmpty
        ? null
        : VerseSelection.fromReferences(selectedReferencesState.value);

    final textSelectionState = useState<BibleTextSelection?>(null);
    final textSelection = textSelectionState.value;

    final showBottomBar =
        (isScrollingDownState.value || user.mainToolbar.pinToBottom || isAtBottom) &&
        selectedVerseSelection == null &&
        textSelection == null;

    final keyByReferenceRef = useRef(<Reference, GlobalKey>{});

    void onClosePressed() {
      textSelectionState.value = null;
      selectedReferencesState.value = [];
    }

    void hardNavigateTo(ChapterReference reference, {String? bookmarkId, bool updateNavigationState = true}) {
      pageController.jumpToPage(reference.bibleChapterIndex);
      ref.updateUser((user) => user.withHardNavigation(reference, bookmarkId: bookmarkId));
      if (updateNavigationState) {
        navigationHistoryState.value = navigationHistoryState.value.withPush(
          NavigationState(reference: reference, bookmarkId: bookmarkId),
        );
      }
    }

    void navigateToVerseSelection(VerseSelection verseSelection) async {
      final chapterReference = verseSelection.references.first.toChapterReference();
      hardNavigateTo(chapterReference);
      textSelectionState.value = null;
      selectedReferencesState.value = verseSelection.references;

      await ref.read(chapterProvider(translation: user.translation, chapterReference: chapterReference).future);
      await Future.delayed(Duration(milliseconds: 200));

      final verseContext = keyByReferenceRef.value[verseSelection.references.first]?.currentContext;
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
        GestureDetector(
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

            await pageController.animateToPage(
              newPageIndex,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
            );

            final reference = ChapterReference.fromBibleChapterIndex(newPageIndex);
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
              selectedReferencesState.value = [];
              textSelectionState.value = null;
            },
            itemBuilder: (context, pageIndex) {
              final chapterReference = ChapterReference.fromBibleChapterIndex(pageIndex);

              return HookBuilder(
                builder: (context) {
                  final scrollController = useDisposable(
                    useScrollController(),
                    (controller) =>
                        scrollControllerByReferenceRef.value = {...scrollControllerByReferenceRef.value}
                          ..remove(chapterReference),
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
                                      ref,
                                      verseSelection: VerseSelection.fromReferences(selectedReferencesState.value),
                                      onDeselect: () => selectedReferencesState.value = [],
                                      onNavigateToVerseSelection: navigateToVerseSelection,
                                    );
                                    return false;
                                  } else if (textSelection != null && textSelection.intersects(newSelection)) {
                                    user.textSelection.longPressShortcut.onPressed(
                                      context,
                                      ref,
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
                                keyByReferenceRef: keyByReferenceRef,
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
          child: Builder(
            builder: (context) =>
                Container(height: MediaQuery.paddingOf(context).top, color: context.colors.backgroundPrimary),
          ),
        ),
        Stack(
          children: [
            Builder(
              builder: (context) => AnimatedPositioned(
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
                  child: MainToolbar(
                    chapterReference: currentChapterReference,
                    mainToolbar: user.mainToolbar,
                    translation: user.translation,
                    user: user,
                    onSwipeLeft: user.mainToolbar.swipeToUndo
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
                    onSwipeRight: user.mainToolbar.swipeToUndo
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
                      final result = await context.pushDialog<ChapterReferenceSearchPageResult>(
                        ChapterReferenceSearchPage(initialReference: currentChapterReference),
                      );
                      if (result != null) {
                        hardNavigateTo(result.chapterReference, bookmarkId: result.bookmarkId);
                      }
                    },
                    onLongPressed: () => user.mainToolbar.longPressShortcut.onPressed(
                      context,
                      ref,
                      reference: currentChapterReference,
                      onNavigateToVerseSelection: navigateToVerseSelection,
                    ),
                    onShorcutPressed: (shortcutIndex, shortcut) => shortcut.onPressed(
                      context,
                      ref,
                      reference: currentChapterReference,
                      onNavigateToVerseSelection: navigateToVerseSelection,
                    ),
                    onMorePressed: () => context.showStyledSheet(
                      (context) => StyledSheet(
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
                                    ref,
                                    reference: currentChapterReference,
                                    onNavigateToVerseSelection: navigateToVerseSelection,
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
                                                  ref,
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
                                    ref,
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
                                    ref,
                                    textSelection: textSelection,
                                    onDeselect: () => textSelectionState.value = null,
                                    onNavigateToVerseSelection: navigateToVerseSelection,
                                  ),
                                  onMorePressed: () async {
                                    final selectionText = await ref.read(
                                      textSelectionTextProvider(textSelection).future,
                                    );

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
                                                    ref,
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
