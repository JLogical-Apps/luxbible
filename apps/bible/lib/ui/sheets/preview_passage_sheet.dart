import 'package:flutter/material.dart';
import 'package:intersperse/intersperse.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class PreviewPassageSheet {
  static Future<void> show(
    BuildContext context, {
    required VerseSelection verseSelection,
    Function(VerseSelection)? onNavigateToVerseSelection,
  }) => context.showStyledSheet(
    (context, ref) => StyledSheet(
      title: verseSelection.format().toText(),
      children: verseSelection
          .splitByChapter()
          .map<Widget>(
            (selection) => Padding(
              padding: .all(16),
              child: PassageBuilder(
                verseSelection: selection,
                shrinkWrap: true,
                onNavigateToVerseSelection: (selection) {
                  context.pop();
                  onNavigateToVerseSelection?.call(selection);
                },
              ),
            ),
          )
          .intersperse(StyledDivider(height: 2))
          .toList(),
      buttonsBuilder: (context) => [
        StyledRectButton.secondary(
          label: t.biblePlans.readEntireChapter.toText(),
          onPressed: () {
            context.pop();
            PassagePreviewPage.show(
              context,
              verseSelection: verseSelection,
              onNavigateToVerseSelection: (selection) => onNavigateToVerseSelection?.call(selection),
            );
          },
        ),
      ],
    ),
  );
}
