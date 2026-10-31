import 'package:bible/models/notebook_file.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/notebook_file_service.dart';
import 'package:bible/ui/pages/annotations_page.dart';
import 'package:bible/ui/widgets/notebook_icon.dart';
import 'package:bible/ui/widgets/annotation_list_item.dart';
import 'package:bible/ui/widgets/highlight_style_icon.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class NotebookImportSheet {
  static Future<void> showForContents(BuildContext context, String contents) async {
    if (NotebookFileService.decode(contents) case final file?) {
      await show(context, file: file);
    } else {
      await showInvalidFileDialog(context);
    }
  }

  static Future<void> showInvalidFileDialog(BuildContext context) => context.showStyledDialog(
    (context) =>
        StyledDialog.confirm(title: t.notebookUi.invalidFileTitle.toText(), body: t.notebookUi.invalidFile.toText()),
  );

  static Future<void> show(BuildContext context, {required NotebookFile file}) {
    final user = ref.read(userProvider);
    final newNotebook = file.toNewNotebook(user);
    final matchingNotebookId = user.getNotebookById(file.id)?.id;

    return context.showStyledSheetWithBreadcrumbs(
      breadcrumbText: t.notebookUi.importNotebook,
      path: '/notebooks/import',
      (context, ref) {
        final user = ref.watch(userProvider);
        final targetState = useSheetState<NotebookImportTarget>(
          () => matchingNotebookId == null ? .newNotebook(newNotebook) : .existing(matchingNotebookId),
        );
        final target = targetState.value;
        final import = NotebookImport.of(file, target: target, user: user);

        return StyledSheet(
          title: t.notebookUi.importNotebook.toText(),
          children: [
            Padding(
              padding: .all(16),
              child: StyledTile(
                child: StyledListItem(
                  leading: NotebookIcon(notebook: newNotebook),
                  title: file.name.toText(),
                  subtitle: t.annotationUi.annotationCount(count: file.annotations.length).toText(),
                ),
              ),
            ),
            StyledSection(
              title: t.notebookUi.importInto.toText(),
              padding: .only(top: 12),
              children: [
                StyledListItem.radio(
                  leading: Symbols.add.toIcon(),
                  title: t.notebookUi.newNotebook.toText(),
                  subtitle: t.notebookUi.newNotebookDescription(name: file.name).toText(),
                  isSelected: target is NewNotebookImportTarget,
                  onSelected: () => targetState.value = .newNotebook(newNotebook),
                ),
                ...[...user.notebooks, null].map(
                  (notebook) => StyledListItem.radio(
                    leading: NotebookIcon(notebook: notebook),
                    title: (notebook?.name ?? t.common.defaultLabel).toText(),
                    subtitle: t.annotationUi
                        .annotationCount(count: user.getNotebookAnnotations(notebook?.id).length)
                        .toText(),
                    isSelected: target == .existing(notebook?.id),
                    onSelected: () => targetState.value = .existing(notebook?.id),
                  ),
                ),
              ],
            ),
          ],
          buttonsBuilder: (context) => [
            StyledRectButton.primary(
              label:
                  (import.changeCount == 0
                          ? t.notebookUi.noNewChanges
                          : t.notebookUi.previewChanges(count: import.changeCount))
                      .toText(),
              onPressed: import.changeCount == 0 ? null : () => showPreview(context, file: file, target: target),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showPreview(
    BuildContext context, {
    required NotebookFile file,
    required NotebookImportTarget target,
  }) => context.showStyledSheetWithBreadcrumbs(breadcrumbText: t.labels.preview, path: '/notebooks/import/preview', (
    context,
    ref,
  ) {
    final user = ref.watch(userProvider);
    final import = NotebookImport.of(file, target: target, user: user);
    final (notebook, notebookName, tag, existingAnnotationCount) = switch (target) {
      NewNotebookImportTarget(:final notebook) => (notebook, notebook.name, t.notebookUi.newTag, 0),
      ExistingNotebookImportTarget(:final notebookId) => (
        user.getNotebookById(notebookId),
        user.getNotebookById(notebookId)?.name ?? t.common.defaultLabel,
        t.notebookUi.baseTag,
        user.getNotebookAnnotations(notebookId).length,
      ),
    };

    return StyledSheet(
      title: t.labels.preview.toText(),
      children: [
        Padding(
          padding: .only(left: 16, top: 16, right: 16),
          child: StyledTile(
            child: StyledListItem(
              leading: NotebookIcon(notebook: notebook),
              title: Row(
                spacing: 8,
                children: [
                  Flexible(child: notebookName.toText()),
                  StyledTag.sm(colorBuilder: target is NewNotebookImportTarget ? .primary : null, child: tag.toText()),
                ],
              ),
              subtitle: t.annotationUi
                  .annotationCount(count: existingAnnotationCount + import.annotations.length)
                  .toText(),
            ),
          ),
        ),
        if (import.highlightStyles.isNotEmpty)
          StyledSection(
            title: t.notebookUi.newHighlightStyles.toText(),
            padding: .only(top: 24),
            children: import.highlightStyles
                .map(
                  (entry) => StyledListItem(
                    leading: HighlightStyleIcon(style: entry.$1),
                    title: entry.$2.toText(),
                  ),
                )
                .toList(),
          ),
        if (import.annotations.isNotEmpty)
          StyledSection(
            title: (target is NewNotebookImportTarget ? t.labels.annotations : t.notebookUi.newAnnotations).toText(),
            padding: .only(top: 24),
            children: import.annotations
                .sorted(AnnotationSort.location.comparator)
                .map((annotation) => AnnotationListItem.preview(annotation: annotation))
                .toList(),
          ),
      ],
      buttonsBuilder: (context) => [
        StyledRectButton.primary(
          label: t.notebookUi.importAction.toText(),
          onPressed: () {
            final rootContext = context.rootContext;
            ref.updateUser((user) => user.withNotebookImport(import));
            context.pop();
            rootContext.showStyledSnackbar(message: t.notebookUi.importSucceeded(name: notebookName).toText());
          },
        ),
      ],
    );
  });
}
