import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/selection.dart';
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

enum SelectionAction {
  annotate,
  search,
  copy;

  String title() => switch (this) {
    annotate => 'Annotate',
    search => 'Search',
    copy => 'Copy',
  };

  String description() => switch (this) {
    annotate => 'Annotate the selection.',
    search => 'Search for other usages of the selection in the Bible.',
    copy => 'Copy the selection to your clipboard.',
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
    required Selection selection,
    required Function() onDeselect,
    required Function(Passage) onNavigateToPassage,
  }) async {
    final user = ref.read(userProvider);
    final displayBibles = ref.read(displayBiblesProvider);
    final bible = user.getDisplayBible(displayBibles);

    switch (this) {
      case annotate:
        final annotation = await AnnotationSheet.show(
          context,
          ref,
          region: selection,
          onAnnotationsRemoved: onDeselect,
        );
        if (annotation != null) {
          onDeselect();
          ref.updateUser((user) => user.withAnnotation(annotation));
        }
      case search:
        final result =
            await context.push(
                  SearchPage(
                    initialSearch: bible.getSelectionText(selection),
                    currentChapterReference: selection.start.toChapterReference(),
                  ),
                )
                as SearchPageResult?;
        if (result != null) {
          onNavigateToPassage(Passage.reference(result.reference));
        }
      case copy:
        onDeselect();
        context.showStyledSnackbar(messageText: 'Selection copied to clipboard.');
        await Clipboard.setData(ClipboardData(text: bible.getSelectionText(selection)));
    }
  }
}
