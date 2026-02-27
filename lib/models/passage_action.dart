import 'package:bible/models/bible.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/sheets/annotation_sheet.dart';
import 'package:bible/ui/sheets/study_sheet.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum PassageAction {
  annotate,
  study,
  copy;

  String title() => switch (this) {
    annotate => 'Annotate',
    study => 'Study',
    copy => 'Copy',
  };

  String description() => switch (this) {
    annotate => 'Annotate the selected passage.',
    study => 'Study the selected passage.',
    copy => 'Copy the selected passage to your clipboard.',
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
    required User user,
    required Passage selectedPassage,
    required Bible bible,
    required Function() onDeselect,
  }) async {
    switch (this) {
      case annotate:
        final annotation = await AnnotationSheet.show(
          context,
          ref,
          region: selectedPassage,
          bible: bible,
          user: user,
          onAnnotationsRemoved: onDeselect,
        );
        if (annotation != null) {
          onDeselect();
          ref.updateUser((user) => user.withAnnotation(annotation));
        }
      case copy:
        onDeselect();
        context.showStyledSnackbar(messageText: '${selectedPassage.format()} copied to clipboard.');
        await Clipboard.setData(
          ClipboardData(
            text: selectedPassage.references
                .map((reference) => bible.getVerseByReference(reference)?.text)
                .nonNulls
                .join(),
          ),
        );
      case study:
        StudySheet.show(context, ref, region: selectedPassage, bible: bible, regionType: RegionType.passage);
    }
  }
}
