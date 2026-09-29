import 'package:bible/models/annotation.dart';
import 'package:bible/providers/app_bible_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/pages/notebook_icon.dart';
import 'package:bible/ui/sheets/annotation_sheet.dart';
import 'package:bible/ui/widgets/highlight_style_icon.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class AnnotationListItem extends ConsumerWidget {
  final Annotation annotation;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const AnnotationListItem({super.key, required this.annotation, required this.onNavigateToVerseSelection});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final annotationSelectionText = ref
        .watch(
          annotationSelectionTextProvider(
            selection: annotation.selection,
            translation: user.getTranslationFor(annotation.selection.startingReference.book),
          ),
        )
        .value;

    Future<void> delete() async {
      final confirmed = await context.showStyledDialog(
        (context) => StyledDialog.confirmDelete(
          cancelLabel: t.common.nevermind.toText(),
          title: t.annotationUi.deleteAnnotation.toText(),
          body: t.annotationUi.deleteConfirmation.toText(),
        ),
      );
      if (confirmed == true) {
        ref.updateUser((user) => user.withRemovedAnnotation(annotation));
      }
    }

    return StyledSwipeable(
      key: ValueKey(annotation),
      actions: [.delete(onPressed: delete)],
      child: StyledListItem(
        leading: HighlightStyleIcon(style: annotation.style),
        title: SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            spacing: 8,
            children: [
              annotation.formatLocation().toText(),
              if (annotation.selection case TextAnnotationSelection selection)
                StyledTag.sm(child: selection.textSelection.translation.title().toText()),
              if (annotation.notebookId case final notebookId?)
                if (user.getNotebookById(notebookId) case final notebook?)
                  StyledTag.sm(
                    child: Row(
                      spacing: 4,
                      children: [
                        NotebookIcon(notebook: notebook),
                        notebook.name.toText(),
                      ],
                    ),
                  ),
            ],
          ),
        ),
        subtitle: Column(
          spacing: 4,
          crossAxisAlignment: .start,
          children: [
            StyledLoading(
              child: annotationSelectionText == null
                  ? null
                  : Text(annotationSelectionText, maxLines: 2, overflow: .ellipsis),
            ),
            if (annotation.note.isNotEmpty)
              Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(child: Icon(Symbols.note_stack, size: 16)),
                    TextSpan(text: ' ${annotation.note}'),
                  ],
                ),
                maxLines: 2,
                overflow: .ellipsis,
              ),
          ],
        ),
        thirdLine: t.annotationUi.annotatedTime(time: annotation.createdAt.formatAgo()).toText(),
        trailing: StyledCircleButton.md(
          child: Symbols.more_vert.toIcon(),
          onPressed: () => context.showStyledSheet(
            (sheetContext, _) => StyledSheet(
              title: t.labels.annotation.toText(),
              children: [
                StyledListItem(
                  title: t.common.edit.toText(),
                  leading: Symbols.edit.toIcon(),
                  onPressed: () async {
                    sheetContext.pop();
                    final newAnnotation = await AnnotationSheet.show(
                      context,
                      selection: annotation.selection,
                      annotation: annotation,
                    );
                    if (newAnnotation != null) {
                      ref.updateUser((user) => user.withAnnotationUpdated(annotation, newAnnotation));
                    }
                  },
                ),
                StyledListItem(
                  title: t.common.delete.toText(),
                  leading: Icon(Symbols.delete, color: context.colors.contentCritical),
                  onPressed: () {
                    sheetContext.pop();
                    delete();
                  },
                ),
              ],
            ),
          ),
        ),
        onPressed: () => PassagePreviewPage.show(
          context,
          verseSelection: annotation.selection.toVerseSelection(),
          onNavigateToVerseSelection: onNavigateToVerseSelection,
        ),
      ),
    );
  }
}
