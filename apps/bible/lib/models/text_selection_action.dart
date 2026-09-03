import 'package:bible/models/annotation.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/ui/pages/search_page.dart';
import 'package:bible/ui/sheets/annotation_sheet.dart';
import 'package:bible/ui/sheets/copy_sheet.dart';
import 'package:bible/ui/sheets/strong_sheet.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:style/style.dart';

enum TextSelectionAction {
  annotate,
  interlinear,
  search,
  copy;

  String title() => switch (this) {
    annotate => t.selectionActions.annotate,
    interlinear => t.selectionActions.interlinear,
    search => t.selectionActions.search,
    copy => t.selectionActions.copy,
  };

  String description() => switch (this) {
    annotate => t.selectionActions.annotateTextDescription,
    interlinear => t.selectionActions.interlinearTextDescription,
    search => t.selectionActions.searchTextDescription,
    copy => t.selectionActions.copyTextDescription,
  };

  IconData get icon => switch (this) {
    annotate => Symbols.note_stack,
    interlinear => Symbols.dictionary,
    search => Symbols.search,
    copy => Symbols.copy_all,
  };

  bool get isNavigation => [annotate, interlinear, search].has(this);

  Future<void> onPressed(
    BuildContext context, {
    required BibleTextSelection textSelection,
    required Function() onDeselect,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) async {
    switch (this) {
      case interlinear:
        if (!textSelection.translation.isStudy) {
          context.showStyledDialog(
            (context) => StyledDialog.confirm(
              title: t.selectionActions.interlinear.toText(),
              body: t.selectionActions.interlinearUnavailable.toText(),
            ),
          );
          return;
        }

        final studyWords = await ref.read(
          textSelectionWordsProvider(selection: textSelection, translation: textSelection.translation).future,
        );
        if (!context.mounted) return;

        final interlinearWords = studyWords.where((word) => word.data != null).toList();
        if (interlinearWords.isEmpty) {
          context.showStyledSnackbar(message: t.selectionActions.noInterlinearWords.toText());
          return;
        }

        if (interlinearWords.length == 1) {
          final word = interlinearWords.first;
          await StrongSheet.showWithBreadcrumbs(
            context,
            word: word,
            strongId: word.data?.strongId,
            onNavigateToVerseSelection: onNavigateToVerseSelection,
          );
        } else {
          await context.showStyledSheetWithBreadcrumbs(
            breadcrumbText: (await ref.read(textSelectionTextProvider(textSelection).future)).withLength(24),
            (context, _) => StyledSheet(
              title: t.selectionActions.interlinear.toText(),
              subtitle: t.selectionActions
                  .textInReference(reference: textSelection.toVerseSelection().format())
                  .toText(),
              children: interlinearWords
                  .map(
                    (word) => InterlinearWordTile(
                      word: word,
                      data: word.data!,
                      direction: .reverse,
                      onNavigateToVerseSelection: onNavigateToVerseSelection,
                    ),
                  )
                  .toList(),
            ),
          );
        }
      case annotate:
        final annotation = await NewAnnotationSheet.show(
          context,
          selection: AnnotationSelection.text(textSelection: textSelection),
          onAnnotationsRemoved: onDeselect,
        );
        if (annotation != null) {
          onDeselect();
          ref.updateUser((user) => user.withAnnotation(annotation));
        }
      case search:
        final text = await ref.read(textSelectionTextProvider(textSelection).future);

        if (!context.mounted) return;

        final result = await context.push(
          (context) =>
              SearchPage(initialSearch: text, currentChapterReference: textSelection.start.toChapterReference()),
        );
        if (result != null) {
          onNavigateToVerseSelection(result.selection);
        }
      case copy:
        final rootContext = context.rootContext;

        final text = await ref.read(textSelectionTextProvider(textSelection).future);
        onDeselect();

        if (!context.mounted) return;
        context.showStyledSnackbar(
          message: t.selectionActions.copiedText.toText(),
          action: StyledTextAction(
            label: 'Edit'.toText(),
            onPressed: () => CopySheet.show(
              rootContext,
              text: text,
              isTextSelection: true,
              translation: textSelection.translation,
              selection: textSelection.toVerseSelection(),
            ),
          ),
        );
        await Clipboard.setData(ClipboardData(text: text));
    }
  }
}
