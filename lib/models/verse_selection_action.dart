import 'package:bible/models/annotation.dart';
import 'package:bible/models/reference/region_type.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/sheets/annotation_sheet.dart';
import 'package:bible/ui/sheets/study_sheet.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    BuildContext context, {
    required VerseSelection selectedVerseSelection,
    required Function() onDeselect,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) async {
    switch (this) {
      case annotate:
        final annotation = await NewAnnotationSheet.show(
          context,
          selection: AnnotationSelection.verses(verseSelection: selectedVerseSelection),
          onAnnotationsRemoved: onDeselect,
        );
        if (annotation != null) {
          onDeselect();
          ref.updateUser((user) => user.withAnnotation(annotation));
          ref.markOnboardingStep(.annotateVerse);
        }
      case copy:
        final user = ref.read(userProvider);
        final text = await ref.read(
          verseSelectionTextProvider(selection: selectedVerseSelection, translation: user.translation).future,
        );

        if (!context.mounted) return;

        onDeselect();
        context.showStyledSnackbar(message: '${selectedVerseSelection.format()} copied to clipboard.'.toText());
        await Clipboard.setData(
          ClipboardData(text: selectedVerseSelection.references.map((reference) => text).nonNulls.join()),
        );
      case study:
        StudySheet.show(
          context,
          regionFormat: selectedVerseSelection.format(),
          verseSelection: selectedVerseSelection,
          regionType: RegionType.verses,
          onNavigateToVerseSelection: onNavigateToVerseSelection,
        );
    }
  }
}
