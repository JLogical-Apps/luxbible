import 'package:bible/models/chapter_reference.dart';
import 'package:bible/providers/bible_provider.dart';
import 'package:bible/providers/user_profile_provider.dart';
import 'package:bible/style/gap.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/styled_shadow.dart';
import 'package:bible/style/widgets/styled_material.dart';
import 'package:bible/style/widgets/styled_tag.dart';
import 'package:bible/ui/pages/chapter_reference_search_page.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/controller_extensions.dart';
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
    final userProfile = ref.watch(userProfileProvider);
    final bible = userProfile.getBible(bibles);

    final initialReference = userProfile.tabs.firstOrNull;

    final pageController = useListenable(
      usePageController(
        initialPage: initialReference == null
            ? 0
            : bible.getPageIndexByChapterReference(initialReference),
      ),
    );

    final selectedVersesState = useState(<int>[]);

    final currentPage =
        (pageController.pageOrNull ??
                (initialReference == null
                    ? 0
                    : bible.getPageIndexByChapterReference(initialReference)))
            .round();
    final currentChapterReference = bible.getChapterReferenceByPageIndex(currentPage);

    final scrollController = useListenable(useScrollController());
    final scrollPosition = scrollController.positionsOrNull?.firstOrNull;
    final isScrollingDownState = useState(true);
    useOnStickyScrollDirectionChanged(
      scrollController,
      (direction) => isScrollingDownState.value = direction == ScrollDirection.forward,
    );

    final showBottomBar = isScrollingDownState.value || scrollPosition?.atEdge == true;

    return Scaffold(
      backgroundColor: context.colors.backgroundPrimary,
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            onPageChanged: (pageIndex) {
              selectedVersesState.value = [];
              isScrollingDownState.value = true;

              final reference = bible.getChapterReferenceByPageIndex(pageIndex);
              ref
                  .read(userProfileProvider.notifier)
                  .update((profile) => profile.copyWith(tabs: [reference]));
            },
            itemBuilder: (context, pageIndex) {
              final chapterReference = bible.getChapterReferenceByPageIndex(pageIndex);
              final chapter = bible.getChapterByReference(chapterReference);

              return ListView(
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
                  ...chapter.verses.mapIndexed(
                    (i, verse) => GestureDetector(
                      onTap: () => selectedVersesState.value = selectedVersesState.value
                          .withToggle(i),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Transform.translate(
                                offset: Offset(0, -3),
                                child: Text(
                                  (i + 1).toString(),
                                  style: context.textStyle.bibleVerseNumber,
                                ),
                              ),
                              alignment: PlaceholderAlignment.top,
                            ),
                            TextSpan(
                              text: ' ${verse.text}',
                              style: context.textStyle.bibleBody.copyWith(
                                decoration: selectedVersesState.value.contains(i)
                                    ? TextDecoration.underline
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
                    ref
                        .read(userProfileProvider.notifier)
                        .update(
                          (profile) => profile.copyWith(
                            previouslyViewed: [
                              newReference,
                              ...profile.previouslyViewed,
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
                              StyledTag(text: userProfile.translation.title()),
                            ],
                          ),
                        ),
                      ),
                    ),
                    IconButton(icon: Icon(Symbols.more_vert), onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
