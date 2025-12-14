import 'package:bible/models/passage_action.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/models/selection_action.dart';
import 'package:bible/models/toolbar_action.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/animated_grow.dart';
import 'package:bible/style/gap.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/styled_shadow.dart';
import 'package:bible/style/widgets/sheet/styled_sheet.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/style/widgets/styled_material.dart';
import 'package:bible/style/widgets/styled_page.dart';
import 'package:bible/style/widgets/styled_scrollbar.dart';
import 'package:bible/style/widgets/styled_tag.dart';
import 'package:bible/ui/pages/chapter_reference_search_page.dart';
import 'package:bible/ui/pages/settings_page.dart';
import 'package:bible/ui/widgets/passage_builder.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/controller_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
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

    final selectedReferencesState = useState(<Reference>[]);

    final scrollController = useScrollController();
    final isScrollingDownState = useMemoized(() => ValueNotifier(true));

    final selectionState = useMemoized(() => ValueNotifier<Selection?>(null));
    final selectionKeyByPageIndexRef = useRef(<int, GlobalKey<SelectionAreaState>>{});

    return StyledPage(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            onPageChanged: (pageIndex) {
              isScrollingDownState.value = true;
              selectionState.value = null;

              final reference = bible.getChapterReferenceByPageIndex(pageIndex);
              ref.updateUser((user) => user.copyWith(lastReference: reference));
            },
            itemBuilder: (context, pageIndex) {
              final chapterReference = bible.getChapterReferenceByPageIndex(pageIndex);

              return HookBuilder(
                builder: (context) {
                  final selectionKey = useMemoized(() => GlobalKey<SelectionAreaState>());
                  useEffect(() {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => selectionKeyByPageIndexRef.value = {
                        ...selectionKeyByPageIndexRef.value,
                        pageIndex: selectionKey,
                      },
                    );
                    return () {
                      selectionKey.currentState?.selectableRegion.clearSelection();
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) =>
                            selectionKeyByPageIndexRef.value = {...selectionKeyByPageIndexRef.value}..remove(pageIndex),
                      );
                    };
                  });

                  return StyledScrollbar(
                    child: ListView(
                      controller: scrollController,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8) +
                          EdgeInsets.only(
                            top: MediaQuery.paddingOf(context).top + 24,
                            bottom: MediaQuery.paddingOf(context).bottom + 72,
                          ),
                      children: [
                        Text(chapterReference.format(), style: context.textStyle.bibleChapter),
                        gapH8,
                        SelectionArea(
                          key: selectionKey,
                          contextMenuBuilder: (context, state) => AdaptiveTextSelectionToolbar.buttonItems(
                            anchors: state.contextMenuAnchors,
                            buttonItems: [],
                          ),
                          child: PassageBuilder(
                            passage: chapterReference.toPassage(),
                            underlinedReferences: selectedReferencesState.value,
                            onReferencePressed: (reference) {
                              final region = selectionKey.currentState?.selectableRegion;
                              if (region == null || region.textEditingValue.selection.isCollapsed) {
                                selectedReferencesState.value = selectedReferencesState.value.withToggle(reference);
                              } else {
                                region.clearSelection();
                              }
                            },
                            onSelectionUpdated: (selection) => WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (selectedReferencesState.value.isNotEmpty) {
                                selectedReferencesState.value = [];
                              }
                              selectionState.value = selection;
                            }),
                            selectionState: selectionState,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(height: MediaQuery.paddingOf(context).top, color: context.colors.backgroundPrimary),
          ),
          _BottomBar(
            currentChapterReference: currentChapterReference,
            scrollController: scrollController,
            pageController: pageController,
            selectedReferencesState: selectedReferencesState,
            isScrollingDownState: isScrollingDownState,
            selectionState: selectionState,
            selectionKey: selectionKeyByPageIndexRef.value[currentPage],
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends HookConsumerWidget {
  final ChapterReference currentChapterReference;
  final PageController pageController;
  final ValueNotifier<List<Reference>> selectedReferencesState;
  final ScrollController scrollController;
  final ValueNotifier<bool> isScrollingDownState;
  final ValueNotifier<Selection?> selectionState;
  final GlobalKey<SelectionAreaState>? selectionKey;

  const _BottomBar({
    required this.currentChapterReference,
    required this.pageController,
    required this.selectedReferencesState,
    required this.scrollController,
    required this.isScrollingDownState,
    required this.selectionState,
    required this.selectionKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bibles = ref.watch(biblesProvider);
    final user = ref.watch(userProvider);
    final bible = user.getBible(bibles);

    useListenable(isScrollingDownState);
    useListenable(scrollController);
    final selection = useListenable(selectionState).value;

    final selectedPassage = selectedReferencesState.value.isEmpty
        ? null
        : Passage.fromReferences(selectedReferencesState.value);

    final selectedText = selection == null ? null : bible.getSelectionText(selection);

    final scrollPosition = scrollController.positionsOrNull?.firstOrNull;
    useOnStickyScrollDirectionChanged(
      scrollController,
      (direction) => isScrollingDownState.value = direction == ScrollDirection.forward,
    );

    final showBottomBar =
        (isScrollingDownState.value || scrollPosition?.atEdge == true) && selectedPassage == null && selection == null;

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
            padding:
                EdgeInsets.symmetric(horizontal: 16) +
                EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom + 16),
            child: StyledMaterial(
              color: context.colors.surfacePrimary,
              borderRadius: BorderRadius.circular(999),
              padding: EdgeInsets.only(left: 24, right: 12),
              onPressed: () async {
                final newReference =
                    await context.pushDialog(ChapterReferenceSearchPage(initialReference: currentChapterReference))
                        as ChapterReference?;
                if (newReference != null) {
                  final pageIndex = bible.getPageIndexByChapterReference(newReference);
                  pageController.jumpToPage(pageIndex);
                  ref.updateUser(
                    (user) => user.copyWith(
                      previouslyViewed: [newReference, ...user.previouslyViewed].distinct.take(5).toList(),
                    ),
                  );
                }
              },
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          spacing: 8,
                          children: [
                            Text(currentChapterReference.format(), style: context.textStyle.labelLg),
                            StyledTag(text: user.translation.title()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ...ToolbarAction.values.map(
                    (action) => StyledCircleButton.lg(
                      onPressed: () => action.onPressed(context, ref, user: user, reference: currentChapterReference),
                      child: action.buildIcon(context, user: user, reference: currentChapterReference),
                    ),
                  ),
                  StyledCircleButton.lg(
                    icon: Symbols.more_vert,
                    onPressed: () => context.showStyledSheet(
                      StyledSheet.list(
                        children: [
                          ...ToolbarAction.values.map(
                            (action) => StyledListItem(
                              titleText: action.title(user: user, reference: currentChapterReference),
                              subtitleText: action.description(user: user, reference: currentChapterReference),
                              leading: action.buildIcon(context, user: user, reference: currentChapterReference),
                              onPressed: () {
                                Navigator.of(context).pop();
                                action.onPressed(context, ref, user: user, reference: currentChapterReference);
                              },
                            ),
                          ),
                          StyledListItem.navigation(
                            titleText: 'Settings',
                            subtitleText: 'Configure the Bible app',
                            leadingIcon: Symbols.tune,
                            onPressed: () {
                              Navigator.of(context).pop();
                              context.push(SettingsPage());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: GestureDetector(
            onTap: () {},
            child: AnimatedGrow(
              child: selectedPassage == null && selection == null
                  ? SizedBox.shrink(key: ValueKey('empty'))
                  : Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [StyledShadow.up(context)],
                        color: context.colors.surfacePrimary,
                      ),
                      padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
                      child: StyledListItem(
                        title: Text(
                          selectedPassage?.format() ?? '"$selectedText"',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: StyledCircleButton.lg(
                          icon: Symbols.close,
                          onPressed: () {
                            selectionKey?.currentState?.selectableRegion.clearSelection();
                            selectedReferencesState.value = [];
                          },
                        ),
                        trailing: selectedPassage != null
                            ? Row(
                                children: [
                                  ...PassageAction.values
                                      .take(3)
                                      .map(
                                        (action) => StyledCircleButton.lg(
                                          child: action.buildIcon(
                                            context,
                                            user: user,
                                            selectedPassage: selectedPassage,
                                          ),
                                          onPressed: () => action.onPressed(
                                            context,
                                            ref,
                                            user: user,
                                            selectedPassage: selectedPassage,
                                            bible: bible,
                                            onDeselect: () => selectedReferencesState.value = [],
                                          ),
                                        ),
                                      ),
                                  StyledCircleButton.lg(
                                    onPressed: () => context.showStyledSheet(
                                      StyledSheet.list(
                                        titleText: 'Passage Actions',
                                        subtitleText: selectedPassage.format(),
                                        children: PassageAction.values
                                            .map(
                                              (action) => StyledListItem(
                                                titleText: action.title(user: user, selectedPassage: selectedPassage),
                                                subtitleText: action.description(
                                                  user: user,
                                                  selectedPassage: selectedPassage,
                                                ),
                                                leading: action.buildIcon(
                                                  context,
                                                  user: user,
                                                  selectedPassage: selectedPassage,
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  action.onPressed(
                                                    context,
                                                    ref,
                                                    user: user,
                                                    selectedPassage: selectedPassage,
                                                    bible: bible,
                                                    onDeselect: () => selectedReferencesState.value = [],
                                                  );
                                                },
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    icon: Symbols.more_vert,
                                  ),
                                ],
                              )
                            : selection != null
                            ? Row(
                                children: [
                                  ...SelectionAction.values
                                      .take(3)
                                      .map(
                                        (action) => StyledCircleButton.lg(
                                          child: action.buildIcon(context, user: user, selection: selection),
                                          onPressed: () => action.onPressed(
                                            context,
                                            ref,
                                            user: user,
                                            selection: selection,
                                            bible: bible,
                                            onDeselect: () =>
                                                selectionKey?.currentState?.selectableRegion.clearSelection(),
                                          ),
                                        ),
                                      ),
                                  StyledCircleButton.lg(
                                    onPressed: () => context.showStyledSheet(
                                      StyledSheet.list(
                                        titleText: 'Selection Actions',
                                        subtitleText: '"${bible.getSelectionText(selection)}"',
                                        children: SelectionAction.values
                                            .map(
                                              (action) => StyledListItem(
                                                titleText: action.title(user: user, selection: selection),
                                                subtitleText: action.description(user: user, selection: selection),
                                                leading: action.buildIcon(context, user: user, selection: selection),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  action.onPressed(
                                                    context,
                                                    ref,
                                                    user: user,
                                                    selection: selection,
                                                    bible: bible,
                                                    onDeselect: () =>
                                                        selectionKey?.currentState?.selectableRegion.clearSelection(),
                                                  );
                                                },
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    icon: Symbols.more_vert,
                                  ),
                                ],
                              )
                            : null,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
