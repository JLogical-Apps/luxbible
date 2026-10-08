import 'package:bible/models/creed.dart';
import 'package:bible/ui/sheets/contents_sheet.dart';
import 'package:bible/ui/widgets/creed_item_view.dart';
import 'package:bible/ui/widgets/rich_content_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class CreedPage extends HookWidget implements StyledRoute<VerseSelection> {
  final Creed creed;
  final CreedItem? initialItem;

  const CreedPage({super.key, required this.creed, this.initialItem});

  @override
  String get path => '/creed';

  @override
  Widget build(BuildContext context) {
    final keyByChapter = useMemoized(() => creed.chapters.mapToMap((chapter) => MapEntry(chapter, GlobalKey())));
    final keyByItem = useMemoized(
      () => creed.chapters.expand((chapter) => chapter.items).mapToMap((item) => MapEntry(item, GlobalKey())),
    );
    usePostFrameEffect(() => keyByItem[initialItem]?.jumpToTop());

    final sections = creed.type == .creed
        ? <ContentsSection>[]
        : creed.chapters
              .expand(
                (chapter) => switch (chapter.heading) {
                  final heading? => [ContentsSection(title: heading, key: keyByChapter[chapter]!)],
                  _ => chapter.items.map(
                    (item) => ContentsSection(
                      title: CreedItemReference(creed: creed, chapter: chapter, item: item).heading,
                      key: keyByItem[item]!,
                    ),
                  ),
                },
              )
              .toList();

    void navigateToVerseSelection(VerseSelection verseSelection) => context.pop(verseSelection);

    List<Widget> buildItemSlivers(CreedChapter chapter, {required bool isNested}) => chapter.items.map((item) {
      final heading = CreedItemReference(creed: creed, chapter: chapter, item: item).heading;
      return StyledSliverStickyHeader(
        key: keyByItem[item],
        title: Text(heading, style: isNested ? context.textStyle.labelLg : null),
        headerPadding: isNested ? .symmetric(horizontal: 16, vertical: 12) : .all(16),
        sliver: SliverToBoxAdapter(
          child: CreedItemView(item: item, onNavigateToVerseSelection: navigateToVerseSelection),
        ),
      );
    }).toList();

    return StyledPage(
      title: creed.title.toText(),
      trailing: StyledCircleButton.md(
        child: Symbols.more_vert.toIcon(),
        onPressed: () => context.showStyledSheet(
          (sheetContext, _) => StyledSheet(
            title: creed.title.toText(),
            children: [
              if (ContentsSheet.hasContents(sections))
                StyledListItem(
                  leading: Symbols.toc.toIcon(),
                  title: t.labels.contents.toText(),
                  onPressed: () {
                    sheetContext.pop();
                    ContentsSheet.show(context, sections: sections);
                  },
                ),
              StyledListItem(
                leading: Symbols.info.toIcon(),
                title: t.labels.about.toText(),
                onPressed: () {
                  sheetContext.pop();
                  showInfo(context);
                },
              ),
            ],
          ),
        ),
      ),
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
                              key: keyByChapter[chapter],
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

  Future<void> showInfo(BuildContext context) => context.showStyledDialog(
    (context) => StyledDialog.confirm(
      title: creed.title.toText(),
      bodyPadding: .zero,
      body: StyledList(
        children: [
          StyledListItem(
            leading: Symbols.history_edu.toIcon(),
            title: creed.type.title().toText(),
            subtitle: creed.type.description().toText(),
          ),
          StyledListItem(
            leading: Symbols.calendar_month.toIcon(),
            title: t.creeds.year.toText(),
            subtitle: creed.year.toText(),
          ),
          if (creed.authors.isNotEmpty)
            StyledListItem(
              leading: Symbols.group.toIcon(),
              title: t.creeds.authors(count: creed.authors.length).toText(),
              subtitle: creed.authors.join(', ').toText(),
            ),
        ],
      ),
    ),
  );
}
