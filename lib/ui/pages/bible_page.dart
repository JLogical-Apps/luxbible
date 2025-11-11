import 'package:bible/models/chapter_reference.dart';
import 'package:bible/models/passage.dart';
import 'package:bible/models/reference.dart';
import 'package:bible/models/toolbar_action.dart';
import 'package:bible/models/verse_action.dart';
import 'package:bible/providers/bible_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/animated_grow.dart';
import 'package:bible/style/gap.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/styled_shadow.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/style/widgets/styled_material.dart';
import 'package:bible/style/widgets/styled_page.dart';
import 'package:bible/style/widgets/styled_scrollbar.dart';
import 'package:bible/style/widgets/styled_tag.dart';
import 'package:bible/ui/pages/chapter_reference_search_page.dart';
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

    final initialReference = user.tabs.firstOrNull;

    final pageController = useListenable(
      usePageController(
        initialPage: initialReference == null
            ? 0
            : bible.getPageIndexByChapterReference(initialReference),
      ),
    );

    final currentPage =
        (pageController.pageOrNull ??
                (initialReference == null
                    ? 0
                    : bible.getPageIndexByChapterReference(initialReference)))
            .round();
    final currentChapterReference = bible.getChapterReferenceByPageIndex(currentPage);

    final selectedReferencesState = useState(<Reference>[]);
    final selectedPassage = selectedReferencesState.value.isEmpty
        ? null
        : Passage(references: selectedReferencesState.value);

    final scrollController = useListenable(useScrollController());
    final scrollPosition = scrollController.positionsOrNull?.firstOrNull;
    final isScrollingDownState = useState(true);
    useOnStickyScrollDirectionChanged(
      scrollController,
      (direction) => isScrollingDownState.value = direction == ScrollDirection.forward,
    );

    final showBottomBar =
        (isScrollingDownState.value || scrollPosition?.atEdge == true) &&
        selectedReferencesState.value.isEmpty;

    return StyledPage(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            onPageChanged: (pageIndex) {
              selectedReferencesState.value = [];
              isScrollingDownState.value = true;

              final reference = bible.getChapterReferenceByPageIndex(pageIndex);
              ref.updateUser((user) => user.copyWith(tabs: [reference]));
            },
            itemBuilder: (context, pageIndex) {
              final chapterReference = bible.getChapterReferenceByPageIndex(pageIndex);
              final chapter = bible.getChapterByReference(chapterReference);

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
                    Text(
                      chapterReference.format(),
                      style: context.textStyle.bibleChapter,
                    ),
                    gapH8,
                    PassageBuilder(
                      bible: bible,
                      passage: Passage(
                        references: chapter.verses
                            .mapIndexed(
                              (i, verse) => chapterReference.getReference(i + 1),
                            )
                            .toList(),
                      ),
                      underlinedReferences: selectedReferencesState.value,
                      onReferencePressed: (reference) => selectedReferencesState.value =
                          selectedReferencesState.value.withToggle(reference),
                    ),
                  ],
                ),
              );
            },
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            bottom: showBottomBar ? 0 : -72,
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
                      await context.pushDialog(
                            ChapterReferenceSearchPage(
                              initialReference: currentChapterReference,
                            ),
                          )
                          as ChapterReference?;
                  if (newReference != null) {
                    final pageIndex = bible.getPageIndexByChapterReference(newReference);
                    pageController.jumpToPage(pageIndex);
                    ref.updateUser(
                      (user) => user.copyWith(
                        previouslyViewed: [
                          newReference,
                          ...user.previouslyViewed,
                        ].distinct.take(5).toList(),
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
                              Text(
                                currentChapterReference.format(),
                                style: context.textStyle.labelLg,
                              ),
                              StyledTag(text: user.translation.title()),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ...ToolbarAction.values.map(
                      (action) => StyledCircleButton(
                        onPressed: () => action.onPressed(
                          context,
                          ref,
                          user: user,
                          reference: currentChapterReference,
                        ),
                        child: action.buildIcon(
                          context,
                          user: user,
                          reference: currentChapterReference,
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
            child: AnimatedGrow(
              child: selectedPassage == null
                  ? SizedBox.shrink(key: ValueKey('empty'))
                  : Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [StyledShadow.up(context)],
                        color: context.colors.surfacePrimary,
                      ),
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.paddingOf(context).bottom,
                      ),
                      child: StyledListItem(
                        title: Text(
                          selectedPassage.format(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: StyledCircleButton(
                          icon: Symbols.close,
                          onPressed: () => selectedReferencesState.value = [],
                        ),
                        trailing: Row(
                          children: VerseAction.values
                              .map(
                                (action) => StyledCircleButton(
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
                                    deselectVerses: () =>
                                        selectedReferencesState.value = [],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
