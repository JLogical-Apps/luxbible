import 'package:bible/models/reference/region.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/sheets/annotation_sheet.dart';
import 'package:bible/ui/sheets/study_sheet.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum VerseSelectionAction {
  annotate,
  study,
  copy;

  String title() => switch (this) {
    annotate => 'Annotate',
    study => 'Study',
    copy => 'Copy',
  };

  String description() => switch (this) {
    annotate => 'Annotate these verses.',
    study => 'Study these verses.',
    copy => 'Copy these verses to your clipboard.',
  };

  IconData get icon => switch (this) {
    annotate => Symbols.note_stack,
    study => Symbols.school,
    copy => Symbols.copy_all,
  };

  bool get isNavigation => [annotate, study].contains(this);

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required VerseSelection selectedVerseSelection,
    required Function() onDeselect,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) async {
    final user = ref.read(userProvider);
    final displayBibles = ref.read(displayBiblesProvider);
    final bible = user.getDisplayBible(displayBibles);

    switch (this) {
      case annotate:
        final annotation = await NewAnnotationSheet.show(
          context,
          ref,
          region: selectedVerseSelection,
          onAnnotationsRemoved: onDeselect,
        );
        if (annotation != null) {
          onDeselect();
          ref.updateUser((user) => user.withAnnotation(annotation));
        }
      case copy:
        onDeselect();
        context.showStyledSnackbar(messageText: '${selectedVerseSelection.format()} copied to clipboard.');
        await Clipboard.setData(
          ClipboardData(
            text: selectedVerseSelection.references
                .map((reference) => bible.getVerseByReference(reference)?.text)
                .nonNulls
                .join(),
          ),
        );
      case study:
        StudySheet.show(
          context,
          ref,
          region: selectedVerseSelection,
          regionType: RegionType.verses,
          onNavigateToVerseSelection: onNavigateToVerseSelection,
        );
    }
  }
}
