import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/chapter_preview_page.dart';
import 'package:bible/ui/widgets/passage_builder.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intersperse/intersperse.dart';

class PreviewPassageSheet {
  static Future<void> show(
    BuildContext context, {
    required VerseSelection verseSelection,
    Function(VerseSelection)? onNavigateToVerseSelection,
  }) => context.showStyledSheet(
    (context) => StyledSheet(
      title: verseSelection.format().toText(),
      children: verseSelection
          .splitByChapter()
          .map<Widget>(
            (selection) => Padding(
              padding: .all(16),
              child: PassageBuilder(verseSelection: selection, onNavigateToVerseSelection: onNavigateToVerseSelection),
            ),
          )
          .intersperse(StyledDivider(height: 2))
          .toList(),
      buttonsBuilder: (context) => [
        StyledRectButton.secondary(
          label: t.biblePlans.readEntireChapter.toText(),
          onPressed: () {
            context.pop();
            ChapterPreviewPage.show(
              context,
              verseSelection: verseSelection,
              onNavigateToPassage: () => onNavigateToVerseSelection?.call(verseSelection),
            );
          },
        ),
      ],
    ),
  );
}
