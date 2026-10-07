import 'package:bible/models/creed.dart';
import 'package:bible/ui/widgets/creed_item_view.dart';
import 'package:bible/ui/widgets/rich_content_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class CreedPage extends HookWidget implements StyledRoute<VerseSelection> {
  final Creed creed;
  final CreedItem? initialItem;

  const CreedPage({super.key, required this.creed, this.initialItem});

  @override
  String get path => '/creed';

  @override
  Widget build(BuildContext context) {
    final initialItemKey = useMemoized(GlobalKey.new);
    usePostFrameEffect(() => initialItemKey.jumpSliverToTop());

    void navigateToVerseSelection(VerseSelection verseSelection) => context.pop(verseSelection);

    List<Widget> buildItemSlivers(CreedChapter chapter, {required bool isNested}) => chapter.items.map((item) {
      final heading = CreedItemReference(creed: creed, chapter: chapter, item: item).heading;
      return StyledSliverStickyHeader(
        key: item == initialItem ? initialItemKey : null,
        title: Text(heading, style: isNested ? context.textStyle.labelLg : null),
        headerPadding: isNested ? .symmetric(horizontal: 16, vertical: 12) : .all(16),
        sliver: SliverToBoxAdapter(
          child: CreedItemView(item: item, onNavigateToVerseSelection: navigateToVerseSelection),
        ),
      );
    }).toList();

    return StyledPage(
      title: creed.title.toText(),
      body: MediaQuery.removeViewPadding(
        context: context,
        removeLeft: true,
        removeRight: true,
        child: StyledScrollbar(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding:
                    MediaQuery.viewPaddingOf(context).onlyHorizontal +
                    .only(bottom: MediaQuery.paddingOf(context).bottom),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    if (creed.type == .creed)
                      SliverPadding(
                        padding: .all(16),
                        sliver: SliverToBoxAdapter(
                          child: RichContentList(
                            content: creed.chapters
                                .expand((chapter) => chapter.items)
                                .expand((item) => item.body)
                                .toList(),
                            onNavigateToVerseSelection: navigateToVerseSelection,
                          ),
                        ),
                      )
                    else
                      ...creed.chapters.expand(
                        (chapter) => switch (chapter.heading) {
                          final heading? => [
                            StyledSliverStickyHeader(
                              title: heading.toText(),
                              sliver: SliverMainAxisGroup(slivers: buildItemSlivers(chapter, isNested: true)),
                            ),
                          ],
                          _ => buildItemSlivers(chapter, isNested: false),
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
