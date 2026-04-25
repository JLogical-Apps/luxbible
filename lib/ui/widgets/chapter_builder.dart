import 'dart:math';

import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible/bible.dart';
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
    return Column(
      crossAxisAlignment: .stretch,
      children: getParagraphSpansByParagraph(context, ref)
          .mapEntries(
            (paragraph, paragraphSpans) => Padding(
              padding: paragraph.as<VersesParagraph>()?.type.padding ?? .zero,
              child: LayoutBuilder(
                builder: (context, constraints) => Stack(
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
                                (annotation) => annotation.passages.any((passage) => passage.hasReference(reference)),
                              ),
                            ),
                          )
                          .where((reference, annotations) => annotations.isNotEmpty)
                          .mapToIterable((reference, annotations) {
                            final verseColor = annotations
                                .map(
                                  (annotation) => annotation.color.toHue(context.colors).primary.withValues(alpha: 0.5),
                                )
                                .mixOrNull;

                            final (base, extent) =
                                getReferenceCharacterOffsets(reference: reference, paragraphSpans: paragraphSpans) ??
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
                                    rect: Rect.fromLTWH(box.left - 1, box.top + 2, box.width + 4, min(32, box.height)),
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
                                getSelectionCharacterOffsets(
                                  selection: selection,
                                  paragraph: paragraph,
                                  paragraphSpans: paragraphSpans,
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
                              getSelectionCharacterOffsets(
                                selection: selection,
                                paragraph: paragraph,
                                paragraphSpans: paragraphSpans,
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
                    GestureDetector(
                      onLongPressStart: (details) {
                        if (paragraph is! VersesParagraph) {
                          return;
                        }

                        final offset = paragraphSpans.getCharacterOffsetFromPosition(
                          width: constraints.maxWidth,
                          localPosition: details.localPosition,
                          textAlign: paragraph.type.textAlign,
                        );

                        final anchor = getOffsetAnchor(characterOffset: offset, paragraph: paragraph);
                        if (anchor == null) {
                          return;
                        }

                        final wordSelection = bible.getWordsSelection(
                          Selection.character(anchor: anchor, translation: bible.translation),
                        );
                        onSelectionUpdated?.call(wordSelection, true);
                        selectionStartAnchorState.value = anchor;
                      },
                      onLongPressMoveUpdate: (details) {
                        if (paragraph is! VersesParagraph || selectionStartAnchorState.value == null) {
                          return;
                        }

                        final offset = paragraphSpans.getCharacterOffsetFromPosition(
                          width: constraints.maxWidth,
                          localPosition: details.localPosition,
                          textAlign: paragraph.type.textAlign,
                        );

                        final anchor = getOffsetAnchor(characterOffset: offset, paragraph: paragraph);
                        if (anchor == null) {
                          return;
                        }

                        final anchors = [?selectionStartAnchorState.value, anchor]..sort();

                        final wordsSelection = bible.getWordsSelection(
                          Selection(start: anchors.first, end: anchors.last, translation: bible.translation),
                        );
                        onSelectionUpdated?.call(wordsSelection, false);
                      },
                      onTapUp: (details) {
                        if (paragraph is! VersesParagraph) {
                          return;
                        }

                        final offset = paragraphSpans.getCharacterOffsetFromPosition(
                          width: constraints.maxWidth,
                          localPosition: details.localPosition,
                          textAlign: paragraph.type.textAlign,
                        );

                        final anchor = getOffsetAnchor(characterOffset: offset, paragraph: paragraph);
                        if (anchor != null) {
                          onReferencePressed?.call(anchor.toReference());
                        }
                      },
                      child: Listener(
                        onPointerMove: (move) {},
                        child: Text.rich(
                          TextSpan(children: paragraphSpans),
                          style: TextStyle(fontStyle: paragraph.as<VersesParagraph>()?.type.fontStyle ?? .normal),
                          textAlign: paragraph.as<VersesParagraph>()?.type.textAlign ?? .start,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
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
                      AnnotatedSizedWidgetSpan<ReferencePart>(
                        annotation: ReferencePart(reference: reference),
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
                          referencePart: ReferencePart(reference: reference),
                          annotations: passageAnnotationsWithNote,
                          isUnderlined: underlinedReferences.contains(reference),
                        ),
                    ],
                    ...AnnotatedTextSpan<ReferencePart>(
                      annotation: ReferencePart(reference: reference),
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
                          .map(
                            (offset, annotations) => MapEntry(
                              offset -
                                  (verseIndex == 0 && paragraph.firstVerseOffset > 0
                                      ? paragraph.firstVerseOffset + 1
                                      : 0),
                              annotations,
                            ),
                          )
                          .where((offset, annotations) => offset >= 0)
                          .map(
                            (offset, annotations) => MapEntry(
                              offset,
                              notesButtonSpan(
                                context,
                                ref,
                                referencePart: ReferencePart(reference: reference, paragraphOffset: offset),
                                annotations: annotations,
                                isUnderlined: underlinedReferences.contains(reference),
                              ),
                            ),
                          ),
                      annotationModifier: (_, offset) => ReferencePart(reference: reference, paragraphOffset: offset),
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

  SelectionWordAnchor? getOffsetAnchor({required int characterOffset, required VersesParagraph paragraph}) {
    var offsetCount = 0;
    for (final verse in paragraph.verses) {
      final referenceLength = verse.text.length + (verse == paragraph.verses.first ? paragraph.firstVerseOffset : 0);
      if (characterOffset < offsetCount + referenceLength) {
        return SelectionWordAnchor.fromReference(
          reference: getVerseReference(verse),
          characterOffset:
              (characterOffset - offsetCount + (verse == paragraph.verses.first ? paragraph.firstVerseOffset : 0))
                  .clampZero,
        );
      }

      offsetCount += referenceLength;
    }
    return null;
  }

  WidgetSpan notesButtonSpan(
    BuildContext context,
    WidgetRef ref, {
    required ReferencePart referencePart,
    required List<Annotation> annotations,
    required bool isUnderlined,
  }) {
    return AnnotatedSizedWidgetSpan<ReferencePart>(
      annotation: referencePart,
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

  (int, int)? getReferenceCharacterOffsets({required Reference reference, required List<InlineSpan> paragraphSpans}) {
    var cursor = 0;
    final matches = paragraphSpans
        .map((span) {
          final start = cursor;
          cursor += span.textLength;
          return span is IsAnnotatedSpan<ReferencePart> && span.annotation.reference == reference
              ? (span: span, start: start)
              : null;
        })
        .nonNulls
        .toList();

    return matches.isEmpty ? null : (matches.first.start, matches.last.start + matches.last.span.textLength);
  }

  (int, int)? getSelectionCharacterOffsets({
    required Selection selection,
    required VersesParagraph paragraph,
    required List<InlineSpan> paragraphSpans,
  }) {
    int getVerseOffset(Reference reference) =>
        reference == getVerseReference(paragraph.verses.first) && paragraph.firstVerseOffset > 0
        ? paragraph.firstVerseOffset + 1
        : 0;

    var cursor = 0;
    final matches = paragraphSpans
        .map((span) {
          final start = cursor;
          cursor += span.textLength;
          return span is AnnotatedTextSpan<ReferencePart> &&
                  selection.intersects(
                    Selection(
                      start: span.annotation.toSelectionAnchor(verseOffset: getVerseOffset(span.annotation.reference)),
                      end: span.annotation.toSelectionAnchor(
                        verseOffset: getVerseOffset(span.annotation.reference) + span.textLength,
                      ),
                      translation: user.translation,
                    ),
                  )
              ? (span: span, start: start, offset: span.annotation.paragraphOffset)
              : null;
        })
        .nonNulls
        .toList();

    if (matches.isEmpty) {
      return null;
    }

    final verseOffset = getVerseOffset(selection.end.toReference());
    final offsets = (
      matches.first.start - matches.first.offset + selection.start.characterOffset - verseOffset,
      matches.last.start - matches.last.offset + selection.end.characterOffset + 1 - verseOffset,
    );

    return offsets.$1.isNegative || offsets.$2.isNegative ? null : offsets;
  }
}

class ReferencePart {
  final Reference reference;
  final int paragraphOffset;

  const ReferencePart({required this.reference, this.paragraphOffset = 0});

  SelectionWordAnchor toSelectionAnchor({required int verseOffset}) =>
      SelectionWordAnchor.fromReference(reference: reference, characterOffset: verseOffset + paragraphOffset);
}
