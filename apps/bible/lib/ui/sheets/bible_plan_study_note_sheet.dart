import 'package:bible/models/bible_plan_study_note.dart';
import 'package:bible/ui/widgets/rich_content_view.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class BiblePlanStudyNoteSheet {
  static Future<void> show(
    BuildContext context, {
    required BiblePlanStudyNote note,
    required String planName,
    required int dayIndex,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) => context.showStyledSheetWithBreadcrumbs(breadcrumbText: note.title, (context, ref) {
    void navigateToVerseSelection(VerseSelection verseSelection) {
      // A resource opened from here replaces this sheet in the breadcrumbs.
      if (context.mounted) context.pop();
      onNavigateToVerseSelection(verseSelection);
    }

    return StyledSheet(
      title: note.title.toText(),
      subtitle: '$planName · ${t.biblePlans.day(day: dayIndex + 1)}'.toText(),
      children: [
        SelectionArea(
          child: Padding(
            padding: .all(16),
            child: RichContentList(content: note.body, onNavigateToVerseSelection: navigateToVerseSelection),
          ),
        ),
      ],
    );
  });
}
