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
import 'package:bible/utils/extensions/rect_extensions.dart';
import 'package:bible/utils/extensions/span_extensions.dart';
import 'package:bible/utils/guard.dart';
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

  const PassageBuilder({
    super.key,
    required this.passage,
    this.bible,
    this.onReferencePressed,
    this.onSelectionUpdated,
    this.underlinedReferences = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bibles = ref.watch(biblesProvider);
    final user = ref.watch(userProvider);
    final bible = this.bible ?? user.getBible(bibles);

    final spansByReference = passage.references.mapToMap((reference) {
      final verse = bible.getVerseByReference(reference);
      final passageAnnotations = user.getPassageAnnotations(Passage.reference(reference));
      final passageAnnotationsWithNote = passageAnnotations
          .where(
            (annotation) =>
                annotation.note != null &&
                annotation.passages.any((passage) => passage.references.firstOrNull == reference),
          )
          .toList();
      final verseSelectionAnchors = user.getSelectionAnchors(reference);
      return MapEntry(reference, [
        SizedWidgetSpan(
          size: Size(
            context.textStyle.bibleVerseNumber.getWidth(reference.verseNum.toString()) + 6,
            context.textStyle.bibleBody.fontSize!,
          ),
          alignment: PlaceholderAlignment.middle,
          child: SelectionContainer.disabled(
            child: Padding(
              padding: EdgeInsets.only(right: 6),
              child: Text(
                reference.verseNum.toString(),
                style: context.textStyle.bibleVerseNumber.copyWith(
                  decoration: underlinedReferences.contains(reference) ? TextDecoration.underline : null,
                ),
              ),
            ),
          ),
        ),
        if (passageAnnotationsWithNote.isNotEmpty)
          notesButtonSpan(
            context,
            annotations: passageAnnotationsWithNote,
            isUnderlined: underlinedReferences.contains(reference),
          ),
        ...verseSelectionAnchors.expandIndexed((verseIndex, offset) {
          final selectionAnchor = SelectionWordAnchor.fromReference(reference: reference, characterOffset: offset);
          final selectionAnnotations = user.getSelectionAnnotations(
            Selection.character(anchor: selectionAnchor, translation: bible.translation),
          );
          final selectionAnnotationColor = selectionAnnotations
              .map((annotation) => annotation.color.toHue(context.colors).primary.withValues(alpha: 0.5))
              .mixOrNull;
          final selectionAnnotationsWithNote = selectionAnnotations
              .where(
                (annotation) =>
                    annotation.note != null &&
                    annotation.selections.any((selection) => selection.start == selectionAnchor),
              )
              .toList();
          return [
            if (selectionAnnotationsWithNote.isNotEmpty)
              notesButtonSpan(
                context,
                annotations: selectionAnnotationsWithNote,
                isUnderlined: underlinedReferences.contains(reference),
                color: selectionAnnotationColor,
              ),
            TextSpan(
              text: verse.text.substring(offset, verseSelectionAnchors.elementAtOrNull(verseIndex + 1)),
              style: context.textStyle.bibleBody.copyWith(
                decoration: underlinedReferences.contains(reference) ? TextDecoration.underline : null,
                backgroundColor: selectionAnnotationColor,
              ),
            ),
          ];
        }),
        TextSpan(text: '\n', style: context.textStyle.bibleBody),
      ]);
    });
    final spans = spansByReference.values.flattenedToList;

    final textKey = useMemoized(() => GlobalKey());

    final selectionListener = useMemoized(() => SelectionListenerNotifier());
    useOnListenableChange(selectionListener, () {
      final range = guard(() => selectionListener.selection.range);
      if (range == null) {
        onSelectionUpdated?.call(null);
        return;
      }

      final minOffset = min(range.startOffset, range.endOffset);
      final maxOffset = max(range.startOffset, range.endOffset) - 1;

      final startAnchor = getOffsetAnchor(characterOffset: minOffset, bible: bible);
      final endAnchor = getOffsetAnchor(characterOffset: maxOffset, bible: bible);

      if (startAnchor != null && endAnchor != null) {
        onSelectionUpdated?.call(Selection(start: startAnchor, end: endAnchor, translation: bible.translation));
      }
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
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
                      .map((annotation) => annotation.color.toHue(context.colors).primary.withValues(alpha: 0.5))
                      .mixOrNull;
                  final (base, extent) = getCharacterOffsets(reference: reference, spansByReference: spansByReference);
                  return spans
                      .getBoxesForSelection(baseOffset: base, extentOffset: extent, width: constraints.maxWidth)
                      .map((box) => box.toRect())
                      .withMergedLines()
                      .map(
                        (box) => Positioned.fromRect(
                          rect: Rect.fromLTWH(box.left - 4, box.top + 2, box.width + 4, min(32, box.height)),
                          child: IgnorePointer(
                            child: DecoratedBox(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: verseColor),
                            ),
                          ),
                        ),
                      );
                })
                .flattened,
            SelectionListener(
              selectionNotifier: selectionListener,
              child: GestureDetector(
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
                child: Text.rich(key: textKey, TextSpan(children: spans)),
              ),
            ),
          ],
        );
      },
    );
  }

  WidgetSpan notesButtonSpan(
    BuildContext context, {
    required List<Annotation> annotations,
    required bool isUnderlined,
    Color? color,
  }) {
    return SizedWidgetSpan(
      size: Size(30, context.textStyle.bibleBody.fontSize!),
      alignment: PlaceholderAlignment.middle,
      child: SelectionContainer.disabled(
        child: OverflowBox(
          maxHeight: context.textStyle.bibleBody.totalHeight + 4,
          maxWidth: 30,
          child: Underline(
            isUnderlined: isUnderlined,
            child: Container(
              color: color,
              margin: EdgeInsets.only(bottom: 4),
              child: StyledCircleButton.sm(
                onPressed: () => context.showStyledSheet(
                  StyledSheet.list(
                    titleText: 'Notes',
                    children: annotations
                        .map((annotation) => StyledListItem(titleText: annotation.note ?? ''))
                        .toList(),
                  ),
                ),
                child: Icon(Symbols.note_stack, color: context.colors.contentTertiary),
              ),
            ),
          ),
        ),
      ),
    );
  }

  (int, int) getCharacterOffsets({
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

  SelectionWordAnchor? getOffsetAnchor({required int characterOffset, required Bible bible}) {
    var offsetCount = 1;
    for (final reference in passage.references) {
      final referenceLength = bible.getVerseByReference(reference).text.length;
      if (characterOffset < offsetCount + referenceLength) {
        return SelectionWordAnchor.fromReference(reference: reference, characterOffset: characterOffset - offsetCount);
      }

      // For some weird reason, the first verse has a different offset than every other verse.
      if (reference == passage.references.first) {
        offsetCount--;
      }
      offsetCount += referenceLength + 1;
    }
    return null;
  }
}
