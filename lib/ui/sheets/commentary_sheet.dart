import 'package:bible/models/commentary_type.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/providers/commentaries_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:utils_core/utils_core.dart';

class CommentarySheet {
  static List<Widget> buildSheetChildren(
    BuildContext context, {
    required VerseSelection verseSelection,
    CommentaryType? commentary,
  }) {
    final commentaries = ref.read(commentariesProvider);
    if (commentary != null) {
      final relatedCommentary = commentaries.firstWhereOrNull((c) => c.type == commentary)?.getNotesFor(verseSelection);
      return relatedCommentary == null || relatedCommentary.isEmpty
          ? [
              Padding(
                padding: .all(16),
                child: StyledBanner(message: 'No Commentaries Found'.toText()),
              ),
            ]
          : relatedCommentary
                .mapToIterable(
                  (verseSelection, note) =>
                      StyledListItem(title: verseSelection.format().toText(), subtitle: note.toText()),
                )
                .toList();
    }

    final relatedCommentaries = commentaries
        .mapToMap((commentary) => MapEntry(commentary, commentary.getNotesFor(verseSelection)))
        .where((commentary, notes) => notes.isNotEmpty);
    return relatedCommentaries.isEmpty
        ? [
            Padding(
              padding: .all(16),
              child: StyledBanner(message: 'No Commentaries Found'.toText()),
            ),
          ]
        : relatedCommentaries
              .mapToIterable(
                (commentary, notes) => StyledStickyHeader(
                  title: commentary.type.title().toText(),
                  children: notes
                      .mapToIterable(
                        (verseSelection, note) =>
                            StyledListItem(title: verseSelection.format().toText(), subtitle: note.toText()),
                      )
                      .toList(),
                ),
              )
              .toList();
  }
}
