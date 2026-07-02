import 'package:bible/models/commentary.dart';
import 'package:bible/models/commentary_type.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/commentaries_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/simple_markdown.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:utils_core/utils_core.dart';

class CommentarySheet {
  static List<Widget> buildSheetChildren(
    BuildContext context, {
    required VerseSelection verseSelection,
    CommentaryType? commentary,
    required User user,
  }) {
    final commentaries = ref.read(commentariesProvider);
    if (commentary != null) {
      final items = commentaries[commentary]?.mapIfNonNull((c) => _commentaryItems(c, verseSelection)) ?? [];
      return items.isEmpty
          ? [
              Padding(
                padding: .all(16),
                child: StyledBanner(message: 'No Commentaries Found'.toText()),
              ),
            ]
          : items;
    }

    final relatedCommentaries = user.commentariesOrDefault
        .mapToMap((type) => MapEntry(type, commentaries[type]))
        .withoutNullValues
        .mapValues((type, commentary) => _commentaryItems(commentary, verseSelection))
        .where((type, items) => items.isNotEmpty);

    return relatedCommentaries.isEmpty
        ? [
            Padding(
              padding: .all(16),
              child: StyledBanner(message: 'No Commentaries Found'.toText()),
            ),
          ]
        : relatedCommentaries
              .mapToIterable((type, items) => StyledStickyHeader(title: type.title().toText(), children: items))
              .toList();
  }

  static List<Widget> _commentaryItems(Commentary commentary, VerseSelection verseSelection) => commentary
      .getNotesFor(verseSelection)
      .mapToIterable(
        (verseSelection, note) => StyledListItem(
          title:
              (verseSelection.isIntro
                      ? 'Intro to ${verseSelection.references.first.book.title()}'
                      : verseSelection.format())
                  .toText(),
          subtitle: SimpleMarkdown(text: note),
        ),
      )
      .toList();
}

extension on VerseSelection {
  bool get isIntro => references.any((reference) => reference.chapterNum == 1 && reference.verseNum == 0);
}
