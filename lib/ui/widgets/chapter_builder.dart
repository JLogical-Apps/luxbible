import 'dart:math';

import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/passage.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/selection.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/annotated_span.dart';
import 'package:bible/ui/widgets/sized_widget_span.dart';
import 'package:bible/ui/widgets/underline.dart';
import 'package:bible/utils/extensions/color_extensions.dart';
import 'package:bible/utils/extensions/num_extensions.dart';
import 'package:bible/utils/extensions/rect_extensions.dart';
import 'package:bible/utils/extensions/span_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intersperse/intersperse.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:utils_core/utils_core.dart';

class ChapterBuilder extends HookConsumerWidget {
  final ChapterReference chapterReference;
  final User user;
  final Bible bible;

  final Function(Reference)? onReferencePressed;
  final List<Reference> underlinedReferences;

  final Selection? selection;
  final Function(Selection?, bool isNewSelection)? onSelectionUpdated;

  final ObjectRef<Map<Reference, GlobalKey>>? keyByReferenceRef;

  const ChapterBuilder({
    super.key,
    required this.chapterReference,
    required this.user,
    required this.bible,
    this.onReferencePressed,
    this.underlinedReferences = const [],
    this.selection,
    this.onSelectionUpdated,
    this.keyByReferenceRef,
  });

  Chapter get chapter => bible.getChapterByReference(chapterReference);
  BookType get book => chapterReference.book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionStartAnchorState = useState<SelectionWordAnchor?>(null);

    final paragraphHitTesters = <ParagraphHitTester>[];

    SelectionWordAnchor? getAnchorAtGlobalPosition(Offset globalPosition) =>
        paragraphHitTesters.map((tester) => tester.getAnchorAt(globalPosition)).nonNulls.firstOrNull;

    return GestureDetector(
      onLongPressStart: (details) {
        final anchor = getAnchorAtGlobalPosition(details.globalPosition);
        if (anchor == null) return;

        final wordSelection = bible.getWordsSelection(
          Selection.character(anchor: anchor, translation: bible.translation),
        );
        onSelectionUpdated?.call(wordSelection, true);
        selectionStartAnchorState.value = anchor;
      },
      onLongPressMoveUpdate: (details) {
        final startAnchor = selectionStartAnchorState.value;
        if (startAnchor == null) return;

        final anchor = getAnchorAtGlobalPosition(details.globalPosition);
        if (anchor == null) return;

        final anchors = [startAnchor, anchor]..sort();
        final wordsSelection = bible.getWordsSelection(
          Selection(start: anchors.first, end: anchors.last, translation: bible.translation),
        );
        onSelectionUpdated?.call(wordsSelection, false);
      },
      onLongPressEnd: (_) => selectionStartAnchorState.value = null,
      onTapUp: (details) {
        final anchor = getAnchorAtGlobalPosition(details.globalPosition);
        if (anchor != null) {
          onReferencePressed?.call(anchor.toReference());
        } else {
          onSelectionUpdated?.call(null, true);
        }
      },
      child: Column(
        crossAxisAlignment: .stretch,
        children: getParagraphSpansByParagraph(context, ref)
            .mapEntries(
              (paragraph, paragraphSpans) => Padding(
                padding: paragraph.as<VersesParagraph>()?.type.padding ?? .zero,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final textKey = GlobalKey();

                    if (paragraph is VersesParagraph) {
                      paragraphHitTesters.add(
                        ParagraphHitTester(
                          textKey: textKey,
                          resolve: (localPosition) => getOffsetAnchor(
                            characterOffset: paragraphSpans.getCharacterOffsetFromPosition(
                              width: constraints.maxWidth,
                              localPosition: localPosition,
                              textAlign: paragraph.type.textAlign,
                            ),
                            paragraph: paragraph,
                          ),
                        ),
                      );
                    }

                    return Stack(
                      clipBehavior: .none,
                      fit: .passthrough,
                      children: [
                        if (paragraph is VersesParagraph) ...[
                          ...paragraph.verses
                              .map((verse) => getVerseReference(verse))
                              .mapToMap(
                                (reference) => MapEntry(
                                  reference,
                                  user.annotations.where(
                                    (annotation) =>
                                        annotation.passages.any((passage) => passage.hasReference(reference)),
                                  ),
                                ),
                              )
                              .where((reference, annotations) => annotations.isNotEmpty)
                              .mapToIterable((reference, annotations) {
                                final verseColor = annotations
                                    .map(
                                      (annotation) =>
                                          annotation.color.toHue(context.colors).primary.withValues(alpha: 0.5),
                                    )
                                    .mixOrNull;

                                final (base, extent) =
                                    paragraphSpans.getReferenceCharacterOffsets(reference: reference, bible: bible) ??
                                    (null, null);
                                if (base == null || extent == null) {
                                  return null;
                                }

                                return paragraphSpans
                                    .getBoxesForSelection(
                                      baseOffset: base,
                                      extentOffset: extent,
                                      width: constraints.maxWidth,
                                      textAlign: paragraph.type.textAlign,
                                    )
                                    .map((box) => box.toRect())
                                    .withMergedLines()
                                    .map(
                                      (box) => Positioned.fromRect(
                                        rect: Rect.fromLTWH(
                                          box.left - 1,
                                          box.top + 2,
                                          box.width + 4,
                                          min(32, box.height),
                                        ),
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
                              .nonNulls
                              .flattened,
                          ...user
                              .getSelectionAnnotationsInPassage(
                                chapterReference.toPassage(),
                                translation: bible.translation,
                              )
                              .map((record) {
                                final (annotation, selection) = record;
                                final (base, extent) =
                                    paragraphSpans.getSelectionCharacterOffsets(
                                      selection: selection,
                                      translation: bible.translation,
                                    ) ??
                                    (null, null);
                                if (base == null || extent == null) {
                                  return null;
                                }

                                return paragraphSpans
                                    .getBoxesForSelection(
                                      baseOffset: base,
                                      extentOffset: extent,
                                      width: constraints.maxWidth,
                                      textAlign: paragraph.type.textAlign,
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
                              })
                              .nonNulls
                              .flattened,
                          if (selection case final selection?)
                            ...?() {
                              final (base, extent) =
                                  paragraphSpans.getSelectionCharacterOffsets(
                                    selection: selection,
                                    translation: bible.translation,
                                  ) ??
                                  (null, null);
                              if (base == null || extent == null) {
                                return null;
                              }

                              return paragraphSpans
                                  .getBoxesForSelection(
                                    baseOffset: base,
                                    extentOffset: extent,
                                    width: constraints.maxWidth,
                                    textAlign: paragraph.type.textAlign,
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
                        ],
                        Text.rich(
                          key: textKey,
                          TextSpan(children: paragraphSpans),
                          style: TextStyle(fontStyle: paragraph.as<VersesParagraph>()?.type.fontStyle ?? .normal),
                          textAlign: paragraph.as<VersesParagraph>()?.type.textAlign ?? .start,
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Reference getVerseReference(Verse verse) => chapterReference.getReference(verse.verseNum);

  List<MapEntry<Paragraph, List<InlineSpan>>> getParagraphSpansByParagraph(BuildContext context, WidgetRef ref) {
    var maxPreviousVerseNum = 0;
    return chapter.paragraphs.mapIndexed((paragraphIndex, paragraph) {
      final previousParagraph = paragraphIndex == 0
          ? null
          : chapter.paragraphs[paragraphIndex - 1].as<VersesParagraph>();
      return MapEntry(paragraph, [
        if (previousParagraph?.type.isPoetic == true && paragraph is VersesParagraph && !paragraph.type.isPoetic)
          TextSpan(text: '\n', style: context.textStyle.bibleBody.copyWith(height: 1.5)),
        ...switch (paragraph) {
          SectionParagraph(:final text) => [
            if (paragraphIndex != 0) TextSpan(text: '\n', style: context.textStyle.bibleBody.copyWith(height: 1.5)),
            TextSpan(text: text, style: context.textStyle.bibleSection),
          ],
          VersesParagraph(:final verses, :final type) => [
            SizedWidgetSpan.space(size: Size(type.indent, 0)),
            ...verses
                .mapIndexed((verseIndex, verse) {
                  final reference = getVerseReference(verse);
                  final paragraphOffset = verseIndex == 0 ? paragraph.firstVerseOffset : 0;

                  final passageAnnotations = user.getPassageAnnotations(Passage.reference(reference));
                  final passageAnnotationsWithNote = passageAnnotations
                      .where(
                        (annotation) =>
                            annotation.note != null &&
                            annotation.passages.any((passage) => passage.references.firstOrNull == reference),
                      )
                      .toList();

                  final spans = [
                    if (verse.verseNum > maxPreviousVerseNum) ...[
                      AnnotatedSizedWidgetSpan<VerseElement>(
                        annotation: VerseElement(
                          anchor: SelectionWordAnchor.fromReference(reference: reference, characterOffset: 0),
                          isBoundInSelection: false,
                        ),
                        size: Size(
                          context.textStyle.bibleVerseNumber.getWidth(verse.verseNum.toString()) + 6,
                          context.textStyle.bibleBody.fontSize!,
                        ),
                        alignment: .middle,
                        child: Padding(
                          padding: .only(right: 6),
                          child: Text(
                            verse.verseNum.toString(),
                            style: context.textStyle.bibleVerseNumber.copyWith(
                              decoration: underlinedReferences.contains(reference) ? .underline : null,
                            ),
                          ),
                        ),
                      ),
                      if (passageAnnotationsWithNote.isNotEmpty)
                        notesButtonSpan(
                          context,
                          ref,
                          element: VerseElement(
                            anchor: SelectionWordAnchor.fromReference(reference: reference, characterOffset: 0),
                            isBoundInSelection: false,
                          ),
                          annotations: passageAnnotationsWithNote,
                          isUnderlined: underlinedReferences.contains(reference),
                        ),
                    ],
                    ...AnnotatedTextSpan<VerseElement>(
                      annotation: VerseElement(
                        anchor: SelectionWordAnchor.fromReference(
                          reference: reference,
                          characterOffset: paragraphOffset,
                        ),
                        isBoundInSelection: false,
                      ),
                      text: verse.text,
                      style: context.textStyle.bibleBody.copyWith(
                        decoration: underlinedReferences.contains(reference) ? .underline : null,
                      ),
                    ).withInjectedSpans(
                      user
                          .getSelectionAnnotationsWithNotesByOffset(
                            reference: reference,
                            translation: bible.translation,
                          )
                          .where(
                            (offset, annotations) =>
                                offset >= paragraphOffset && offset <= paragraphOffset + verse.text.length,
                          )
                          .map(
                            (offset, annotations) => MapEntry(
                              offset - paragraphOffset,
                              notesButtonSpan(
                                context,
                                ref,
                                element: VerseElement(
                                  anchor: SelectionWordAnchor.fromReference(
                                    reference: reference,
                                    characterOffset: offset,
                                  ),
                                  isBoundInSelection: true,
                                ),
                                annotations: annotations,
                                isUnderlined: underlinedReferences.contains(reference),
                              ),
                            ),
                          ),
                      annotationModifier: (_, offset) => VerseElement(
                        anchor: SelectionWordAnchor.fromReference(
                          reference: reference,
                          characterOffset: offset + paragraphOffset,
                        ),
                        isBoundInSelection: false,
                      ),
                    ),
                  ];
                  maxPreviousVerseNum = verse.verseNum;
                  return spans;
                })
                .intersperse([TextSpan(text: ' ', style: context.textStyle.bibleBody)])
                .flattenedToList,
          ],
          BreakParagraph() => [TextSpan(text: '\n', style: context.textStyle.bibleBody.copyWith(height: 0.75))],
        },
      ]);
    }).toList();
  }

  WidgetSpan notesButtonSpan(
    BuildContext context,
    WidgetRef ref, {
    required VerseElement element,
    required List<Annotation> annotations,
    required bool isUnderlined,
  }) {
    return AnnotatedSizedWidgetSpan<VerseElement>(
      annotation: element,
      size: Size(30, context.textStyle.bibleBody.fontSize!),
      alignment: .middle,
      child: OverflowBox(
        maxHeight: context.textStyle.bibleBody.totalHeight + 4,
        maxWidth: 30,
        child: Underline(
          isUnderlined: isUnderlined,
          child: Padding(
            padding: .only(bottom: 4),
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

  SelectionWordAnchor? getOffsetAnchor({required int characterOffset, required VersesParagraph paragraph}) {
    int getVerseOffset(Verse verse) => verse == paragraph.verses.first ? paragraph.firstVerseOffset : 0;

    var offsetCount = 0;
    for (final verse in paragraph.verses) {
      final referenceLength = verse.text.length + getVerseOffset(verse);
      if (characterOffset < offsetCount + referenceLength) {
        return SelectionWordAnchor.fromReference(
          reference: getVerseReference(verse),
          characterOffset: (characterOffset - offsetCount + getVerseOffset(verse)).clampZero,
        );
      }

      offsetCount += referenceLength;
    }
    return null;
  }
}

class ParagraphHitTester {
  final GlobalKey textKey;
  final SelectionWordAnchor? Function(Offset localPosition) resolve;

  const ParagraphHitTester({required this.textKey, required this.resolve});

  SelectionWordAnchor? getAnchorAt(Offset globalPosition) {
    final box = textKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return null;

    final localPosition = box.globalToLocal(globalPosition);
    if (localPosition.dx < 0 ||
        localPosition.dy < 0 ||
        localPosition.dx > box.size.width ||
        localPosition.dy > box.size.height) {
      return null;
    }

    return resolve(localPosition);
  }
}

class VerseElement {
  final SelectionWordAnchor anchor;
  final bool isBoundInSelection;

  const VerseElement({required this.anchor, required this.isBoundInSelection});
}

extension on List<InlineSpan> {
  Selection getContainedSelection({required BibleTranslation translation}) {
    final lastAnchor = whereType<IsAnnotatedSpan<VerseElement>>().last;
    return Selection(
      start: whereType<IsAnnotatedSpan<VerseElement>>().first.annotation.anchor,
      end: lastAnchor.annotation.anchor.withCharactersAdded(lastAnchor.textLength),
      translation: translation,
    );
  }

  int get maxTextPosition => map((span) => span.textLength).sum;

  int? getTextPosition({required SelectionWordAnchor anchor, bool onlyBound = false}) {
    if (whereType<IsAnnotatedSpan<VerseElement>>().firstOrNull case final startingSpan?) {
      if (startingSpan.annotation.anchor > anchor) {
        return null;
      }
    }

    if (whereType<IsAnnotatedSpan<VerseElement>>().every(
      (span) => span.annotation.anchor.withCharactersAdded(span.textLength) < anchor,
    )) {
      return null;
    }

    var cursor = 0;
    final equalBoundPosition = map((span) {
      final start = cursor;
      cursor += span.textLength;
      return span is IsAnnotatedSpan<VerseElement> &&
              span.annotation.anchor == anchor &&
              (!onlyBound || span.annotation.isBoundInSelection)
          ? start - span.annotation.anchor.characterOffset + anchor.characterOffset
          : null;
    }).toList().nonNulls.firstOrNull;

    if (equalBoundPosition != null) {
      return equalBoundPosition;
    }

    cursor = 0;
    return map((span) {
      final start = cursor;
      cursor += span.textLength;
      return span is IsAnnotatedSpan<VerseElement> && span.annotation.anchor <= anchor
          ? start - span.annotation.anchor.characterOffset + anchor.characterOffset
          : null;
    }).toList().nonNulls.lastOrNull;
  }

  (int, int)? getReferenceCharacterOffsets({required Reference reference, required Bible bible}) {
    if (!getContainedSelection(translation: bible.translation).isInReference(reference)) {
      return null;
    }

    return (
      getTextPosition(
            anchor: SelectionWordAnchor.fromReference(reference: reference, characterOffset: 0),
            onlyBound: false,
          ) ??
          1,
      getTextPosition(
            anchor: SelectionWordAnchor.fromReference(
              reference: reference,
              characterOffset: bible.getVerseByReference(reference)?.text.length ?? 0,
            ),
            onlyBound: false,
          ) ??
          maxTextPosition,
    );
  }

  (int, int)? getSelectionCharacterOffsets({required Selection selection, required BibleTranslation translation}) {
    if (!getContainedSelection(translation: translation).intersects(selection)) {
      return null;
    }

    return (
      getTextPosition(anchor: selection.start, onlyBound: true) ?? 1,
      (getTextPosition(anchor: selection.end, onlyBound: true) ?? (maxTextPosition - 1)) + 1,
    );
  }
}
