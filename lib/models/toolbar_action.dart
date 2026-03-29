import 'package:bible/models/bible.dart';
import 'package:bible/models/bookmark.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/search_page.dart';
import 'package:bible/ui/sheets/study_sheet.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

enum ToolbarAction {
  bookmark,
  study,
  search;

  String title() => switch (this) {
    bookmark => 'Bookmark',
    study => 'Study',
    search => 'Search',
  };

  String description({required User user}) => switch (this) {
    bookmark =>
      user.currentSessionBookmark == null
          ? 'Bookmark this chapter to easily access it from the search page.'
          : 'Manage this bookmark.',
    study => 'View study tools for this chapter.',
    search => 'Search for words across the Bible',
  };

  Widget buildIcon(BuildContext context, {required User user}) => switch (this) {
    bookmark => () {
      final bookmark = user.currentSessionBookmark;
      return bookmark == null
          ? Icon(Symbols.bookmark, fill: 0)
          : Icon(Symbols.bookmark, color: bookmark.color.toHue(context.colors).medium);
    }(),
    study => Icon(Symbols.school),
    search => Icon(Symbols.search),
  };

  bool get isNavigation => [study, search].contains(this);

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required User user,
    required ChapterReference reference,
    required Bible bible,
    required Function(Passage) onNavigateToPassage,
  }) async {
    switch (this) {
      case bookmark:
        final bookmark = user.currentSessionBookmark;
        if (bookmark == null) {
          final color = await context.showStyledSheet((context) => StyledColorSheet(title: 'Bookmark Color'.toText()));
          if (color != null) {
            ref.updateUser(
              (user) => user.withBookmark(Bookmark(chapter: reference, color: color, id: user.currentSessionId)),
            );
          }
        } else {
          ref.updateUser((user) => user.withRemovedBookmark(bookmark));
        }
      case study:
        StudySheet.show(
          context,
          ref,
          region: reference,
          bible: bible,
          regionType: RegionType.chapter,
          onNavigateToPassage: onNavigateToPassage,
        );
      case search:
        final result = await context.push(SearchPage(currentChapterReference: reference)) as SearchPageResult?;
        if (result != null) {
          onNavigateToPassage(Passage.reference(result.reference));
        }
    }
  }
}
