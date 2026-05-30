import 'package:bible/models/annotation.dart';
import 'package:bible/models/color_enum.dart';
import 'package:bible/models/reference/region.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/sheets/annotation_sheet.dart';
import 'package:bible/ui/widgets/colored_circle.dart';
import 'package:bible/ui/widgets/search_location_button.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:timeago/timeago.dart' as timeago;

class AnnotationsPage extends HookConsumerWidget {
  const AnnotationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final bibles = ref.watch(biblesProvider);
    final bible = user.getBible(bibles);

    final sortState = useState(AnnotationSort.mostRecent);
    final colorState = useState<ColorEnum?>(null);
    final hasNoteState = useState<bool?>(null);
    final locationsState = useState(<SearchLocationFilter>[]);

    final matchingAnnotations = user.annotations
        .where(
          (annotation) =>
              locationsState.value.isEmpty ||
              locationsState.value.any((location) => location.passes(annotation.selection.startingReference)),
        )
        .where((annotation) => hasNoteState.value == null || (annotation.note.isNotEmpty == hasNoteState.value))
        .where((annotation) => colorState.value == null || annotation.color == colorState.value)
        .toList();

    return StyledPage(
      title: 'Your Annotations'.toText(),
      body: Column(
        crossAxisAlignment: .start,
        children: [
          SingleChildScrollView(
            scrollDirection: .horizontal,
            padding: .symmetric(horizontal: 16),
            child: Row(
              spacing: 8,
              children: [
                StyledPillButton(
                  leading: Symbols.sort.toIcon(),
                  label: sortState.value.title().toText(),
                  trailing: Symbols.keyboard_arrow_down.toIcon(),
                  onPressed: () async {
                    final newSort = await context.showStyledSheet(
                      (context) => StyledSelectionSheet(
                        title: 'Sort'.toText(),
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
                StyledPillButton(
                  colorBuilder: colorState.value == null ? null : .primary,
                  leading: Icon(Symbols.circle, color: colorState.value?.toHue(context.colors).primary),
                  label: (colorState.value?.title() ?? 'Color').toText(),
                  trailing: Symbols.keyboard_arrow_down.toIcon(),
                  onPressed: () async {
                    final newColor = await context.showStyledSheet(
                      (context) => StyledSelectionSheet(
                        title: 'Color'.toText(),
                        options: ColorEnum.values,
                        optionMapper: (option) => StyledSelectOption(
                          title: option.title().toText(),
                          leading: ColoredCircle(color: option.toHue(context.colors).primary),
                        ),
                        initialOption: colorState.value,
                        trailing: colorState.value == null
                            ? null
                            : StyledCircleButton.md(
                                child: Symbols.delete.toIcon(),
                                onPressed: () {
                                  colorState.value = null;
                                  context.pop();
                                },
                              ),
                      ),
                    );
                    if (newColor != null) {
                      colorState.value = newColor;
                    }
                  },
                ),
                StyledPillButton(
                  colorBuilder: hasNoteState.value == null ? null : .primary,
                  leading: Symbols.note.toIcon(),
                  label: switch (hasNoteState.value) {
                    true => 'With Notes',
                    false => 'Without Notes',
                    null => 'Notes',
                  }.toText(),
                  trailing: Symbols.keyboard_arrow_down.toIcon(),
                  onPressed: () async {
                    final newHasNotes = await context.showStyledSheet(
                      (context) => StyledSelectionSheet(
                        title: 'Notes'.toText(),
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
                            true => 'With Notes',
                            false => 'Without Notes',
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
                  locations: locationsState.value,
                  onLocationsSelected: (locations) => locationsState.value = locations,
                ),
              ],
            ),
          ),
          gapH8,
          Expanded(
            child: StyledListView(
              children: [
                if (user.annotations.isEmpty)
                  Padding(
                    padding: .all(16),
                    child: StyledTile.message(
                      leading: Symbols.note_stack.toIcon(),
                      title: "You haven't created any annotations.".toText(),
                    ),
                  )
                else if (matchingAnnotations.isEmpty)
                  Padding(
                    padding: .all(16),
                    child: StyledTile.message(
                      leading: Symbols.note_stack.toIcon(),
                      title: "No matching annotations.".toText(),
                    ),
                  ),
                ...matchingAnnotations
                    .sorted(sortState.value.comparator)
                    .map(
                      (annotation) => StyledSwipeable(
                        key: ValueKey(annotation),
                        actions: [
                          .delete(onPressed: () => ref.updateUser((user) => user.withRemovedAnnotation(annotation))),
                        ],
                        child: StyledListItem(
                          leading: ColoredCircle(color: annotation.color.toHue(context.colors).primary),
                          title: annotation.formatLocation().toText(),
                          subtitle: Column(
                            spacing: 4,
                            crossAxisAlignment: .start,
                            children: [
                              Text(annotation.formatContent(bible), maxLines: 2, overflow: .ellipsis),
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
                          thirdLine: 'Annotated ${timeago.format(annotation.createdAt)}'.toText(),
                          trailing: StyledCircleButton.md(
                            child: Symbols.more_vert.toIcon(),
                            onPressed: () => context.showStyledSheet(
                              (context) => StyledSheet(
                                title: 'Annotation'.toText(),
                                children: [
                                  StyledListItem(
                                    title: 'Go to Passage'.toText(),
                                    leading: Symbols.expand_circle_right.toIcon(),
                                    onPressed: () {
                                      context.pop();
                                      context.pop(VerseSelection.fromReferences(annotation.region.allReferences));
                                    },
                                  ),
                                  StyledListItem(
                                    title: 'Edit'.toText(),
                                    leading: Symbols.edit.toIcon(),
                                    onPressed: () async {
                                      context.pop();
                                      final newAnnotation = await AnnotationSheet.show(
                                        context,
                                        ref,
                                        selection: annotation.selection,
                                        annotation: annotation,
                                      );
                                      if (newAnnotation != null) {
                                        ref.updateUser((user) => user.withAnnotationUpdated(annotation, newAnnotation));
                                      }
                                    },
                                  ),
                                  StyledListItem(
                                    title: 'Delete'.toText(),
                                    leading: Symbols.delete.toIcon(),
                                    onPressed: () {
                                      context.pop();
                                      ref.updateUser((user) => user.withRemovedAnnotation(annotation));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
    mostRecent => 'Most Recent',
    location => 'Location',
  };

  Comparator<Annotation> get comparator => switch (this) {
    mostRecent => ((a, b) => b.createdAt.compareTo(a.createdAt)),
    location => ((a, b) => a.selection.compareTo(b.selection)),
  };
}
