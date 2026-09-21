import 'package:bible/models/annotation.dart';
import 'package:bible/models/reference/region_type.dart';
import 'package:bible/models/study_panel.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/sheets/annotation_sheet.dart';
import 'package:bible/ui/sheets/copy_sheet.dart';
import 'package:bible/ui/sheets/study_sheet.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:style/style.dart';

enum VerseSelectionAction {
  annotate,
  study,
  share,
  copy;

  String title() => switch (this) {
    annotate => t.selectionActions.annotate,
    study => t.selectionActions.study,
    share => t.selectionActions.share,
    copy => t.selectionActions.copy,
  };

  String description() => switch (this) {
    annotate => t.selectionActions.annotateVersesDescription,
    study => t.selectionActions.studyVersesDescription,
    share => t.selectionActions.shareVersesDescription,
    copy => t.selectionActions.copyVersesDescription,
  };

  IconData get icon => switch (this) {
    annotate => Symbols.note_stack,
    study => Symbols.school,
    share => Symbols.ios_share,
    copy => Symbols.copy_all,
  };

  bool get isNavigation => [annotate, study].has(this);

  Future<void> onPressed(
    BuildContext context, {
    required VerseSelection selectedVerseSelection,
    required Function() onDeselect,
    required Function(VerseSelection) onNavigateToVerseSelection,
    Function(StudyPanel)? onAddStudyPanel,
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
        final rootContext = context.rootContext;

        final user = ref.read(userProvider);
        final text = await ref.read(
          verseSelectionTextProvider(selection: selectedVerseSelection, translation: user.translation).future,
        );
        final copy = CopySheet.getCopyText(
          text: text.trim(),
          isTextSelection: false,
          translation: user.translation,
          selection: selectedVerseSelection,
          useReference: user.translation.isOnline,
          useTranslation: user.translation.isOnline,
        );

        if (!context.mounted) return;

        onDeselect();
        context.showStyledSnackbar(
          message: t.selectionActions.copiedVerses(reference: selectedVerseSelection.format()).toText(),
          action: StyledTextAction(
            label: t.common.edit.toText(),
            onPressed: () => CopySheet.show(
              rootContext,
              text: text.trim(),
              isTextSelection: false,
              translation: user.translation,
              selection: selectedVerseSelection,
            ),
          ),
        );
        await Clipboard.setData(ClipboardData(text: copy));

      case share:
        final renderObject = context.findRenderObject();
        final origin = renderObject is RenderBox ? renderObject.localToGlobal(.zero) & renderObject.size : null;
        await SharePlus.instance.share(
          ShareParams(
            uri: Uri.https('app.luxbible.app', '/passage/${selectedVerseSelection.osisId()}'),
            sharePositionOrigin: origin,
          ),
        );

      case study:
        StudySheet.show(
          context,
          regionFormat: selectedVerseSelection.format(),
          verseSelection: selectedVerseSelection,
          regionType: RegionType.verses,
          onNavigateToVerseSelection: onNavigateToVerseSelection,
          onAddStudyPanel: onAddStudyPanel,
        );
    }
  }
}
