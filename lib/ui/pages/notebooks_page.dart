import 'package:bible/models/color_enum.dart';
import 'package:bible/models/notebook.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/annotations_page.dart';
import 'package:bible/ui/sheets/notebook_sheet.dart';
import 'package:bible/ui/widgets/colored_circle.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class NotebooksPage extends HookConsumerWidget {
  const NotebooksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return StyledPage(
      title: 'Your Notebooks'.toText(),
      body: StyledDock(
        shrinkWrap: false,
        children: [
          ...user.notebooks.isEmpty
              ? [
                  Padding(
                    padding: .symmetric(horizontal: 16),
                    child: StyledTile.message(
                      leading: Symbols.book_2.toIcon(),
                      title: "You haven't created any notebooks. Notebooks let you organize your annotations.".toText(),
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
                              key: ValueKey(notebook.id),
                              leading: ColoredCircle(color: notebook.color.toHue(context.colors).primary),
                              title: notebook.name.toText(),
                              subtitle: getNumAnnotationsText(user: user, notebook: notebook).toText(),
                              trailing: StyledCircleButton.md(
                                child: Symbols.more_vert.toIcon(),
                                onPressed: () => context.showStyledSheet(
                                  (context) => StyledSheet(
                                    title: notebook.name.toText(),
                                    children: [
                                      StyledListItem(
                                        title: 'Edit'.toText(),
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
                                        title: 'Delete'.toText(),
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
                    leading: ColoredCircle(color: ColorEnum.stone.toHue(context.colors).primary),
                    title: 'Default'.toText(),
                    subtitle: getNumAnnotationsText(user: user, notebook: null).toText(),
                    thirdLine: 'The permanent notebook for unassigned annotations.'.toText(),
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
            label: 'Create Notebook'.toText(),
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
    return '$numAnnotations ${numAnnotations == 1 ? 'annotation' : 'annotations'}';
  }

  void showDeleteDialog(BuildContext context, {required Notebook notebook}) async {
    final numAnnotations = ref
        .read(userProvider)
        .annotations
        .where((annotation) => annotation.notebookId == notebook.id)
        .length;

    await context.showStyledDialog(
      (context) => StyledDialog(
        title: 'Delete Notebook'.toText(),
        body: numAnnotations == 0
            ? 'Are you sure you want to delete "${notebook.name}"?'.toText()
            : '"${notebook.name}" has $numAnnotations ${numAnnotations == 1 ? 'annotation' : 'annotations'}. Would you like to delete them too, or keep them in the Default notebook?'
                  .toText(),
        buttonsBuilder: (context) => numAnnotations == 0
            ? [
                StyledRectButton.critical(
                  label: 'Delete'.toText(),
                  onPressed: () {
                    ref.updateUser((user) => user.withRemovedNotebook(notebook.id, deleteAnnotations: true));
                    context.pop();
                  },
                ),
              ]
            : [
                StyledRectButton.primary(
                  label: 'Keep in Default'.toText(),
                  onPressed: () {
                    ref.updateUser((user) => user.withRemovedNotebook(notebook.id, deleteAnnotations: false));
                    context.pop();
                  },
                ),
                StyledRectButton.transparent(
                  label: 'Delete Annotations'.toText(),
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
