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
import 'package:bible/style/widgets/styled_page.dart';
import 'package:bible/style/widgets/styled_scrollbar.dart';
import 'package:bible/ui/pages/chapter_reference_search_page.dart';
import 'package:bible/ui/pages/passage_settings_page.dart';
import 'package:bible/ui/pages/selection_settings_page.dart';
import 'package:bible/ui/pages/toolbar_settings_page.dart';
import 'package:bible/ui/widgets/passage_bottom_bar.dart';
import 'package:bible/ui/widgets/passage_builder.dart';
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

    final isScrollingDownState = useState(true);

    final selectedReferencesState = useState(<Reference>[]);
    final selectionState = useState<Selection?>(null);
    final keyByReferenceRef = useRef(<Reference, GlobalKey>{});

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

              return StyledScrollbar(
                child: SingleChildScrollView(
                  primary: pageController.page?.round() == pageIndex,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 8) +
                      .only(
                        top: MediaQuery.paddingOf(context).top + 24,
                        bottom: MediaQuery.paddingOf(context).bottom + 72,
                      ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(chapterReference.format(), style: context.textStyle.bibleChapter),
                      gapH16,
                      PassageBuilder(
                        passage: chapterReference.toPassage(),
                        underlinedReferences: selectedReferencesState.value,
                        onReferencePressed: (reference) {
                          if (selectionState.value != null) {
                            selectionState.value = null;
                          } else if (selectedReferencesState.value.isEmpty && user.passage.expandToAnnotation) {
                            selectedReferencesState.value = user.getExpandedReferences(reference);
                          } else {
                            selectedReferencesState.value = selectedReferencesState.value.withToggle(reference);
                          }
                        },
                        onSelectionUpdated: (selection) {
                          selectedReferencesState.value = [];
                          if (selectionState.value == null && user.selection.expandToAnnotation && selection != null) {
                            selectionState.value = user.getExpandedSelection(selection);
                          } else {
                            selectionState.value = selection;
                          }
                        },
                        keyByReferenceRef: keyByReferenceRef,
                        selection: selectionState.value,
                      ),
                      gapH16,
                    ],
                  ),
                ),
              );
            },
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
  final ValueNotifier<bool> isScrollingDownState;
  final ValueNotifier<List<Reference>> selectedReferencesState;
  final ValueNotifier<Selection?> selectionState;
  final ObjectRef<Map<Reference, GlobalKey>> keyByReferenceRef;

  const _Bottom({
    required this.currentChapterReference,
    required this.pageController,
    required this.isScrollingDownState,
    required this.selectedReferencesState,
    required this.selectionState,
    required this.keyByReferenceRef,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bibles = ref.watch(biblesProvider);
    final user = ref.watch(userProvider);
    final bible = user.getBible(bibles);

    final scrollController = useListenable(PrimaryScrollController.maybeOf(context));
    useListenable(isScrollingDownState);
    useListenable(pageController);
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
    final showBottomBar = (isScrollingDownState.value || isAtBottom) && selectedPassage == null && selection == null;

    void onClosePressed() {
      selectionState.value = null;
      selectedReferencesState.value = [];
    }

    void navigateToReference(Reference reference) async {
      final chapterReference = reference.toChapterReference();
      ref.updateUser((user) => user.withViewHistory(chapterReference));
      pageController.jumpToPage(bible.getPageIndexByChapterReference(chapterReference));
      selectedReferencesState.value = [reference];

      await Future.delayed(Duration(milliseconds: 200));

      final verseContext = keyByReferenceRef.value[reference]?.currentContext;
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
              onPressed: () async {
                final newReference =
                    await context.pushDialog(ChapterReferenceSearchPage(initialReference: currentChapterReference))
                        as ChapterReference?;
                if (newReference != null) {
                  final pageIndex = bible.getPageIndexByChapterReference(newReference);
                  pageController.jumpToPage(pageIndex);
                  ref.updateUser((user) => user.withViewHistory(newReference));
                }
              },
              onLongPressed: () => user.toolbar.longPressShortcut.onPressed(
                context,
                ref,
                reference: currentChapterReference,
                user: user,
                bible: bible,
                onNavigateToReference: navigateToReference,
              ),
              onShorcutPressed: (shortcutIndex, shortcut) => shortcut.onPressed(
                context,
                ref,
                reference: currentChapterReference,
                bible: bible,
                user: user,
                onNavigateToReference: navigateToReference,
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
                          title: action.title(user: user, reference: currentChapterReference).toText(),
                          subtitle: action.description(user: user, reference: currentChapterReference).toText(),
                          leading: action.buildIcon(context, user: user, reference: currentChapterReference),
                          trailing: action.isNavigation ? Icon(Symbols.chevron_right) : null,
                          onPressed: () {
                            Navigator.of(context).pop();
                            action.onPressed(
                              context,
                              ref,
                              user: user,
                              reference: currentChapterReference,
                              bible: bible,
                              onNavigateToReference: navigateToReference,
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
                              onNavigateToReference: navigateToReference,
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
                                            onNavigateToReference: navigateToReference,
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
