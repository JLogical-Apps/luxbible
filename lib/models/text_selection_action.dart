import 'package:bible/models/annotation.dart';
import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/search_page.dart';
import 'package:bible/ui/sheets/annotation_sheet.dart';
import 'package:bible/ui/sheets/strong_sheet.dart';
import 'package:bible/ui/widgets/interlinear_word_tile.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum TextSelectionAction {
  annotate,
  interlinear,
  search,
  copy;

  String title() => switch (this) {
    annotate => 'Annotate',
    interlinear => 'Interlinear',
    search => 'Search',
    copy => 'Copy',
  };

  String description() => switch (this) {
    annotate => 'Annotate this text.',
    interlinear => 'View a lexical breakdown of this text using Strongs.',
    search => 'Search for other usages of this text in the Bible.',
    copy => 'Copy this text to your clipboard.',
  };

  IconData get icon => switch (this) {
    annotate => Symbols.note_stack,
    interlinear => Symbols.dictionary,
    search => Symbols.search,
    copy => Symbols.copy_all,
  };

  bool get isNavigation => [annotate, interlinear, search].contains(this);

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required BibleTextSelection textSelection,
    required Function() onDeselect,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) async {
    switch (this) {
      case interlinear:
        if (textSelection.translation != .bsb) {
          context.showStyledDialog(
            (context) => StyledDialog.confirm(
              title: 'Interlinear'.toText(),
              body:
                  "Interlinear by text selection is only available in the BSB, which was designed with word-for-word Strong's and morphology tagging. Switch your translation to the BSB to use this action."
                      .toText(),
            ),
          );
          return;
        }

        final studyBible = ref.read(studyBibleProvider);
        final studyWords = studyBible.getTextSelectionWords(textSelection).where((word) => word.data != null).toList();
        if (studyWords.isEmpty) {
          context.showStyledSnackbar(messageText: 'No interlinear words found in this selection.');
          return;
        }

        if (studyWords.length == 1) {
          final word = studyWords.first;
          await StrongSheet.showWithContext(
            context,
            ref,
            word: word,
            strongId: word.data?.strongId,
            onNavigateToVerseSelection: onNavigateToVerseSelection,
          );
        } else {
          await context.showStyledSheet(
            (context) => StyledSheet(
              title: 'Interlinear'.toText(),
              subtitle: 'Text in ${textSelection.toVerseSelection().format()}'.toText(),
              children: studyWords
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
          ref,
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

        final result = await context.push<SearchPageResult>(
          SearchPage(initialSearch: text, currentChapterReference: textSelection.start.toChapterReference()),
        );
        if (result != null) {
          onNavigateToVerseSelection(VerseSelection.reference(result.reference));
        }
      case copy:
        final text = await ref.read(textSelectionTextProvider(textSelection).future);
        onDeselect();

        if (!context.mounted) return;
        context.showStyledSnackbar(messageText: 'Text selection copied to clipboard.');
        await Clipboard.setData(ClipboardData(text: text));
    }
  }
}
