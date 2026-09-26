import 'package:bible/models/annotation.dart';
import 'package:bible/models/highlight_style.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/pages/notebook_icon.dart';
import 'package:bible/ui/widgets/annotation_list_item.dart';
import 'package:bible/ui/widgets/highlight_style_icon.dart';
import 'package:bible/ui/widgets/search_location_button.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class AnnotationsPage extends HookConsumerWidget implements StyledRoute<VerseSelection> {
  final (String?,)? initialNotebookId;
  final HighlightStyle? initialStyle;

  const AnnotationsPage({super.key, this.initialNotebookId, this.initialStyle});

  @override
  String get path => '/annotations';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    final sortState = useState(AnnotationSort.mostRecent);

    final styleState = useState(initialStyle);
    final style = styleState.value;

    final hasNoteState = useState<bool?>(null);

    final selectedBooksState = useState(<BookType>{});

    final notebookIdState = useState(initialNotebookId);
    final notebookId = notebookIdState.value;
    final notebook = notebookId == null ? null : user.getNotebookById(notebookId.$1);

    final matchingAnnotations = user.annotations
        .where(
          (annotation) =>
              selectedBooksState.value.isEmpty ||
              selectedBooksState.value.contains(annotation.selection.startingReference.book),
        )
        .where((annotation) => hasNoteState.value == null || (annotation.note.isNotEmpty == hasNoteState.value))
        .where((annotation) => style == null || annotation.style == style)
        .where((annotation) => notebookId == null || user.getNotebookById(annotation.notebookId)?.id == notebookId.$1)
        .toList();

    return StyledPage(
      title: t.annotationUi.yourAnnotations.toText(),
      body: Column(
        crossAxisAlignment: .start,
        children: [
          SingleChildScrollView(
            scrollDirection: .horizontal,
            padding: MediaQuery.viewPaddingOf(context).onlyHorizontal + .symmetric(horizontal: 16),
            child: Row(
              spacing: 8,
              children: [
                StyledPillButton.md(
                  leading: Symbols.sort.toIcon(),
                  label: sortState.value.title().toText(),
                  trailing: Symbols.keyboard_arrow_down.toIcon(),
                  onPressed: () async {
                    final newSort = await context.showStyledSheet(
                      (context, _) => StyledSelectionSheet(
                        title: t.common.sort.toText(),
                        options: AnnotationSort.values,
                        optionMapper: (sort) => StyledSelectOption(title: sort.title().toText()),
                        initialOption: sortState.value,
                      ),
                    );
                    if (newSort != null) {
                      sortState.value = newSort;
                    }
                  },
                ),
                if (user.notebooks.isNotEmpty)
                  StyledPillButton.md(
                    colorBuilder: notebookId == null ? null : .primary,
                    leading: notebookId == null
                        ? Icon(Symbols.book_2)
                        : NotebookIcon(notebook: notebook, isInverted: true),
                    label: (notebookId == null ? t.labels.notebook : notebook?.name ?? t.common.defaultLabel).toText(),
                    trailing: Symbols.keyboard_arrow_down.toIcon(),
                    onPressed: () async {
                      final result = await context.showStyledSheet(
                        (context, _) => StyledSelectionSheet<(String?,)>(
                          title: t.labels.notebook.toText(),
                          trailing: notebookId == null
                              ? null
                              : StyledCircleButton.md(
                                  child: Symbols.delete.toIcon(),
                                  onPressed: () {
                                    notebookIdState.value = null;
                                    context.pop();
                                  },
                                ),
                          options: [...user.notebooks.map((notebook) => (notebook.id,)), (null,)],
                          optionMapper: (option) {
                            final notebook = user.getNotebookById(option.$1);
                            return StyledSelectOption(
                              title: (notebook?.name ?? t.common.defaultLabel).toText(),
                              leading: NotebookIcon(notebook: notebook),
                            );
                          },
                          initialOption: notebookId,
                        ),
                      );
                      if (result != null) {
                        notebookIdState.value = result;
                      }
                    },
                  ),
                StyledPillButton.md(
                  colorBuilder: style == null ? null : .primary,
                  leading: style == null
                      ? Icon(Symbols.format_ink_highlighter)
                      : HighlightStyleIcon(style: style, size: .sm, invertContent: true),
                  label: (style == null ? t.labels.style : user.labelForHighlightStyle(style) ?? t.labels.style)
                      .toText(),
                  trailing: Symbols.keyboard_arrow_down.toIcon(),
                  onPressed: () async {
                    final newStyle = await context.showStyledSheet(
                      (context, _) => StyledSelectionSheet<HighlightStyle>(
                        title: t.labels.style.toText(),
                        options: user.highlightStyles.map((entry) => entry.$1).toList(),
                        optionMapper: (option) => StyledSelectOption(
                          title: (user.labelForHighlightStyle(option) ?? '').toText(),
                          leading: HighlightStyleIcon(style: option),
                        ),
                        initialOption: style,
                        trailing: style == null
                            ? null
                            : StyledCircleButton.md(
                                child: Symbols.delete.toIcon(),
                                onPressed: () {
                                  styleState.value = null;
                                  context.pop();
                                },
                              ),
                      ),
                    );
                    if (newStyle != null) {
                      styleState.value = newStyle;
                    }
                  },
                ),
                StyledPillButton.md(
                  colorBuilder: hasNoteState.value == null ? null : .primary,
                  leading: Symbols.note.toIcon(),
                  label: switch (hasNoteState.value) {
                    true => t.annotationUi.withNotes,
                    false => t.annotationUi.withoutNotes,
                    null => t.labels.notes,
                  }.toText(),
                  trailing: Symbols.keyboard_arrow_down.toIcon(),
                  onPressed: () async {
                    final newHasNotes = await context.showStyledSheet(
                      (context, _) => StyledSelectionSheet(
                        title: t.labels.notes.toText(),
                        trailing: hasNoteState.value == null
                            ? null
                            : StyledCircleButton.md(
                                child: Symbols.delete.toIcon(),
                                onPressed: () {
                                  hasNoteState.value = null;
                                  context.pop();
                                },
                              ),
                        options: [true, false],
                        optionMapper: (option) => StyledSelectOption(
                          title: switch (option) {
                            true => t.annotationUi.withNotes,
                            false => t.annotationUi.withoutNotes,
                          }.toText(),
                        ),
                        initialOption: hasNoteState.value,
                      ),
                    );
                    if (newHasNotes != null) {
                      hasNoteState.value = newHasNotes;
                    }
                  },
                ),
                SearchLocationButton(
                  selectedBooks: selectedBooksState.value,
                  onBooksSelected: (books) => selectedBooksState.value = books,
                ),
              ],
            ),
          ),
          gapH8,
          Expanded(
            child: StyledListView(
              padding: .only(bottom: MediaQuery.paddingOf(context).bottom),
              children: [
                if (user.annotations.isEmpty)
                  SafeArea(
                    child: Padding(
                      padding: .all(16),
                      child: StyledTile.message(
                        leading: Symbols.note_stack.toIcon(),
                        title: t.emptyStates.noAnnotations.toText(),
                      ),
                    ),
                  )
                else if (matchingAnnotations.isEmpty)
                  SafeArea(
                    child: Padding(
                      padding: .all(16),
                      child: StyledTile.message(
                        leading: Symbols.note_stack.toIcon(),
                        title: t.emptyStates.noMatchingAnnotations.toText(),
                      ),
                    ),
                  ),
                ...matchingAnnotations
                    .sorted(sortState.value.comparator)
                    .map(
                      (annotation) => AnnotationListItem(
                        key: ValueKey(annotation),
                        annotation: annotation,
                        onNavigateToVerseSelection: (selection) {
                          context.pop();
                          context.pop(selection);
                        },
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum AnnotationSort {
  mostRecent,
  location;

  String title() => switch (this) {
    mostRecent => t.annotationUi.mostRecent,
    location => t.annotationUi.location,
  };

  Comparator<Annotation> get comparator => switch (this) {
    mostRecent => ((a, b) => b.createdAt.compareTo(a.createdAt)),
    location => ((a, b) => a.selection.compareTo(b.selection)),
  };
}
