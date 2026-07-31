import 'package:bible/models/highlight_style.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/annotations_page.dart';
import 'package:bible/ui/sheets/highlight_style_sheet.dart';
import 'package:bible/ui/widgets/highlight_style_icon.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class HighlightStylesPage extends HookConsumerWidget {
  const HighlightStylesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return StyledPage(
      title: t.highlightStyleUi.yourStyles.toText(),
      body: StyledDock(
        shrinkWrap: false,
        children: [
          StyledReorderableList(
            shrinkWrap: true,
            onReorder: (oldIndex, newIndex) =>
                ref.updateUser((user) => user.withReorderedHighlightStyles(oldIndex, newIndex)),
            children: user.highlightStyles
                .mapIndexed(
                  (index, entry) => StyledSwipeable(
                    key: ValueKey(entry.$1),
                    isEnabled: user.highlightStyles.length > 1,
                    actions: [
                      .delete(
                        onPressed: () => showDeleteDialog(context, index: index, entry: entry),
                      ),
                    ],
                    child: StyledListItem(
                      leading: HighlightStyleIcon(style: entry.$1),
                      title: entry.$2.toText(),
                      subtitle: getNumAnnotationsText(user: user, style: entry.$1).toText(),
                      trailing: StyledCircleButton.md(
                        child: Symbols.more_vert.toIcon(),
                        onPressed: () => context.showStyledSheet(
                          (sheetContext) => StyledSheet(
                            title: entry.$2.toText(),
                            children: [
                              StyledListItem(
                                title: t.common.edit.toText(),
                                leading: Symbols.edit.toIcon(),
                                onPressed: () async {
                                  sheetContext.pop();

                                  final user = ref.read(userProvider);
                                  final edited = await HighlightStyleSheet.show(
                                    context,
                                    initialStyle: entry,
                                    otherStyles: user.highlightStyles.whereNot((other) => other == entry).toList(),
                                  );
                                  if (edited == null) return;

                                  if (edited.$1 == entry.$1) {
                                    ref.updateUser(
                                      (user) => user.withUpdatedHighlightStyle(index, edited, updateAnnotations: false),
                                    );
                                    return;
                                  }

                                  if (!context.mounted) return;
                                  final shouldUpdate = await showUpdateAnnotationsDialog(context, entry: entry);
                                  if (shouldUpdate == null) return;

                                  ref.updateUser(
                                    (user) =>
                                        user.withUpdatedHighlightStyle(index, edited, updateAnnotations: shouldUpdate),
                                  );
                                },
                              ),
                              if (user.highlightStyles.length > 1)
                                StyledListItem(
                                  title: t.common.delete.toText(),
                                  leading: Icon(Symbols.delete, color: context.colors.contentCritical),
                                  onPressed: () {
                                    context.pop();
                                    showDeleteDialog(context, index: index, entry: entry);
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                      onPressed: () async {
                        final result = await context.push(AnnotationsPage(initialStyle: entry.$1));
                        if (result != null && context.mounted) {
                          context.pop(result);
                        }
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ],
        buttonsBuilder: (context) => [
          StyledRectButton.secondary(
            label: t.highlightStyleUi.create.toText(),
            onPressed: () async {
              final style = await HighlightStyleSheet.show(context, otherStyles: user.highlightStyles);
              if (style != null) {
                ref.updateUser((user) => user.withNewHighlightStyle(style));
              }
            },
          ),
        ],
      ),
    );
  }

  String getNumAnnotationsText({required User user, required HighlightStyle style}) {
    final numAnnotations = user.annotations.where((annotation) => annotation.style == style).length;
    return t.annotationUi.annotationCount(count: numAnnotations);
  }

  void showDeleteDialog(
    BuildContext context, {
    required int index,
    required (HighlightStyle, String label) entry,
  }) async {
    final numAnnotations = ref
        .read(userProvider)
        .annotations
        .where((annotation) => annotation.style == entry.$1)
        .length;

    await context.showStyledDialog(
      (context) => StyledDialog(
        title: t.highlightStyleUi.delete.toText(),
        body: numAnnotations == 0
            ? t.highlightStyleUi.deleteNamedConfirmation(name: entry.$2).toText()
            : t.highlightStyleUi
                  .deleteWithAnnotations(
                    name: entry.$2,
                    annotations: t.annotationUi.annotationCount(count: numAnnotations),
                  )
                  .toText(),
        buttonsBuilder: (context) => numAnnotations == 0
            ? [
                StyledRectButton.critical(
                  label: t.common.delete.toText(),
                  onPressed: () {
                    ref.updateUser((user) => user.withRemovedHighlightStyle(index, deleteAnnotations: true));
                    context.pop();
                  },
                ),
              ]
            : [
                StyledRectButton.primary(
                  label: t.highlightStyleUi.keepAnnotations.toText(),
                  onPressed: () {
                    ref.updateUser((user) => user.withRemovedHighlightStyle(index, deleteAnnotations: false));
                    context.pop();
                  },
                ),
                StyledRectButton.transparent(
                  label: t.notebookUi.deleteAnnotations.toText(),
                  isCritical: true,
                  onPressed: () {
                    ref.updateUser((user) => user.withRemovedHighlightStyle(index, deleteAnnotations: true));
                    context.pop();
                  },
                ),
              ],
      ),
    );
  }

  Future<bool?> showUpdateAnnotationsDialog(
    BuildContext context, {
    required (HighlightStyle, String label) entry,
  }) async {
    final numAnnotations = ref
        .read(userProvider)
        .annotations
        .where((annotation) => annotation.style == entry.$1)
        .length;

    if (numAnnotations == 0) return false;

    return await context.showStyledDialog(
      (context) => StyledDialog(
        title: t.highlightStyleUi.updateAnnotations.toText(),
        body: t.highlightStyleUi
            .updateWithAnnotations(
              name: entry.$2,
              annotations: t.annotationUi.annotationCount(count: numAnnotations),
            )
            .toText(),
        buttonsBuilder: (context) => [
          StyledRectButton.primary(label: t.highlightStyleUi.leaveAsIs.toText(), onPressed: () => context.pop(false)),
          StyledRectButton.transparent(
            label: t.highlightStyleUi.updateAnnotations.toText(),
            onPressed: () => context.pop(true),
          ),
        ],
      ),
    );
  }
}
