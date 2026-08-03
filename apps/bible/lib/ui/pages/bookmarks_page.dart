import 'package:lux/i18n.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:style/style.dart';
import 'package:lux/lux.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:utils_core/utils_core.dart';

class BookmarksPage extends HookConsumerWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return StyledPage(
      title: t.bookmarkPage.title.toText(),
      body: user.bookmarkById.isEmpty
          ? StyledListView.child(
              child: SafeArea(
                child: Padding(
                  padding: .all(16),
                  child: StyledTile.message(
                    leading: Symbols.bookmark.toIcon(),
                    title: t.emptyStates.noBookmarks.toText(),
                  ),
                ),
              ),
            )
          : StyledReorderableList(
              children: user.bookmarkById
                  .mapToIterable(
                    (id, bookmark) => StyledSwipeable(
                      key: ValueKey(id),
                      actions: [
                        .delete(
                          onPressed: () async {
                            final confirmed = await context.showStyledDialog(
                              (context) => StyledDialog.confirmDelete(
                                cancelLabel: t.common.nevermind.toText(),
                                title: t.bookmarks.delete.toText(),
                                body: t.bookmarks.deleteNamedConfirmation(name: bookmark.name).toText(),
                              ),
                            );
                            if (confirmed == true) {
                              ref.updateUser((user) => user.withRemovedBookmark(id));
                            }
                          },
                        ),
                      ],
                      child: StyledListItem.draggable(
                        title: bookmark.name.toText(),
                        subtitle: bookmark.chapter.format().toText(),
                        leading: Icon(Symbols.bookmark, color: bookmark.color.toHue(context.colors).medium),
                      ),
                    ),
                  )
                  .toList(),
              onReorder: (oldIndex, newIndex) => ref.updateUser(
                (user) => user.copyWith(bookmarkById: user.bookmarkById.withReorder(oldIndex, newIndex)),
              ),
            ),
    );
  }
}
