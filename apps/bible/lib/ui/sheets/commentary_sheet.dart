import 'package:bible/models/commentary_type.dart';
import 'package:bible/providers/commentary_provider.dart';
import 'package:bible/ui/sheets/preview_passage_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class CommentarySheet {
  static List<Widget> buildSheetChildren(
    BuildContext context,
    WidgetRef ref, {
    required VerseSelection verseSelection,
    required CommentaryType commentaryType,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) {
    final commentary = ref.watch(commentaryProvider(type: commentaryType)).value;
    if (commentary == null) {
      return [Padding(padding: .all(16), child: StyledLoading())];
    }

    final notes = commentary.getNotesFor(verseSelection);
    return notes.isEmpty
        ? [
            Padding(
              padding: .all(16),
              child: StyledBanner(message: t.emptyStates.noCommentaries.toText()),
            ),
          ]
        : StyledDivider(height: 2).wrapPositioned(
            notes
                .mapToIterable(
                  (verseSelection, note) => StyledStickyHeader.child(
                    title:
                        (verseSelection.isIntro
                                ? t.commentaryUi.introTo(book: verseSelection.references.first.book.title())
                                : verseSelection.format())
                            .toText(),
                    child: Padding(
                      padding: .only(bottom: 16),
                      child: DefaultTextStyle(
                        style: context.textStyle.paragraphMd,
                        child: MarkdownBuilder(
                          note,
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
