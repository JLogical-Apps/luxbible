import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intersperse/intersperse.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import 'package:utils_core/utils_core.dart';

class BibleParagraphsConfiguration {
  final String fontFamily;
  final double sizeMultiplier;
  final bool useParagraphs;
  final bool showVerseNumbers;
  final bool showRedLetters;
  final bool Function(SectionType type)? showSection;

  const BibleParagraphsConfiguration({
    this.fontFamily = 'Inter',
    this.sizeMultiplier = BibleTextStyle.baseMultiplier,
    this.useParagraphs = true,
    this.showVerseNumbers = true,
    this.showRedLetters = true,
    this.showSection,
  });
}

class BibleInlineMarker {
  final int offset;
  final int anchorOffset;
  final bool isBoundInSelection;
  final bool isLeading;
  final WidgetBuilder builder;

  const BibleInlineMarker({
    required this.offset,
    int? anchorOffset,
    required this.builder,
    this.isBoundInSelection = false,
  }) : anchorOffset = anchorOffset ?? offset,
       isLeading = false;

  const BibleInlineMarker.leading({required this.builder})
    : offset = 0,
      anchorOffset = 0,
      isBoundInSelection = false,
      isLeading = true;
}

sealed class BiblePassageDecoration {
  final Object key;
  final Widget Function(BuildContext context, bool isDimmed) builder;

  const BiblePassageDecoration({required this.key, required this.builder});
}

class BibleVerseDecoration extends BiblePassageDecoration {
  final VerseSelection selection;

  const BibleVerseDecoration({required super.key, required super.builder, required this.selection});
}

class BibleTextDecoration extends BiblePassageDecoration {
  final BibleTextSelection selection;

  const BibleTextDecoration({required super.key, required super.builder, required this.selection});
}

class FixedNumExtentPrecalculationPolicy extends ExtentPrecalculationPolicy {
  final int numItems;

  FixedNumExtentPrecalculationPolicy({required this.numItems});

  @override
  bool shouldPrecalculateExtents(ExtentPrecalculationContext context) => context.numberOfItems < numItems;
}

class ParagraphsBuilder extends HookWidget {
  final List<Paragraph> paragraphs;
  final ChapterReference chapterReference;
  final BibleTranslation translation;
  final BibleParagraphsConfiguration configuration;

  final List<Reference> underlinedReferences;
  final BibleTextSelection? textSelection;
  final List<BiblePassageDecoration> decorations;
  final List<BibleInlineMarker> Function(Reference, Verse, int verseParagraphOffset)? markersBuilder;

  final Function(Reference)? onReferencePressed;
  final bool Function(BibleTextSelection)? onTextSelectionLongPressed;
  final Function(BibleTextSelection?, bool isNewSelection)? onTextSelectionUpdated;

  final PassageController? controller;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final bool removeScrollbarPadding;

  final Widget? header;
  final Widget? footer;

  const ParagraphsBuilder({
    super.key,
    required this.paragraphs,
    required this.chapterReference,
    required this.translation,
    required this.configuration,
    this.underlinedReferences = const [],
    this.textSelection,
    this.decorations = const [],
    this.markersBuilder,
    this.onReferencePressed,
    this.onTextSelectionLongPressed,
    this.onTextSelectionUpdated,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.removeScrollbarPadding = false,
    this.header,
    this.footer,
  });

  BookType get book => chapterReference.book;

  static const hebrewFontFamily = 'Ezra SIL SR';

  TextDirection get textDirection => translation.isRtl && book.testament == .oldTestament ? .rtl : .ltr;
  bool get isLtr => textDirection == .ltr;
  bool get useParagraphs => configuration.useParagraphs && isLtr;

  BibleTextStyle getBibleTextStyle(BuildContext context) =>
      BibleTextStyle(context, fontFamily: configuration.fontFamily, multiplier: configuration.sizeMultiplier);

  @override
  Widget build(BuildContext context) {
    final chapter = Chapter(paragraphs: paragraphs);

    final textSelectionStartAnchorState = useState<BibleTextSelectionWordAnchor?>(null);
    final extentPrecalculationPolicy = useMemoized(() => FixedNumExtentPrecalculationPolicy(numItems: 100));

    final paragraphSpansByParagraph = useMemoized(
      () => getParagraphSpansByParagraph(
        context,
        chapter: chapter,
        keyBySectionReference: controller?.keyBySectionReference,
      ),
      [
        paragraphs,
        translation,
        chapterReference,
        configuration.fontFamily,
        configuration.sizeMultiplier,
        configuration.useParagraphs,
        configuration.showVerseNumbers,
        configuration.showRedLetters,
        configuration.showSection,
        underlinedReferences,
        markersBuilder,
        controller?.keyBySectionReference,
        context.brightness,
      ],
    );

    final paragraphLayoutsRegistry = useRegistry<GlobalKey, ParagraphTextLayout>(listen: false);
    BibleTextSelectionWordAnchor? getAnchorAtGlobalPosition(Offset globalPosition) => paragraphLayoutsRegistry
        .items
        .values
        .map((layout) => getAnchorAt(globalPosition: globalPosition, layout: layout))
        .nonNulls
        .firstOrNull;

    final content = MediaQuery.withNoTextScaling(
      child: GestureDetector(
        onLongPressStart: (details) {
          if (onTextSelectionUpdated == null || onTextSelectionLongPressed == null) return;

          final anchor = getAnchorAtGlobalPosition(details.globalPosition);
          if (anchor == null) return;

          final wordTextSelection = chapter.getWordsSelection(
            BibleTextSelection.character(anchor: anchor, translation: translation),
          );

          if (onTextSelectionLongPressed?.call(wordTextSelection) == false) {
            return;
          }

          onTextSelectionUpdated?.call(wordTextSelection, true);
          textSelectionStartAnchorState.value = anchor;
        },
        onLongPressMoveUpdate: (details) {
          final startAnchor = textSelectionStartAnchorState.value;
          if (startAnchor == null) return;

          final anchor = getAnchorAtGlobalPosition(details.globalPosition);
          if (anchor == null) return;

          final anchors = [startAnchor, anchor]..sort();
          final wordsTextSelection = chapter.getWordsSelection(
            BibleTextSelection(start: anchors.first, end: anchors.last, translation: translation),
          );
          onTextSelectionUpdated?.call(wordsTextSelection, false);
        },
        onLongPressEnd: (_) => textSelectionStartAnchorState.value = null,
        onTapUp: (details) {
          final anchor = getAnchorAtGlobalPosition(details.globalPosition);
          if (anchor != null) {
            onReferencePressed?.call(anchor.toReference());
          } else {
            onTextSelectionUpdated?.call(null, true);
          }
        },
        child: SuperListView(
          controller: controller?.scrollController,
          listController: controller?.listController,
          physics: shrinkWrap ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
          primary: shrinkWrap ? false : null,
          padding: padding ?? .zero,
          shrinkWrap: shrinkWrap,
          addSemanticIndexes: false,
          extentPrecalculationPolicy: extentPrecalculationPolicy,
          children: paragraphSpansByParagraph.mapIndexed((index, entry) {
            final MapEntry(key: paragraph, value: originalSpans) = paragraphSpansByParagraph[index];

            final paragraphText = originalSpans.isEmpty
                ? SizedBox.shrink()
                : ParagraphText(
                    paragraph: paragraph,
                    originalSpans: originalSpans,
                    useParagraphLayout: useParagraphs,
                    textDirection: textDirection,
                    overlayBuilder: (context, layout) {
                      useRegistryItem(paragraphLayoutsRegistry, layout.textKey, layout);
                      return buildParagraphOverlays(context, layout: layout, chapter: chapter);
                    },
                  );

            if (index == 0 || index == paragraphSpansByParagraph.length - 1) {
              return Column(
                crossAxisAlignment: .stretch,
                spacing: 12,
                children: [
                  if (index == 0) ?header,
                  paragraphText,
                  if (index == paragraphSpansByParagraph.length - 1) ?footer,
                ],
              );
            }

            return paragraphText;
          }).toList(),
        ),
      ),
    );

    return shrinkWrap
        ? content
        : StyledScrollbar(
            controller: controller?.scrollController,
            removePadding: removeScrollbarPadding,
            child: content,
          );
  }

  Iterable<Widget> buildParagraphOverlays(
    BuildContext context, {
    required ParagraphTextLayout layout,
    required Chapter chapter,
  }) {
    final paragraph = layout.paragraph.as<VersesParagraph>();
    if (paragraph == null) return [];

    return [
      ...buildVerseAnchorOverlays(
        paragraphs: paragraphs,
        paragraph: paragraph,
        renderSpans: layout.renderSpans,
        maxWidth: layout.maxWidth,
        textDirection: textDirection,
        keyByReference: controller?.keyByReference,
        getVerseReference: getVerseReference,
      ),
      ...buildVerseDecorationOverlays(
        context,
        renderSpans: layout.renderSpans,
        paragraph: paragraph,
        chapter: chapter,
        maxWidth: layout.maxWidth,
        hangingIndent: layout.hangingIndent,
      ),
      ...buildTextDecorationOverlays(
        context,
        renderSpans: layout.renderSpans,
        paragraph: paragraph,
        maxWidth: layout.maxWidth,
        hangingIndent: layout.hangingIndent,
      ),
      ...buildActiveTextSelectionOverlays(context, layout: layout, paragraph: paragraph),
    ];
  }

  Iterable<Widget> buildActiveTextSelectionOverlays(
    BuildContext context, {
    required ParagraphTextLayout layout,
    required VersesParagraph paragraph,
  }) {
    final textSelection = this.textSelection;
    if (textSelection == null) return [];

    final (base, extent) =
        layout.renderSpans.spans.getTextSelectionCharacterOffsets(
          textSelection: textSelection,
          translation: translation,
          isParagraphs: configuration.useParagraphs,
        ) ??
        (null, null);
    if (base == null || extent == null) return [];

    return layout.renderSpans
        .getBoxesForSelection(baseOffset: base, extentOffset: extent)
        .map((box) => box.toRect())
        .withMergedLines()
        .withHangingIndent(useParagraphs ? layout.hangingIndent : 0)
        .map(
          (box) => Positioned.fromRect(
            key: ValueKey(box),
            rect: box.asTextSelection(multiplier: configuration.sizeMultiplier),
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
  }

  Iterable<Widget> buildVerseDecorationOverlays(
    BuildContext context, {
    required LaidOutInlineSpans renderSpans,
    required VersesParagraph paragraph,
    required Chapter chapter,
    required double maxWidth,
    required double hangingIndent,
  }) {
    final references = paragraph.verses.map(getVerseReference).toList();
    return decorations
        .whereType<BibleVerseDecoration>()
        .map((decoration) {
          final covered = references.where((reference) => decoration.selection.hasReference(reference)).toList();
          if (covered.isEmpty) {
            return null;
          }

          final offsets = referenceOffsets(
            renderSpans: renderSpans,
            chapter: chapter,
            first: covered.first,
            last: covered.last,
          );
          if (offsets == null) {
            return null;
          }

          return buildOverlays(
            renderSpans: renderSpans,
            paragraph: paragraph,
            maxWidth: maxWidth,
            hangingIndent: hangingIndent,
            base: offsets.$1,
            extent: offsets.$2,
            decoration: decoration,
            toRect: (box) => box.asVerseSelection(multiplier: configuration.sizeMultiplier),
            buildChild: () => decoration.builder(context, textSelection != null),
          );
        })
        .nonNulls
        .flattened;
  }

  Iterable<Widget> buildTextDecorationOverlays(
    BuildContext context, {
    required LaidOutInlineSpans renderSpans,
    required VersesParagraph paragraph,
    required double maxWidth,
    required double hangingIndent,
  }) => decorations
      .whereType<BibleTextDecoration>()
      .map((decoration) {
        final (base, extent) =
            renderSpans.spans.getTextSelectionCharacterOffsets(
              textSelection: decoration.selection,
              translation: translation,
              isParagraphs: configuration.useParagraphs,
            ) ??
            (null, null);
        if (base == null || extent == null) {
          return null;
        }

        return buildOverlays(
          renderSpans: renderSpans,
          paragraph: paragraph,
          maxWidth: maxWidth,
          hangingIndent: hangingIndent,
          base: base,
          extent: extent,
          decoration: decoration,
          toRect: (box) => box.asTextSelection(multiplier: configuration.sizeMultiplier),
          buildChild: () => decoration.builder(context, underlinedReferences.isNotEmpty),
        );
      })
      .nonNulls
      .flattened;

  (int, int)? referenceOffsets({
    required LaidOutInlineSpans renderSpans,
    required Chapter chapter,
    required Reference first,
    required Reference last,
  }) {
    final base = renderSpans.spans
        .getReferenceCharacterOffsets(
          reference: first,
          translation: translation,
          chapter: chapter,
          isParagraphs: configuration.useParagraphs,
        )
        ?.$1;
    final extent = renderSpans.spans
        .getReferenceCharacterOffsets(
          reference: last,
          translation: translation,
          chapter: chapter,
          isParagraphs: configuration.useParagraphs,
        )
        ?.$2;
    return base == null || extent == null ? null : (base, extent);
  }

  Iterable<Widget> buildOverlays({
    required LaidOutInlineSpans renderSpans,
    required VersesParagraph paragraph,
    required BiblePassageDecoration decoration,
    required double maxWidth,
    required double hangingIndent,
    required int base,
    required int extent,
    required Rect Function(Rect box) toRect,
    required Widget Function() buildChild,
  }) => renderSpans
      .getBoxesForSelection(baseOffset: base, extentOffset: extent)
      .map((box) => box.toRect())
      .withMergedLines()
      .withHangingIndent(useParagraphs ? hangingIndent : 0)
      .map(
        (box) => Positioned.fromRect(
          key: ValueKey((decoration.key, box)),
          rect: toRect(box),
          child: IgnorePointer(child: buildChild()),
        ),
      );

  Reference getVerseReference(Verse verse) => chapterReference.getReference(verse.verseNum);

  List<MapEntry<Paragraph, List<InlineSpan>>> getParagraphSpansByParagraph(
    BuildContext context, {
    required Chapter chapter,
    required Map<Reference, GlobalKey>? keyBySectionReference,
  }) {
    final bibleTextStyle = getBibleTextStyle(context);

    var maxPreviousVerseNum = 0;
    return chapter.paragraphs.mapIndexed((paragraphIndex, paragraph) {
      final previousParagraph = paragraphIndex == 0 ? null : chapter.paragraphs[paragraphIndex - 1];
      return MapEntry(paragraph, [
        if (previousParagraph?.as<VersesParagraph>()?.type.isPoetic == true &&
            paragraph is VersesParagraph &&
            !paragraph.type.isPoetic &&
            useParagraphs)
          TextSpan(text: '\n', style: bibleTextStyle.body.copyWith(height: 1.5)),
        ...switch (paragraph) {
          SectionParagraph(:final type) =>
            configuration.showSection?.call(type) ?? true
                ? buildSectionParagraphSpans(
                    paragraph: paragraph,
                    paragraphIndex: paragraphIndex,
                    previousParagraph: previousParagraph,
                    bibleTextStyle: bibleTextStyle,
                    leadingSpans: [
                      if (chapter.paragraphs.getVerseIntroducedBySectionAt(paragraphIndex) case final verse?
                          when chapter.paragraphs.getSectionIndexForVerse(verse.verseNum) == paragraphIndex)
                        SizedWidgetSpan(
                          child: SizedBox.shrink(key: keyBySectionReference?[getVerseReference(verse)]),
                          alignment: .top,
                          size: Size.zero,
                        ),
                    ],
                  )
                : <InlineSpan>[],
          VersesParagraph(:final verses, :final type, :final preventIndent) => [
            if (useParagraphs && !preventIndent)
              SizedWidgetSpan.space(size: Size(type.hangingIndent != 0 ? 0 : type.indent, 0)),
            ...verses
                .mapIndexed((verseIndex, verse) {
                  final reference = getVerseReference(verse);
                  final verseParagraphOffset = verseIndex == 0 ? paragraph.firstVerseOffset : 0;
                  final lastTextWordIndex = verse.words.lastIndexWhere((word) => word.text != null);
                  final markers = markersBuilder?.call(reference, verse, verseParagraphOffset) ?? [];

                  final spans = [
                    if (verse.verseNum > maxPreviousVerseNum)
                      ...[
                        if (configuration.showVerseNumbers)
                          buildVerseNumberSpan(
                            reference: reference,
                            verseNumber: verse.verseNum,
                            bibleTextStyle: bibleTextStyle,
                            isUnderlined: underlinedReferences.contains(reference),
                            textDirection: textDirection,
                          ),
                        if (verse.originalVerse case final originalVerse?)
                          AnnotatedSizedWidgetSpan<VerseElement>(
                            annotation: VerseElement(
                              anchor: BibleTextSelectionWordAnchor.fromReference(
                                reference: reference,
                                characterOffset: 0,
                              ),
                              isBoundInSelection: false,
                              isLeading: true,
                            ),
                            size: Size(
                              context.textStyle.labelXs.getWidth(
                                    t.verseNumbering.referenceLabel(
                                      translation: translation.title(),
                                      reference: originalVerse.format(),
                                    ),
                                  ) +
                                  18,
                              22 + 2 * configuration.sizeMultiplier,
                            ),
                            alignment: .middle,
                            child: Padding(
                              padding: .only(
                                right: isLtr ? 4 : 0,
                                left: isLtr ? 0 : 4,
                                bottom: 2 * configuration.sizeMultiplier,
                              ),
                              child: StyledTag.sm(
                                child: t.verseNumbering
                                    .referenceLabel(translation: translation.title(), reference: originalVerse.format())
                                    .toText(),
                                onPressed: () => context.showStyledDialog(
                                  (context) => StyledDialog.confirm(
                                    title: t.bibleDetails.verseNumbering.toText(),
                                    body: t.verseNumbering
                                        .explanation(
                                          translation: translation.title(),
                                          reference: reference.format(),
                                          originalReference: originalVerse.format(),
                                        )
                                        .toText(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ...markers
                            .where((marker) => marker.isLeading)
                            .map((marker) => buildMarkerSpan(context, reference: reference, marker: marker)),
                      ].maybeReversed(!isLtr),
                    ...verse.words.expandIndexed((wordIndex, word) {
                      if (word.text == null) {
                        return <InlineSpan>[];
                      }

                      final wordParagraphOffset =
                          verseParagraphOffset + verse.words.take(wordIndex).map((word) => word.text?.length ?? 0).sum;
                      final wordVerseOffset = wordParagraphOffset - verseParagraphOffset;
                      return AnnotatedTextSpan<VerseElement>(
                        annotation: VerseElement(
                          anchor: BibleTextSelectionWordAnchor.fromReference(
                            reference: reference,
                            characterOffset: wordParagraphOffset,
                          ),
                          isBoundInSelection: false,
                        ),
                        text: word.text,
                        style: bibleTextStyle.body.copyWith(
                          fontFamily: isLtr ? null : hebrewFontFamily,
                          color: word.redLetters && configuration.showRedLetters ? context.colors.red.dark : null,
                          fontStyle: word.italic || type.isItalic ? .italic : null,
                          decoration: underlinedReferences.contains(reference) ? .underline : null,
                        ),
                      ).withInjectedSpans(
                        markers
                            .where(
                              (marker) =>
                                  !marker.isLeading &&
                                  marker.offset >= wordVerseOffset &&
                                  marker.offset <= wordVerseOffset + (word.text?.length ?? 0),
                            )
                            .map(
                              (marker) => (
                                marker.offset - wordVerseOffset,
                                buildMarkerSpan(context, reference: reference, marker: marker),
                              ),
                            )
                            .toList(),
                        injectAtEnd: wordIndex == lastTextWordIndex,
                        annotationModifier: (_, offset) => VerseElement(
                          anchor: BibleTextSelectionWordAnchor.fromReference(
                            reference: reference,
                            characterOffset: offset + wordParagraphOffset,
                          ),
                          isBoundInSelection: false,
                        ),
                      );
                    }),
                  ];
                  maxPreviousVerseNum = verse.verseNum;
                  return spans;
                })
                .intersperse([TextSpan(text: useParagraphs ? ' ' : '\n', style: bibleTextStyle.body)])
                .flattenedToList,
          ],
          BreakParagraph() =>
            useParagraphs && previousParagraph is! SectionParagraph
                ? [TextSpan(text: '\n', style: bibleTextStyle.body.copyWith(height: 0.75))]
                : <InlineSpan>[],
        },
      ]);
    }).toList();
  }

  WidgetSpan buildMarkerSpan(BuildContext context, {required Reference reference, required BibleInlineMarker marker}) {
    final bibleTextStyle = getBibleTextStyle(context);
    return AnnotatedSizedWidgetSpan<VerseElement>(
      annotation: VerseElement(
        anchor: BibleTextSelectionWordAnchor.fromReference(reference: reference, characterOffset: marker.anchorOffset),
        isBoundInSelection: marker.isBoundInSelection,
        isLeading: marker.isLeading,
      ),
      size: Size(30, bibleTextStyle.body.fontSize!),
      alignment: .middle,
      child: OverflowBox(
        maxHeight: bibleTextStyle.body.totalHeight + 4,
        maxWidth: 30,
        child: Underline(
          isUnderlined: underlinedReferences.contains(reference),
          style: bibleTextStyle.body,
          child: marker.builder(context),
        ),
      ),
    );
  }

  BibleTextSelectionWordAnchor? getOffsetAnchor({required int characterOffset, required VersesParagraph paragraph}) {
    var offsetCount = 0;
    for (final verse in paragraph.verses) {
      final referenceLength = verse.text.length;
      if (characterOffset < offsetCount + referenceLength) {
        final additionalOffset = verse == paragraph.verses.first ? paragraph.firstVerseOffset : 0;
        return BibleTextSelectionWordAnchor.fromReference(
          reference: getVerseReference(verse),
          characterOffset: (characterOffset - offsetCount + additionalOffset).clampZero,
        );
      }

      offsetCount += referenceLength + 1;
    }
    return null;
  }

  BibleTextSelectionWordAnchor? getAnchorAt({required Offset globalPosition, required ParagraphTextLayout layout}) {
    final paragraph = layout.paragraph.as<VersesParagraph>();
    final box = layout.textKey.currentContext?.findRenderObject() as RenderBox?;
    if (paragraph == null || box == null) return null;

    final localPosition = box.globalToLocal(globalPosition);
    if (localPosition.dx < 0 ||
        localPosition.dy < 0 ||
        localPosition.dx > box.size.width ||
        localPosition.dy > box.size.height) {
      return null;
    }

    return getOffsetAnchor(
      characterOffset: layout.renderSpans.getCharacterOffsetFromPosition(
        width: layout.maxWidth,
        localPosition: localPosition,
        textAlign: paragraph.type.textAlign,
        textDirection: textDirection,
      ),
      paragraph: paragraph,
    );
  }
}

extension on Rect {
  Rect asVerseSelection({required double multiplier}) =>
      .fromCenter(center: center + Offset(0, 2), width: width + 4 * multiplier, height: min(32 * multiplier, height));

  Rect asTextSelection({required double multiplier}) =>
      .fromCenter(center: center + Offset(0, 2), width: width + 2 * multiplier, height: min(28 * multiplier, height));
}
