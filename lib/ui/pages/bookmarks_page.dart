import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
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
      title: 'Your Bookmarks'.toText(),
      body: user.bookmarkById.isEmpty
          ? Padding(
              padding: .all(16),
              child: StyledTile.message(
                leading: Symbols.bookmark.toIcon(),
                title: "You haven't created any bookmarks.".toText(),
              ),
            )
          : StyledReorderableList(
              children: user.bookmarkById
                  .mapToIterable(
                    (id, bookmark) => StyledSwipeable(
                      key: ValueKey(id),
                      actions: [.delete(onPressed: () => ref.updateUser((user) => user.withRemovedBookmark(id)))],
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
