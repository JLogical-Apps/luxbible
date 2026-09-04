import 'package:bible/models/notebook.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/pages/annotations_page.dart';
import 'package:bible/ui/pages/notebook_icon.dart';
import 'package:bible/ui/sheets/notebook_sheet.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
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
      body: StyledDock(
        shrinkWrap: false,
        children: [
          ...user.notebooks.isEmpty
              ? [
                  SafeArea(
                    child: Padding(
                      padding: .symmetric(horizontal: 16),
                      child: StyledTile.message(
                        leading: Symbols.book_2.toIcon(),
                        title: t.emptyStates.noNotebooks.toText(),
                      ),
                    ),
                  ),
                ]
              : [
                  StyledReorderableList(
                    shrinkWrap: true,
                    children: user.notebooks
                        .map(
                          (notebook) => StyledSwipeable(
                            key: ValueKey(notebook.id),
                            actions: [.delete(onPressed: () => showDeleteDialog(context, notebook: notebook))],
                            child: StyledListItem(
                              leading: NotebookIcon(notebook: notebook),
                              title: Row(
                                spacing: 8,
                                children: [
                                  notebook.name.toText(),
                                  if (!notebook.isVisible)
                                    StyledTag.sm(
                                      leading: Symbols.visibility_off.toIcon(),
                                      child: t.notebookUi.hidden.toText(),
                                    ),
                                ],
                              ),
                              subtitle: getNumAnnotationsText(user: user, notebook: notebook).toText(),
                              trailing: StyledCircleButton.md(
                                child: Symbols.more_vert.toIcon(),
                                onPressed: () => context.showStyledSheet(
                                  (context, _) => StyledSheet(
                                    title: notebook.name.toText(),
                                    children: [
                                      if (notebook.isVisible)
                                        StyledListItem(
                                          title: t.common.hide.toText(),
                                          subtitle: t.notebookUi.hideDescription.toText(),
                                          leading: Symbols.visibility_off.toIcon(),
                                          onPressed: () {
                                            context.pop();
                                            ref.updateUser(
                                              (user) => user.withUpdatedNotebook(notebook.copyWith(isVisible: false)),
                                            );
                                          },
                                        )
                                      else
                                        StyledListItem(
                                          title: t.common.show.toText(),
                                          subtitle: t.notebookUi.showDescription.toText(),
                                          leading: Symbols.visibility.toIcon(),
                                          onPressed: () {
                                            context.pop();
                                            ref.updateUser(
                                              (user) => user.withUpdatedNotebook(notebook.copyWith(isVisible: true)),
                                            );
                                          },
                                        ),
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
                                      StyledListItem(
                                        title: t.common.delete.toText(),
                                        leading: Icon(Symbols.delete, color: context.colors.contentCritical),
                                        onPressed: () {
                                          context.pop();
                                          showDeleteDialog(context, notebook: notebook);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                final result = await context.push(AnnotationsPage(initialNotebookId: (notebook.id,)));
                                if (result != null && context.mounted) {
                                  context.pop(result);
                                }
                              },
                            ),
                          ),
                        )
                        .toList(),
                    onReorder: (oldIndex, newIndex) =>
                        ref.updateUser((user) => user.withReorderedNotebooks(oldIndex, newIndex)),
                  ),
                  Padding(padding: .only(left: 64), child: StyledDivider()),
                  StyledListItem(
                    leading: NotebookIcon(notebook: null),
                    title: t.common.defaultLabel.toText(),
                    subtitle: getNumAnnotationsText(user: user, notebook: null).toText(),
                    thirdLine: t.notebookUi.defaultDescription.toText(),
                    trailing: Symbols.lock.toIcon(),
                    onPressed: () async {
                      final result = await context.push(AnnotationsPage(initialNotebookId: (null,)));
                      if (result != null && context.mounted) {
                        context.pop(result);
                      }
                    },
                  ),
                ],
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

  String getNumAnnotationsText({required User user, required Notebook? notebook}) {
    final numAnnotations = user.annotations
        .where((annotation) => user.getNotebookById(annotation.notebookId)?.id == notebook?.id)
        .length;
    return t.annotationUi.annotationCount(count: numAnnotations);
  }

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
