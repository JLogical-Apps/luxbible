import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/search_page.dart';
import 'package:bible/ui/pages/settings_page.dart';
import 'package:bible/ui/sheets/bookmark_sheet.dart';
import 'package:bible/ui/sheets/study_sheet.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

enum MainAction {
  bookmark,
  study,
  search,
  settings;

  String title() => switch (this) {
    bookmark => 'Bookmark',
    study => 'Study',
    search => 'Search',
    settings => 'Settings',
  };

  String description({User? user}) => switch (this) {
    bookmark =>
      user?.currentBookmark == null
          ? 'Bookmark this chapter to easily access it from the search page.'
          : 'Manage this bookmark.',
    study => 'View study tools for this chapter.',
    search => 'Search for words across the Bible.',
    settings => 'View the settings for Lux.',
  };

  Widget buildIcon(BuildContext context, {User? user}) => switch (this) {
    bookmark => () {
      final bookmark = user?.currentBookmark;
      return bookmark == null
          ? Icon(Symbols.bookmark, fill: 0)
          : Icon(Symbols.bookmark, color: bookmark.color.toHue(context.colors).medium);
    }(),
    study => Icon(Symbols.school),
    search => Icon(Symbols.search),
    settings => Icon(Symbols.settings),
  };

  bool get isNavigation => [study, search].contains(this);

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required ChapterReference reference,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) async {
    final user = ref.read(userProvider);
    switch (this) {
      case bookmark:
        final bookmarkId = user.currentBookmarkId;
        final bookmark = user.currentBookmark;
        if (bookmarkId == null || bookmark == null) {
          final newBookmark = await BookmarkSheet.show(context, reference: reference);
          if (newBookmark != null) {
            ref.updateUser((user) => user.withNewBookmark(newBookmark));
          }
        } else {
          await context.showStyledSheet(
            (context) => StyledSheet(
              title: 'Manage Bookmark'.toText(),
              children: [
                StyledListItem(
                  title: 'Stop Following'.toText(),
                  subtitle: 'Stop this bookmark from following you.'.toText(),
                  leading: Symbols.keep_off.toIcon(),
                  onPressed: () {
                    context.pop();
                    ref.updateUser((user) => user.copyWith(currentBookmarkId: null));
                  },
                ),
                StyledListItem(
                  title: 'Edit Bookmark'.toText(),
                  subtitle: 'Edit this bookmark\'s color and name.'.toText(),
                  leading: Symbols.edit.toIcon(),
                  onPressed: () async {
                    context.pop();
                    final newBookmark = await BookmarkSheet.show(
                      context,
                      reference: reference,
                      initialBookmark: bookmark,
                    );
                    if (newBookmark != null) {
                      ref.updateUser((user) => user.withEditedBookmark(bookmarkId: bookmarkId, bookmark: newBookmark));
                    }
                  },
                ),
                StyledListItem(
                  title: 'Delete Bookmark'.toText(),
                  subtitle: 'Delete this bokmark.'.toText(),
                  leading: Icon(Symbols.delete, color: context.colors.contentError),
                  onPressed: () {
                    context.pop();
                    ref.updateUser((user) => user.withRemovedBookmark(bookmarkId));
                  },
                ),
              ],
            ),
          );
        }
      case study:
        StudySheet.show(
          context,
          ref,
          region: reference,
          regionType: RegionType.chapter,
          onNavigateToVerseSelection: onNavigateToVerseSelection,
        );
      case search:
        final result = await context.push(SearchPage(currentChapterReference: reference)) as SearchPageResult?;
        if (result != null) {
          onNavigateToVerseSelection(VerseSelection.reference(result.reference));
        }
      case settings:
        final result = await context.push(SettingsPage()) as VerseSelection?;
        if (result != null) {
          onNavigateToVerseSelection(result);
        }
    }
  }
}
