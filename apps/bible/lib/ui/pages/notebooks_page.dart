import 'package:bible/models/notebook.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/notebook_file_service.dart';
import 'package:bible/ui/pages/annotations_page.dart';
import 'package:bible/ui/widgets/notebook_icon.dart';
import 'package:bible/ui/sheets/notebook_import_sheet.dart';
import 'package:bible/ui/sheets/notebook_sheet.dart';
import 'package:bible/ui/widgets/notebook_file_list_items.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class NotebooksPage extends HookConsumerWidget implements StyledRoute<VerseSelection> {
  const NotebooksPage({super.key});

  @override
  String get path => '/notebooks';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return StyledPage(
      title: t.notebookUi.yourNotebooks.toText(),
      trailing: StyledCircleButton.md(child: Symbols.more_vert.toIcon(), onPressed: () => showPageMenu(context)),
      body: StyledDock(
        shrinkWrap: false,
        children: [
          if (user.notebooks.isNotEmpty) ...[
            StyledReorderableList(
              shrinkWrap: true,
              children: user.notebooks
                  .map(
                    (notebook) => StyledSwipeable(
                      key: ValueKey(notebook.id),
                      actions: [.delete(onPressed: () => showDeleteDialog(context, notebook: notebook))],
                      child: StyledListItem(
                        leading: NotebookIcon(notebook: notebook),
                        title: buildNotebookTitle(user: user, notebook: notebook),
                        subtitle: getNumAnnotationsText(user: user, notebook: notebook).toText(),
                        trailing: StyledCircleButton.md(
                          child: Symbols.more_vert.toIcon(),
                          onPressed: () => showNotebookMenu(context, notebook: notebook),
                        ),
                        onPressed: () => openNotebook(context, notebook: notebook),
                      ),
                    ),
                  )
                  .toList(),
              onReorder: (oldIndex, newIndex) =>
                  ref.updateUser((user) => user.withReorderedNotebooks(oldIndex, newIndex)),
            ),
            Padding(padding: .only(left: 64), child: StyledDivider()),
          ],
          StyledListItem(
            leading: NotebookIcon(notebook: null),
            title: buildNotebookTitle(user: user, notebook: null),
            subtitle: getNumAnnotationsText(user: user, notebook: null).toText(),
            thirdLine: t.notebookUi.defaultDescription.toText(),
            trailing: StyledCircleButton.md(
              child: Symbols.more_vert.toIcon(),
              onPressed: () => showNotebookMenu(context, notebook: null),
            ),
            onPressed: () => openNotebook(context, notebook: null),
          ),
        ],
        buttonsBuilder: (context) => [
          StyledRectButton.secondary(
            label: t.notebookUi.create.toText(),
            onPressed: () async {
              final notebook = await NotebookSheet.show(context);
              if (notebook != null) {
                ref.updateUser((user) => user.withNewNotebook(notebook));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildNotebookTitle({required User user, required Notebook? notebook}) => Row(
    spacing: 8,
    children: [
      if (notebook == null) Icon(Symbols.lock, size: 16),
      Flexible(child: (notebook?.name ?? t.common.defaultLabel).toText()),
      if (!user.isNotebookVisible(notebook?.id))
        StyledTag.sm(leading: Symbols.visibility_off.toIcon(), child: t.notebookUi.hidden.toText()),
    ],
  );

  Future<void> openNotebook(BuildContext context, {required Notebook? notebook}) async {
    final result = await context.push(AnnotationsPage(initialNotebookId: (notebook?.id,)));
    if (result != null && context.mounted) {
      context.pop(result);
    }
  }

  void showNotebookMenu(BuildContext context, {required Notebook? notebook}) => context.showStyledSheet((context, ref) {
    final isVisible = ref.watch(userProvider).isNotebookVisible(notebook?.id);
    return StyledSheet(
      title: (notebook?.name ?? t.common.defaultLabel).toText(),
      children: [
        StyledListItem(
          title: (isVisible ? t.common.hide : t.common.show).toText(),
          subtitle: (isVisible ? t.notebookUi.hideDescription : t.notebookUi.showDescription).toText(),
          leading: (isVisible ? Symbols.visibility_off : Symbols.visibility).toIcon(),
          onPressed: () {
            context.pop();
            ref.updateUser((user) => user.withNotebookVisible(notebook?.id, isVisible: !isVisible));
          },
        ),
        if (notebook != null)
          StyledListItem(
            title: t.common.edit.toText(),
            leading: Symbols.edit.toIcon(),
            onPressed: () async {
              context.pop();
              final edited = await NotebookSheet.show(context, initialNotebook: notebook);
              if (edited != null) {
                ref.updateUser((user) => user.withUpdatedNotebook(edited));
              }
            },
          ),
        NotebookShareListItem(notebook: notebook),
        NotebookDownloadListItem(notebook: notebook),
        if (notebook != null)
          StyledListItem(
            title: t.common.delete.toText(),
            leading: Icon(Symbols.delete, color: context.colors.contentCritical),
            onPressed: () {
              context.pop();
              showDeleteDialog(context, notebook: notebook);
            },
          ),
      ],
    );
  });

  void showPageMenu(BuildContext context) => context.showStyledSheet(
    (sheetContext, _) => StyledSheet(
      title: t.notebookUi.yourNotebooks.toText(),
      children: [
        StyledListItem(
          leading: Symbols.file_open.toIcon(),
          title: t.notebookUi.importNotebook.toText(),
          subtitle: t.notebookUi.importNotebookDescription.toText(),
          onPressed: () {
            sheetContext.pop();
            importNotebookFile(context);
          },
        ),
      ],
    ),
  );

  Future<void> importNotebookFile(BuildContext context) async {
    final String contents;
    try {
      final file = await openFile(
        acceptedTypeGroups: [
          XTypeGroup(
            label: t.notebookUi.notebookFile,
            extensions: [NotebookFileService.fileExtension],
            mimeTypes: [NotebookFileService.mimeType, 'application/json', 'application/octet-stream'],
            uniformTypeIdentifiers: [NotebookFileService.uniformTypeIdentifier],
          ),
        ],
      );
      if (file == null) return;
      contents = await file.readAsString();
    } catch (_) {
      if (context.mounted) await NotebookImportSheet.showInvalidFileDialog(context);
      return;
    }

    if (context.mounted) await NotebookImportSheet.showForContents(context, contents);
  }

  String getNumAnnotationsText({required User user, required Notebook? notebook}) =>
      t.annotationUi.annotationCount(count: user.getNotebookAnnotations(notebook?.id).length);

  void showDeleteDialog(BuildContext context, {required Notebook notebook}) async {
    final numAnnotations = ref
        .read(userProvider)
        .annotations
        .where((annotation) => annotation.notebookId == notebook.id)
        .length;

    await context.showStyledDialog(
      (context) => StyledDialog(
        title: t.notebookUi.delete.toText(),
        body: numAnnotations == 0
            ? t.notebookUi.deleteNamedConfirmation(name: notebook.name).toText()
            : t.notebookUi
                  .deleteWithAnnotations(
                    name: notebook.name,
                    annotations: t.annotationUi.annotationCount(count: numAnnotations),
                  )
                  .toText(),
        buttonsBuilder: (context) => numAnnotations == 0
            ? [
                StyledRectButton.critical(
                  label: t.common.delete.toText(),
                  onPressed: () {
                    ref.updateUser((user) => user.withRemovedNotebook(notebook.id, deleteAnnotations: true));
                    context.pop();
                  },
                ),
              ]
            : [
                StyledRectButton.primary(
                  label: t.notebookUi.keepInDefault.toText(),
                  onPressed: () {
                    ref.updateUser((user) => user.withRemovedNotebook(notebook.id, deleteAnnotations: false));
                    context.pop();
                  },
                ),
                StyledRectButton.transparent(
                  label: t.notebookUi.deleteAnnotations.toText(),
                  isCritical: true,
                  onPressed: () {
                    ref.updateUser((user) => user.withRemovedNotebook(notebook.id, deleteAnnotations: true));
                    context.pop();
                  },
                ),
              ],
      ),
    );
  }
}
