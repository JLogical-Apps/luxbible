import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/pages/navigation_settings_page.dart';
import 'package:bible/ui/sheets/bible_sheet.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class PositionPageResult {
  final PositionResult result;
  final String? bookmarkId;

  const PositionPageResult({required this.result, this.bookmarkId});
}

class PositionPage extends HookConsumerWidget implements StyledRoute<PositionPageResult> {
  final ChapterReference initialReference;

  const PositionPage({super.key, required this.initialReference});

  @override
  String get path => '/position';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final recents = user.viewHistory.where((position) => position.reference != initialReference).toList();
    final isShowingAllRecentsState = useState(false);
    final shownRecents = isShowingAllRecentsState.value ? recents : recents.take(5).toList();

    return StyledPage(
      leading: StyledCircleButton.md(child: Symbols.close.toIcon(), onPressed: () => context.pop()),
      trailing: StyledCircleButton.md(
        child: Symbols.tune.toIcon(),
        onPressed: () => context.push(NavigationSettingsPage()),
      ),
      body: PositionSelector(
        initialReference: initialReference,
        layout: user.navigation.layout,
        shouldOpenKeyboard: user.navigation.opensKeyboard,
        trailing: SizedBox(
          width: 112,
          child: StyledMaterial(
            padding: .all(12),
            colorBuilder: .surfaceSecondary,
            borderRadius: .circular(8),
            onPressed: () async {
              final translation = await BibleSheet.show(context);
              if (translation != null) {
                ref.updateUser((user) => user.withTranslation(translation));
              }
            },
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: Text(
                    user.translation.title(),
                    style: context.textStyle.paragraphLg,
                    maxLines: 1,
                    overflow: .clip,
                  ),
                ),
                Icon(Symbols.keyboard_arrow_down, color: context.colors.contentTertiary),
              ],
            ),
          ),
        ),
        onSelect: (result) => context.pop(PositionPageResult(result: result)),
        aboveBooksBuilder: (context, onSelect) => [
          if (user.bookmarkById.isNotEmpty)
            StyledSection(
              title: t.labels.bookmarks.toText(),
              padding: .only(top: 24),
              children: [
                SingleChildScrollView(
                  scrollDirection: .horizontal,
                  padding: MediaQuery.viewPaddingOf(context).onlyHorizontal + .symmetric(horizontal: 16),
                  child: Row(
                    spacing: 16,
                    children: user.bookmarkById
                        .mapToIterable(
                          (bookmarkId, bookmark) => StyledTile(
                            onPressed: () => context.pop(
                              PositionPageResult(
                                result: ChapterPositionResult(position: bookmark.position),
                                bookmarkId: bookmarkId,
                              ),
                            ),
                            padding: .all(16),
                            child: Row(
                              spacing: 12,
                              crossAxisAlignment: .center,
                              children: [
                                Icon(Symbols.bookmark, color: bookmark.color.toHue(context.colors).medium),
                                Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    Text(bookmark.name, style: context.textStyle.labelMd),
                                    Text(bookmark.chapter.format(), style: context.textStyle.paragraphSm.subtle()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          if (user.navigation.showsRecents && recents.isNotEmpty)
            StyledSection(
              title: t.navigation.recents.toText(),
              trailing: recents.length > shownRecents.length
                  ? StyledLink(
                      t.navigation.showMore(count: recents.length - shownRecents.length),
                      onPressed: () => isShowingAllRecentsState.value = true,
                    )
                  : null,
              padding: .only(top: 24),
              children: shownRecents
                  .map(
                    (position) => StyledSwipeable(
                      key: ValueKey(position.reference),
                      actions: [
                        .remove(
                          onPressed: () => ref.updateUser(
                            (user) => user.copyWith(viewHistory: user.viewHistory.withRemoved(position)),
                          ),
                        ),
                      ],
                      child: StyledListItem(
                        leading: Symbols.history.toIcon(),
                        title: position.reference.format().toText(),
                        trailing: Symbols.expand_circle_right.toIcon(),
                        onPressed: () => onSelect(position),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
