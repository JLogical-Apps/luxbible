import 'dart:math';

import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/text_style_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_sheet.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/ui/widgets/sized_widget_span.dart';
import 'package:bible/ui/widgets/underline.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/color_extensions.dart';
import 'package:bible/utils/extensions/num_extensions.dart';
import 'package:bible/utils/extensions/rect_extensions.dart';
import 'package:bible/utils/extensions/span_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class PassageBuilder extends HookConsumerWidget {
  final Passage passage;
  final Bible? bible;
  final Function(Reference)? onReferencePressed;
  final Function(Selection?)? onSelectionUpdated;

  final List<Reference> underlinedReferences;

  final ObjectRef<Map<Reference, GlobalKey>>? keyByReferenceRef;

  final Selection? selection;

  const PassageBuilder({
    super.key,
    required this.passage,
    this.bible,
    this.onReferencePressed,
    this.onSelectionUpdated,
    this.underlinedReferences = const [],
    this.keyByReferenceRef,
    this.selection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyByReferenceRef = this.keyByReferenceRef;

    final bibles = ref.watch(biblesProvider);
    final user = ref.watch(userProvider);
    final bible = this.bible ?? user.getBible(bibles);

    final references = passage.references;

    final keyByReference = references.mapToMap(
      (reference) => MapEntry(reference, keyByReferenceRef?.value[reference] ?? GlobalKey()),
    );
    if (keyByReferenceRef != null && passage.references.any((ref) => !keyByReferenceRef.value.containsKey(ref))) {
      WidgetsBinding.instance.addPostFrameCallback((_) => keyByReferenceRef.value = keyByReference);
    }

    final selectionStartAnchorState = useState<SelectionWordAnchor?>(null);

    final spansByReference = references.mapToMap((reference) {
      final verse = bible.getVerseByReference(reference);
      if (verse == null) {
        return MapEntry(reference, null);
      }

      final passageAnnotations = user.getPassageAnnotations(Passage.reference(reference));
      final passageAnnotationsWithNote = passageAnnotations
          .where(
            (annotation) =>
                annotation.note != null &&
                annotation.passages.any((passage) => passage.references.firstOrNull == reference),
          )
          .toList();
      return MapEntry(reference, [
        SizedWidgetSpan(
          size: Size(
            context.textStyle.bibleVerseNumber.getWidth(reference.verseNum.toString()) + 6,
            context.textStyle.bibleBody.fontSize!,
          ),
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            key: keyByReference[reference],
            padding: .only(right: 6),
            child: Text(
              reference.verseNum.toString(),
              style: context.textStyle.bibleVerseNumber.copyWith(
                decoration: underlinedReferences.contains(reference) ? TextDecoration.underline : null,
              ),
            ),
          ),
        ),
        if (passageAnnotationsWithNote.isNotEmpty)
          notesButtonSpan(
            context,
            ref,
            annotations: passageAnnotationsWithNote,
            isUnderlined: underlinedReferences.contains(reference),
            bible: bible,
          ),
        ...TextSpan(
          text: verse.text,
          style: context.textStyle.bibleBody.copyWith(
            decoration: underlinedReferences.contains(reference) ? TextDecoration.underline : null,
          ),
        ).withInjectedSpans(
          user
              .getSelectionAnnotationsWithNotesByOffset(reference: reference, translation: bible.translation)
              .map(
                (offset, annotations) => MapEntry(
                  offset,
                  notesButtonSpan(
                    context,
                    ref,
                    annotations: annotations,
                    isUnderlined: underlinedReferences.contains(reference),
                    bible: bible,
                  ),
                ),
              ),
        ),
        if (reference != references.last) TextSpan(text: '\n', style: context.textStyle.bibleBody),
      ]);
    }).withoutNullValues;
    final spans = spansByReference.values.flattenedToList;

    final textKey = useMemoized(() => GlobalKey());

    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        clipBehavior: Clip.none,
        children: [
          ...passage.references
              .mapToMap(
                (reference) => MapEntry(
                  reference,
                  user.annotations.where(
                    (annotation) => annotation.passages.any((passage) => passage.hasReference(reference)),
                  ),
                ),
              )
              .where((reference, annotations) => annotations.isNotEmpty)
              .mapToIterable((reference, annotations) {
                final verseColor = annotations
                    .map((annotation) => annotation.color.toHue(context.colors).primary)
                    .mixOrNull;
                final (base, extent) = getReferenceCharacterOffsets(
                  reference: reference,
                  spansByReference: spansByReference,
                );
                return spans
                    .getBoxesForSelection(baseOffset: base, extentOffset: extent, width: constraints.maxWidth)
                    .map((box) => box.toRect())
                    .withMergedLines()
                    .map(
                      (box) => Positioned.fromRect(
                        rect: Rect.fromLTWH(box.left - 4, box.top, box.width + 4, min(32, box.height)),
                        child: IgnorePointer(
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOutCubic,
                            decoration: BoxDecoration(
                              borderRadius: .circular(4),
                              color: verseColor?.withValues(alpha: selection == null ? 0.5 : 0.2),
                            ),
                          ),
                        ),
                      ),
                    );
              })
              .flattened,
          ...user.getSelectionAnnotationsInPassage(passage, translation: bible.translation).map((record) {
            final (annotation, selection) = record;
            final (base, extent) = getSelectionCharacterOffsets(
              selection: selection,
              spansByReference: spansByReference,
            );
            return spans
                .getBoxesForSelection(baseOffset: base, extentOffset: extent, width: constraints.maxWidth)
                .map((box) => box.toRect())
                .withMergedLines()
                .map(
                  (box) => Positioned.fromRect(
                    rect: Rect.fromLTWH(box.left, box.top + 4, box.width + 2, min(28, box.height)),
                    child: IgnorePointer(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOutCubic,
                        decoration: BoxDecoration(
                          borderRadius: .circular(4),
                          color: annotation.color
                              .toHue(context.colors)
                              .primary
                              .withValues(alpha: underlinedReferences.isEmpty ? 0.5 : 0.2),
                        ),
                      ),
                    ),
                  ),
                );
          }).flattened,
          if (selection case final selection?)
            ...() {
              final (base, extent) = getSelectionCharacterOffsets(
                selection: selection,
                spansByReference: spansByReference,
              );
              return spans
                  .getBoxesForSelection(baseOffset: base, extentOffset: extent, width: constraints.maxWidth)
                  .map((box) => box.toRect())
                  .withMergedLines()
                  .map(
                    (box) => Positioned.fromRect(
                      rect: Rect.fromLTWH(box.left, box.top + 4, box.width + 2, min(28, box.height)),
                      child: IgnorePointer(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOutCubic,
                          decoration: BoxDecoration(
                            borderRadius: .circular(4),
                            color: context.colors.contentPrimary.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                    ),
                  );
            }(),
          GestureDetector(
            onLongPressStart: (details) {
              final renderBox = textKey.currentContext!.findRenderObject() as RenderBox;
              final offset = spans.getCharacterOffsetFromPosition(
                width: constraints.maxWidth,
                localPosition: renderBox.globalToLocal(details.globalPosition),
              );

              final anchor = getOffsetAnchor(characterOffset: offset, bible: bible);
              if (anchor == null) {
                return;
              }

              final wordSelection = bible.getWordsSelection(
                Selection.character(anchor: anchor, translation: bible.translation),
              );
              onSelectionUpdated?.call(wordSelection);
              selectionStartAnchorState.value = anchor;
            },
            onLongPressMoveUpdate: (details) {
              final renderBox = textKey.currentContext!.findRenderObject() as RenderBox;
              final offset = spans.getCharacterOffsetFromPosition(
                width: constraints.maxWidth,
                localPosition: renderBox.globalToLocal(details.globalPosition),
              );

              final anchor = getOffsetAnchor(characterOffset: offset, bible: bible);
              if (anchor == null) {
                return;
              }

              final anchors = [?selectionStartAnchorState.value, anchor]..sort();

              final wordsSelection = bible.getWordsSelection(
                Selection(start: anchors.first, end: anchors.last, translation: bible.translation),
              );
              onSelectionUpdated?.call(wordsSelection);
            },
            onTapUp: (details) {
              final renderBox = textKey.currentContext!.findRenderObject() as RenderBox;
              final offset = spans.getCharacterOffsetFromPosition(
                width: constraints.maxWidth,
                localPosition: renderBox.globalToLocal(details.globalPosition),
              );

              final anchor = getOffsetAnchor(characterOffset: offset, bible: bible);
              if (anchor != null) {
                onReferencePressed?.call(anchor.toReference());
              }
            },
            child: Text.rich(
              key: textKey,
              TextSpan(children: spans),
              strutStyle: StrutStyle.fromTextStyle(context.textStyle.bibleBody),
              textHeightBehavior: TextHeightBehavior(
                applyHeightToFirstAscent: true,
                applyHeightToLastDescent: true,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
          ),
        ],
      ),
    );
  }

  WidgetSpan notesButtonSpan(
    BuildContext context,
    WidgetRef ref, {
    required List<Annotation> annotations,
    required bool isUnderlined,
    Color? color,
    required Bible bible,
  }) {
    return SizedWidgetSpan(
      size: Size(30, context.textStyle.bibleBody.fontSize!),
      alignment: PlaceholderAlignment.middle,
      child: OverflowBox(
        maxHeight: context.textStyle.bibleBody.totalHeight + 4,
        maxWidth: 30,
        child: Underline(
          isUnderlined: isUnderlined,
          child: Container(
            color: color,
            margin: .only(bottom: 4),
            child: StyledCircleButton.sm(
              onPressed: () => context.showStyledSheet(
                (context) => StyledSheet(
                  title: 'Notes'.toText(),
                  children: annotations
                      .map(
                        (annotation) => StyledListItem(
                          title: (annotation.note ?? '').toText(),
                          subtitle: Column(
                            children: [
                              annotation.passages.map((passage) => passage.format()).join('; ').nullIfBlank,
                              ...annotation.selections.map((selection) => '"${bible.getSelectionText(selection)}"'),
                            ].nonNulls.map((text) => Text(text, maxLines: 1, overflow: .ellipsis)).toList(),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              child: Icon(Symbols.note_stack, color: context.colors.contentTertiary),
            ),
          ),
        ),
      ),
    );
  }

  (int, int) getReferenceCharacterOffsets({
    required Reference reference,
    required Map<Reference, List<InlineSpan>> spansByReference,
  }) {
    var start = 0;
    for (final MapEntry(:key, :value) in spansByReference.entries) {
      final verseLength = value.characterLength;
      if (key == reference) {
        return (start, start + verseLength);
      } else {
        start += verseLength;
      }
    }
    return (0, 0);
  }

  (int, int) getSelectionCharacterOffsets({
    required Selection selection,
    required Map<Reference, List<InlineSpan>> spansByReference,
  }) {
    int getSelectionAnchorOffset(SelectionWordAnchor anchor) =>
        getReferenceCharacterOffsets(reference: anchor.toReference(), spansByReference: spansByReference).$1 +
        (spansByReference[anchor.toReference()]?.getActualOffset(anchor.characterOffset) ?? 0);

    return (getSelectionAnchorOffset(selection.start), getSelectionAnchorOffset(selection.end) + 1);
  }

  SelectionWordAnchor? getOffsetAnchor({required int characterOffset, required Bible bible}) {
    var offsetCount = 0;
    for (final reference in passage.references) {
      final referenceLength = bible.getVerseByReference(reference)?.text.length;
      if (referenceLength == null) {
        continue;
      }

      if (characterOffset < offsetCount + referenceLength) {
        return SelectionWordAnchor.fromReference(
          reference: reference,
          characterOffset: (characterOffset - offsetCount).clampZero,
        );
      }

      offsetCount += referenceLength + 1;
    }
    return null;
  }
}
