import 'package:bible/models/commentary_type.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/providers/commentaries_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/sheets/preview_passage_sheet.dart';
import 'package:bible/ui/widgets/simple_markdown.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:utils_core/utils_core.dart';

class CommentarySheet {
  static List<Widget> buildSheetChildren(
    BuildContext context, {
    required VerseSelection verseSelection,
    required CommentaryType commentary,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) {
    final commentaries = ref.read(commentariesProvider);
    final notes = commentaries[commentary]?.getNotesFor(verseSelection);
    return notes == null || notes.isEmpty
        ? [
            Padding(
              padding: .all(16),
              child: StyledBanner(message: 'No Commentaries Found'.toText()),
            ),
          ]
        : StyledDivider(height: 2).wrapPositioned(
            notes
                .mapToIterable(
                  (verseSelection, note) => StyledStickyHeader.child(
                    title:
                        (verseSelection.isIntro
                                ? 'Intro to ${verseSelection.references.first.book.title()}'
                                : verseSelection.format())
                            .toText(),
                    child: Padding(
                      padding: .only(bottom: 16),
                      child: DefaultTextStyle(
                        style: context.textStyle.paragraphMd,
                        child: SimpleMarkdown(
                          text: note,
                          onLinkPressed: (text, link) => PreviewPassageSheet.show(
                            context,
                            verseSelection: VerseSelection.fromOsisId(link),
                            onNavigateToVerseSelection: onNavigateToVerseSelection,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
  }
}

extension on VerseSelection {
  bool get isIntro => references.any((reference) => reference.chapterNum == 1 && reference.verseNum == 0);
}
