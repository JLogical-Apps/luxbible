import 'package:bible/extensions/collection_extensions.dart';
import 'package:bible/providers/bible_provider.dart';
import 'package:bible/style/gap.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BiblePage extends HookConsumerWidget {
  const BiblePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bible = ref.watch(bibleProvider);

    final pageController = useListenable(usePageController(initialPage: 0));
    final selectedVersesState = useState(<int>[]);

    final currentPage = pageController.hasClients ? pageController.page?.round() : null;
    final currentChapterReference = currentPage == null
        ? null
        : bible.getChapterReferenceByPageIndex(currentPage);

    final scrollController = useListenable(useScrollController());
    final isScrollingDownState = useState(false);
    useEffect(
      () {
        if (!scrollController.hasClients) {
          return;
        }

        if (scrollController.position.userScrollDirection == ScrollDirection.idle) {
          return null;
        }
        isScrollingDownState.value =
            scrollController.position.userScrollDirection == ScrollDirection.forward;
        return null;
      },
      [
        scrollController.hasClients
            ? scrollController.position.userScrollDirection
            : null,
      ],
    );
    final showBottomBar =
        isScrollingDownState.value ||
        (scrollController.hasClients && scrollController.position.atEdge);

    return Scaffold(
      backgroundColor: context.colors.backgroundPrimary,
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            onPageChanged: (_) => selectedVersesState.value = [],
            itemBuilder: (context, pageIndex) {
              final chapterReference = bible.getChapterReferenceByPageIndex(pageIndex);
              final chapter = bible.getChapterByReference(chapterReference);

              return ListView(
                controller: scrollController,
                padding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 8) +
                    EdgeInsets.only(
                      top: MediaQuery.paddingOf(context).top + 24,
                      bottom: MediaQuery.paddingOf(context).bottom + 64,
                    ),
                children: [
                  Text(
                    '${chapterReference.book.title()} ${chapterReference.chapterNum}',
                    style: context.textStyle.bibleChapter,
                  ),
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
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: context.brightness == Brightness.light
                        ? Colors.black.withValues(alpha: 0.12)
                        : Colors.black.withValues(alpha: 0.5),
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                    blurRadius: 16,
                  ),
                ],
              ),
              padding:
                  EdgeInsets.symmetric(horizontal: 16) +
                  EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom + 16),
              child: Material(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                color: context.colors.surfacePrimary,
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(left: 24, right: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              currentChapterReference == null
                                  ? '---'
                                  : '${currentChapterReference.book.title()} ${currentChapterReference.chapterNum}',
                              style: context.textStyle.labelLarge,
                            ),
                          ),
                        ),
                        IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
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
  }
}
