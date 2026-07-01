import 'package:bible/models/commentary_type.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/commentaries_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/simple_markdown.dart';
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
      final relatedCommentary = commentaries[commentary]?.getNotesFor(verseSelection);
      return relatedCommentary == null || relatedCommentary.isEmpty
          ? [
              Padding(
                padding: .all(16),
                child: StyledBanner(message: 'No Commentaries Found'.toText()),
              ),
            ]
          : relatedCommentary
                .mapToIterable(
                  (verseSelection, note) => StyledListItem(
                    title: verseSelection.format().toText(),
                    subtitle: SimpleMarkdown(text: note),
                  ),
                )
                .toList();
    }

    final relatedCommentaries = commentaries
        .where((type, commentary) => user.commentariesOrDefault.contains(type))
        .mapValues((type, commentary) => commentary.getNotesFor(verseSelection))
        .where((type, notes) => notes.isNotEmpty);

    return relatedCommentaries.isEmpty
        ? [
            Padding(
              padding: .all(16),
              child: StyledBanner(message: 'No Commentaries Found'.toText()),
            ),
          ]
        : relatedCommentaries
              .mapToIterable(
                (type, notes) => StyledStickyHeader(
                  title: type.title().toText(),
                  children: notes
                      .mapToIterable(
                        (verseSelection, note) => StyledListItem(
                          title: verseSelection.format().toText(),
                          subtitle: SimpleMarkdown(text: note),
                        ),
                      )
                      .toList(),
                ),
              )
              .toList();
  }
}
