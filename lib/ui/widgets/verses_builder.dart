import 'dart:math';

import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible/display/bible.dart';
import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
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
import 'package:utils_core/utils_core.dart';

class VersesBuilder extends HookConsumerWidget {
  final VerseSelection verseSelection;
  final DisplayBible? bible;
  final Function(Reference)? onReferencePressed;
  final Function(BibleTextSelection?)? onTextSelectionUpdated;

  final List<Reference> underlinedReferences;

  final ObjectRef<Map<Reference, GlobalKey>>? keyByReferenceRef;

  final BibleTextSelection? textSelection;

  const VersesBuilder({
    super.key,
    required this.verseSelection,
    this.bible,
    this.onReferencePressed,
    this.onTextSelectionUpdated,
    this.underlinedReferences = const [],
    this.keyByReferenceRef,
    this.textSelection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyByReferenceRef = this.keyByReferenceRef;

    final bibles = ref.watch(displayBiblesProvider);
    final user = ref.watch(userProvider);
    final bible = this.bible ?? user.getDisplayBible(bibles);

    final references = verseSelection.references;

    final keyByReference = references.mapToMap(
      (reference) => MapEntry(reference, keyByReferenceRef?.value[reference] ?? GlobalKey()),
    );
    if (keyByReferenceRef != null &&
        verseSelection.references.any((ref) => !keyByReferenceRef.value.containsKey(ref))) {
      WidgetsBinding.instance.addPostFrameCallback((_) => keyByReferenceRef.value = keyByReference);
    }

    final textSelectionStartAnchorState = useState<BibleTextSelectionWordAnchor?>(null);

    final spansByReference = references.mapToMap((reference) {
      final verse = bible.getVerseByReference(reference);
      if (verse == null) {
        return MapEntry(reference, null);
      }

      final verseSelectionAnnotations = user.getVerseSelectionAnnotations(VerseSelection.reference(reference));
      final verseSelectionAnnotationsWithNote = verseSelectionAnnotations
          .where(
            (annotation) =>
                annotation.note != null &&
                annotation.verseSelections.any((vs) => vs.references.firstOrNull == reference),
          )
          .toList();
      return MapEntry(reference, [
        SizedWidgetSpan(
          size: Size(
            context.textStyle.bibleVerseNumber.getWidth(reference.verseNum.toString()) + 6,
            context.textStyle.bibleBody.fontSize!,
          ),
          alignment: .middle,
          child: Padding(
            key: keyByReference[reference],
            padding: .only(right: 6),
            child: Text(
              reference.verseNum.toString(),
              style: context.textStyle.bibleVerseNumber.copyWith(
                decoration: underlinedReferences.contains(reference) ? .underline : null,
              ),
            ),
          ),
        ),
        if (verseSelectionAnnotationsWithNote.isNotEmpty)
          notesButtonSpan(
            context,
            ref,
            annotations: verseSelectionAnnotationsWithNote,
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
              .getTextSelectionAnnotationsWithNotesByOffset(reference: reference, translation: bible.translation)
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
        clipBehavior: .none,
        children: [
          ...verseSelection.references
              .mapToMap(
                (reference) => MapEntry(
                  reference,
                  user.annotations.where(
                    (annotation) => annotation.verseSelections.any((vs) => vs.hasReference(reference)),
                  ),
                ),
              )
              .where((reference, annotations) => annotations.isNotEmpty)
              .mapToIterable((reference, annotations) {
                final verseColor = annotations
                    .map((annotation) => annotation.color.toHue(context.colors).primary.withValues(alpha: 0.5))
                    .mixOrNull;
                final (base, extent) = getReferenceCharacterOffsets(
                  reference: reference,
                  spansByReference: spansByReference,
                );
                return spans
                    .getBoxesForSelection(
                      baseOffset: base,
                      extentOffset: extent,
                      width: constraints.maxWidth,
                      textAlign: .start,
                    )
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
                              color: verseColor?.withValues(alpha: textSelection == null ? 0.5 : 0.2),
                            ),
                          ),
                        ),
                      ),
                    );
              })
              .flattened,
          ...user.getTextSelectionAnnotationsInVerseSelection(verseSelection, translation: bible.translation).map((
            record,
          ) {
            final (annotation, textSelection) = record;
            final (base, extent) = getTextSelectionCharacterOffsets(
              textSelection: textSelection,
              spansByReference: spansByReference,
            );
            return spans
                .getBoxesForSelection(
                  baseOffset: base,
                  extentOffset: extent,
                  width: constraints.maxWidth,
                  textAlign: .start,
                )
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
          if (textSelection case final textSelection?)
            ...() {
              final (base, extent) = getTextSelectionCharacterOffsets(
                textSelection: textSelection,
                spansByReference: spansByReference,
              );
              return spans
                  .getBoxesForSelection(
                    baseOffset: base,
                    extentOffset: extent,
                    width: constraints.maxWidth,
                    textAlign: .start,
                  )
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
                textAlign: .start,
              );

              final anchor = getOffsetAnchor(characterOffset: offset, bible: bible);
              if (anchor == null) {
                return;
              }

              final wordTextSelection = bible.getWordsSelection(
                BibleTextSelection.character(anchor: anchor, translation: bible.translation),
              );
              onTextSelectionUpdated?.call(wordTextSelection);
              textSelectionStartAnchorState.value = anchor;
            },
            onLongPressMoveUpdate: (details) {
              final renderBox = textKey.currentContext!.findRenderObject() as RenderBox;
              final offset = spans.getCharacterOffsetFromPosition(
                width: constraints.maxWidth,
                localPosition: renderBox.globalToLocal(details.globalPosition),
                textAlign: .start,
              );

              final anchor = getOffsetAnchor(characterOffset: offset, bible: bible);
              if (anchor == null) {
                return;
              }

              final anchors = [?textSelectionStartAnchorState.value, anchor]..sort();

              final wordsTextSelection = bible.getWordsSelection(
                BibleTextSelection(start: anchors.first, end: anchors.last, translation: bible.translation),
              );
              onTextSelectionUpdated?.call(wordsTextSelection);
            },
            onTapUp: (details) {
              final renderBox = textKey.currentContext!.findRenderObject() as RenderBox;
              final offset = spans.getCharacterOffsetFromPosition(
                width: constraints.maxWidth,
                localPosition: renderBox.globalToLocal(details.globalPosition),
                textAlign: .start,
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
    required DisplayBible bible,
  }) {
    return SizedWidgetSpan(
      size: Size(30, context.textStyle.bibleBody.fontSize!),
      alignment: .middle,
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
                              annotation.verseSelections
                                  .map((verseSelection) => verseSelection.format())
                                  .join('; ')
                                  .nullIfBlank,
                              ...annotation.textSelections.map(
                                (textSelection) => '"${bible.getSelectionText(textSelection)}"',
                              ),
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

  (int, int) getTextSelectionCharacterOffsets({
    required BibleTextSelection textSelection,
    required Map<Reference, List<InlineSpan>> spansByReference,
  }) {
    int getTextSelectionAnchorOffset(BibleTextSelectionWordAnchor anchor) =>
        getReferenceCharacterOffsets(reference: anchor.toReference(), spansByReference: spansByReference).$1 +
        (spansByReference[anchor.toReference()]?.getActualOffset(anchor.characterOffset) ?? 0);

    return (getTextSelectionAnchorOffset(textSelection.start), getTextSelectionAnchorOffset(textSelection.end) + 1);
  }

  BibleTextSelectionWordAnchor? getOffsetAnchor({required int characterOffset, required DisplayBible bible}) {
    var offsetCount = 0;
    for (final reference in verseSelection.references) {
      final referenceLength = bible.getVerseByReference(reference)?.text.length;
      if (referenceLength == null) {
        continue;
      }

      if (characterOffset < offsetCount + referenceLength) {
        return BibleTextSelectionWordAnchor.fromReference(
          reference: reference,
          characterOffset: (characterOffset - offsetCount).clampZero,
        );
      }

      offsetCount += referenceLength + 1;
    }
    return null;
  }
}
