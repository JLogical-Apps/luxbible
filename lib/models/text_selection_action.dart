import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/search_page.dart';
import 'package:bible/ui/sheets/annotation_sheet.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum TextSelectionAction {
  annotate,
  search,
  copy;

  String title() => switch (this) {
    annotate => 'Annotate',
    search => 'Search',
    copy => 'Copy',
  };

  String description() => switch (this) {
    annotate => 'Annotate this text.',
    search => 'Search for other usages of this text in the Bible.',
    copy => 'Copy this text to your clipboard.',
  };

  IconData get icon => switch (this) {
    annotate => Symbols.note_stack,
    search => Symbols.search,
    copy => Symbols.copy_all,
  };

  bool get isNavigation => [annotate, search].contains(this);

  Future<void> onPressed(
    BuildContext context,
    WidgetRef ref, {
    required BibleTextSelection textSelection,
    required Function() onDeselect,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) async {
    final user = ref.read(userProvider);
    final bibles = ref.read(biblesProvider);
    final bible = user.getBible(bibles);

    switch (this) {
      case annotate:
        final annotation = await NewAnnotationSheet.show(
          context,
          ref,
          region: textSelection,
          onAnnotationsRemoved: onDeselect,
        );
        if (annotation != null) {
          onDeselect();
          ref.updateUser((user) => user.withAnnotation(annotation));
        }
      case search:
        final result = await context.push<SearchPageResult>(
          SearchPage(
            initialSearch: bible.getTextSelectionText(textSelection),
            currentChapterReference: textSelection.start.toChapterReference(),
          ),
        );
        if (result != null) {
          onNavigateToVerseSelection(VerseSelection.reference(result.reference));
        }
      case copy:
        onDeselect();
        context.showStyledSnackbar(messageText: 'Text selection copied to clipboard.');
        await Clipboard.setData(ClipboardData(text: bible.getTextSelectionText(textSelection)));
    }
  }
}
