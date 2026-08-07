import 'dart:math';

import 'package:bible/models/annotation.dart';
import 'package:bible/models/user/theme_layout_configuration.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/app_bible_provider.dart';
import 'package:bible/providers/root_ref.dart' as root_ref;
import 'package:bible/ui/sheets/annotation_sheet.dart';
import 'package:bible/ui/sheets/preview_passage_sheet.dart';
import 'package:bible/ui/widgets/bible_selection.dart';
import 'package:bible/ui/widgets/highlight_underline.dart';
import 'package:bible/ui/widgets/passage_controller.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intersperse/intersperse.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import 'package:utils_core/utils_core.dart';

class ParagraphsBuilder extends HookWidget {
  final List<Paragraph> paragraphs;
  final ChapterReference chapterReference;
  final User user;
  final BibleTranslation translation;

  final List<Reference> underlinedReferences;

  final BibleSelection? selection;
  final Function(VerseSelection)? onNavigateToVerseSelection;

  final PassageController? controller;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;

  final Widget? header;
  final Widget? footer;

  const ParagraphsBuilder({
    super.key,
    required this.paragraphs,
    required this.chapterReference,
    required this.user,
    required this.translation,
    this.underlinedReferences = const [],
    this.selection,
    this.onNavigateToVerseSelection,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.header,
    this.footer,
  });

  BibleTextSelection? get textSelection => selection?.textSelection;

  List<Reference> get highlightedReferences => selection?.references ?? underlinedReferences;

  BookType get book => chapterReference.book;

  static const hebrewFontFamily = 'Ezra SIL SR';

  TextDirection get textDirection => translation.isRtl && book.testament == .oldTestament ? .rtl : .ltr;
  bool get isLtr => textDirection == .ltr;
  bool get useParagraphs => user.themeLayout.paragraphs && isLtr;

  BibleTextStyle getBibleTextStyle(BuildContext context) =>
      BibleTextStyle(context, fontFamily: user.themeLayout.font.fontFamily, multiplier: getSizeMultiplier(context));

  FontSizeSpacing getFontSizeSpacing(BuildContext context) =>
      user.themeLayout.getFontSizeSpacingFor(translation.bibleLanguage, context.textScaling);

  double getSizeMultiplier(BuildContext context) =>
      BibleTextStyle.baseMultiplier * getFontSizeSpacing(context).multiplier;

  double getUnderlineThickness(BuildContext context) => 4 * getSizeMultiplier(context);

  @override
  Widget build(BuildContext context) {
    final chapter = Chapter(paragraphs: paragraphs);

    final textSelectionStartAnchorState = useState<BibleTextSelectionWordAnchor?>(null);

    final paragraphSpansByParagraph = useMemoized(
      () => getParagraphSpansByParagraph(
        context,
        chapter: chapter,
        keyBySectionReference: controller?.keyBySectionReference,
      ),
      [
        paragraphs,
        user,
        translation,
        chapterReference,
        highlightedReferences,
        controller?.keyBySectionReference,
        context.brightness,
      ],
    );

    final textSelectionAnnotations = useMemoized(
      () => user.getTextSelectionAnnotationsInVerseSelection(
        chapterReference.toVerseSelection(),
        translation: translation,
      ),
      [user.annotations, user.notebooks, chapterReference, translation],
    );

    final paragraphHitTesters = <ParagraphHitTester>[];
    BibleTextSelectionWordAnchor? getAnchorAtGlobalPosition(Offset globalPosition) =>
        paragraphHitTesters.map((tester) => tester.getAnchorAt(globalPosition)).nonNulls.firstOrNull;

    return MediaQuery.withNoTextScaling(
      child: GestureDetector(
        onLongPressStart: (details) {
          final selection = this.selection;
          final onNavigateToVerseSelection = this.onNavigateToVerseSelection;
          if (selection == null || onNavigateToVerseSelection == null) return;

          final anchor = getAnchorAtGlobalPosition(details.globalPosition);
          if (anchor == null) return;

          final wordTextSelection = chapter.getWordsSelection(
            BibleTextSelection.character(anchor: anchor, translation: translation),
          );

          if (!selection.onHandleLongPress(
            context,
            selection: wordTextSelection,
            user: user,
            onNavigateToVerseSelection: onNavigateToVerseSelection,
          )) {
            return;
          }

          selection.onTextSelectionUpdated(selection: wordTextSelection, isNewSelection: true, user: user);
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
          selection?.onTextSelectionUpdated(selection: wordsTextSelection, isNewSelection: false, user: user);
        },
        onLongPressEnd: (_) => textSelectionStartAnchorState.value = null,
        onTapUp: (details) {
          final anchor = getAnchorAtGlobalPosition(details.globalPosition);
          if (anchor != null) {
            selection?.onReferencePressed(anchor.toReference(), user: user);
          } else {
            selection?.onTextSelectionUpdated(selection: null, isNewSelection: true, user: user);
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
          children: paragraphSpansByParagraph.mapIndexed((index, entry) {
            final MapEntry(key: paragraph, value: originalSpans) = paragraphSpansByParagraph[index];

            final paragraphText = originalSpans.isEmpty
                ? SizedBox.shrink()
                : ParagraphText(
                    paragraph: paragraph,
                    originalSpans: originalSpans,
                    useParagraphLayout: useParagraphs,
                    textDirection: textDirection,
                    overlayBuilder: (context, layout) => buildParagraphOverlays(
                      context,
                      layout: layout,
                      chapter: chapter,
                      paragraphHitTesters: paragraphHitTesters,
                      textSelectionAnnotations: textSelectionAnnotations,
                    ),
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
  }

  Iterable<Widget> buildParagraphOverlays(
    BuildContext context, {
    required ParagraphTextLayout layout,
    required Chapter chapter,
    required List<ParagraphHitTester> paragraphHitTesters,
    required List<(Annotation, BibleTextSelection)> textSelectionAnnotations,
  }) {
    final paragraph = layout.paragraph.as<VersesParagraph>();
    if (paragraph == null) return [];

    paragraphHitTesters.add(
      ParagraphHitTester(
        textKey: layout.textKey,
        resolve: (localPosition) => getOffsetAnchor(
          characterOffset: layout.renderSpans.getCharacterOffsetFromPosition(
            width: layout.maxWidth,
            localPosition: localPosition,
            textAlign: paragraph.type.textAlign,
            textDirection: textDirection,
          ),
          paragraph: paragraph,
        ),
      ),
    );

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
      ...buildVerseAnnotationOverlays(
        context,
        renderSpans: layout.renderSpans,
        paragraph: paragraph,
        chapter: chapter,
        maxWidth: layout.maxWidth,
        hangingIndent: layout.hangingIndent,
      ),
      ...buildTextSelectionAnnotationOverlays(
        context,
        renderSpans: layout.renderSpans,
        paragraph: paragraph,
        maxWidth: layout.maxWidth,
        hangingIndent: layout.hangingIndent,
        textSelectionAnnotations: textSelectionAnnotations,
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
          isParagraphs: user.themeLayout.paragraphs,
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
            rect: box.asTextSelection(multiplier: getSizeMultiplier(context)),
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

  Iterable<Widget> buildVerseAnnotationOverlays(
    BuildContext context, {
    required LaidOutInlineSpans renderSpans,
    required VersesParagraph paragraph,
    required Chapter chapter,
    required double maxWidth,
    required double hangingIndent,
  }) {
    final references = paragraph.verses.map(getVerseReference).toList();
    return user.visibleAnnotations
        .where((annotation) => annotation.verseSelection != null)
        .map((annotation) {
          final covered = references.where((reference) => annotation.verseSelection!.hasReference(reference)).toList();
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
            annotation: annotation,
            toRect: (box) => box.asVerseSelection(multiplier: getSizeMultiplier(context)),
            buildChild: () => buildAnnotationChild(context, annotation: annotation, isDimmed: textSelection != null),
          );
        })
        .nonNulls
        .flattened;
  }

  Iterable<Widget> buildTextSelectionAnnotationOverlays(
    BuildContext context, {
    required LaidOutInlineSpans renderSpans,
    required VersesParagraph paragraph,
    required double maxWidth,
    required double hangingIndent,
    required List<(Annotation, BibleTextSelection)> textSelectionAnnotations,
  }) => textSelectionAnnotations
      .map((record) {
        final (annotation, textSelection) = record;
        final (base, extent) =
            renderSpans.spans.getTextSelectionCharacterOffsets(
              textSelection: textSelection,
              translation: translation,
              isParagraphs: user.themeLayout.paragraphs,
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
          annotation: annotation,
          toRect: (box) => box.asTextSelection(multiplier: getSizeMultiplier(context)),
          buildChild: () =>
              buildAnnotationChild(context, annotation: annotation, isDimmed: highlightedReferences.isNotEmpty),
        );
      })
      .nonNulls
      .flattened;

  Widget buildAnnotationChild(BuildContext context, {required Annotation annotation, required bool isDimmed}) {
    final color = annotation.color.toHue(context.colors).primary;
    return annotation.style.type == .highlight
        ? AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            decoration: BoxDecoration(
              borderRadius: .circular(4),
              color: color.withValues(alpha: isDimmed ? 0.2 : 0.5),
            ),
          )
        : HighlightUnderline(
            color: color.withValues(alpha: isDimmed ? 0.35 : 0.9),
            wavy: annotation.style.type == .wavyUnderline,
            thickness: getUnderlineThickness(context),
          );
  }

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
          isParagraphs: user.themeLayout.paragraphs,
        )
        ?.$1;
    final extent = renderSpans.spans
        .getReferenceCharacterOffsets(
          reference: last,
          translation: translation,
          chapter: chapter,
          isParagraphs: user.themeLayout.paragraphs,
        )
        ?.$2;
    return base == null || extent == null ? null : (base, extent);
  }

  Iterable<Widget> buildOverlays({
    required LaidOutInlineSpans renderSpans,
    required VersesParagraph paragraph,
    required Annotation annotation,
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
          key: ValueKey((annotation, box)),
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
            user.themeLayout.paragraphs)
          TextSpan(text: '\n', style: bibleTextStyle.body.copyWith(height: 1.5)),
        ...switch (paragraph) {
          SectionParagraph(:final type) =>
            user.themeLayout.sections.showFor(translation: translation, sectionType: type)
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

                  int getFootnoteOffset(Footnote footnote) => footnote.offset.clamp(0, verse.text.length);

                  final verseSelectionAnnotations = user.getVerseSelectionAnnotations(
                    VerseSelection.reference(reference),
                  );
                  final verseSelectionAnnotationsWithNote = verseSelectionAnnotations
                      .where(
                        (annotation) =>
                            annotation.note.isNotEmpty &&
                            annotation.verseSelection?.references.firstOrNull == reference,
                      )
                      .toList();

                  final spans = [
                    if (verse.verseNum > maxPreviousVerseNum)
                      ...[
                        if (user.themeLayout.verseNumbers)
                          buildVerseNumberSpan(
                            reference: reference,
                            verseNumber: verse.verseNum,
                            bibleTextStyle: bibleTextStyle,
                            isUnderlined: highlightedReferences.contains(reference),
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
                              22 + 2 * getSizeMultiplier(context),
                            ),
                            alignment: .middle,
                            child: Padding(
                              padding: .only(
                                right: isLtr ? 4 : 0,
                                left: isLtr ? 0 : 4,
                                bottom: 2 * getSizeMultiplier(context),
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
                        if (verseSelectionAnnotationsWithNote.isNotEmpty)
                          notesButtonSpan(
                            context,
                            element: VerseElement(
                              anchor: BibleTextSelectionWordAnchor.fromReference(
                                reference: reference,
                                characterOffset: 0,
                              ),
                              isBoundInSelection: false,
                              isLeading: true,
                            ),
                            annotations: verseSelectionAnnotationsWithNote,
                            isUnderlined: highlightedReferences.contains(reference),
                          ),
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
                          color: word.redLetters && user.themeLayout.redLetters ? context.colors.red.dark : null,
                          fontStyle: word.italic || type.isItalic ? .italic : null,
                          decoration: highlightedReferences.contains(reference) ? .underline : null,
                        ),
                      ).withInjectedSpans(
                        [
                          ...user
                              .getTextSelectionAnnotationsWithNotesByOffset(
                                reference: reference,
                                translation: translation,
                              )
                              .where(
                                (offset, annotations) =>
                                    offset >= wordParagraphOffset &&
                                    offset <= wordParagraphOffset + (word.text?.length ?? 0),
                              )
                              .mapToIterable(
                                (offset, annotations) => (
                                  offset - wordParagraphOffset,
                                  notesButtonSpan(
                                    context,
                                    element: VerseElement(
                                      anchor: BibleTextSelectionWordAnchor.fromReference(
                                        reference: reference,
                                        characterOffset: offset,
                                      ),
                                      isBoundInSelection: true,
                                    ),
                                    annotations: annotations,
                                    isUnderlined: highlightedReferences.contains(reference),
                                  ),
                                ),
                              ),
                          if (user.themeLayout.footnotes)
                            ...?verse.footnotes
                                ?.where(
                                  (footnote) =>
                                      getFootnoteOffset(footnote) >= wordVerseOffset &&
                                      getFootnoteOffset(footnote) <= wordVerseOffset + (word.text?.length ?? 0),
                                )
                                .groupListsBy((footnote) => getFootnoteOffset(footnote) - wordVerseOffset)
                                .mapToIterable(
                                  (relativeOffset, footnotes) => (
                                    relativeOffset,
                                    footnoteButtonSpan(
                                      context,
                                      element: VerseElement(
                                        anchor: BibleTextSelectionWordAnchor.fromReference(
                                          reference: reference,
                                          characterOffset: verseParagraphOffset + getFootnoteOffset(footnotes.first),
                                        ),
                                        isBoundInSelection: false,
                                      ),
                                      footnotes: footnotes,
                                      isUnderlined: highlightedReferences.contains(reference),
                                    ),
                                  ),
                                ),
                        ],
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
                .intersperse([TextSpan(text: user.themeLayout.paragraphs ? ' ' : '\n', style: bibleTextStyle.body)])
                .flattenedToList,
          ],
          BreakParagraph() =>
            user.themeLayout.paragraphs && previousParagraph is! SectionParagraph
                ? [TextSpan(text: '\n', style: bibleTextStyle.body.copyWith(height: 0.75))]
                : <InlineSpan>[],
        },
      ]);
    }).toList();
  }

  WidgetSpan notesButtonSpan(
    BuildContext context, {
    required VerseElement element,
    required List<Annotation> annotations,
    required bool isUnderlined,
  }) {
    final bibleTextStyle = getBibleTextStyle(context);
    return AnnotatedSizedWidgetSpan<VerseElement>(
      annotation: element,
      size: Size(30, bibleTextStyle.body.fontSize!),
      alignment: .middle,
      child: OverflowBox(
        maxHeight: bibleTextStyle.body.totalHeight + 4,
        maxWidth: 30,
        child: Underline(
          isUnderlined: isUnderlined,
          style: bibleTextStyle.body,
          child: Padding(
            padding: .only(bottom: 4),
            child: StyledCircleButton.sm(
              onPressed: () => context.showStyledSheet(
                (context) => StyledSheet(
                  title: t.labels.notes.toText(),
                  children: annotations
                      .map(
                        (annotation) => Consumer(
                          builder: (context, ref, child) {
                            final annotationText = ref
                                .watch(
                                  annotationSelectionTextProvider(
                                    translation: translation,
                                    selection: annotation.selection,
                                  ),
                                )
                                .value;
                            return StyledSwipeable(
                              key: ValueKey(annotation),
                              actions: [
                                .delete(
                                  onPressed: () async {
                                    final confirmed = await context.showStyledDialog(
                                      (context) => StyledDialog.confirmDelete(
                                        cancelLabel: t.common.nevermind.toText(),
                                        title: t.annotationUi.deleteAnnotation.toText(),
                                        body: t.annotationUi.deleteConfirmation.toText(),
                                      ),
                                    );
                                    if (confirmed == true && context.mounted) {
                                      context.pop();
                                      ref.updateUser((user) => user.withRemovedAnnotation(annotation));
                                    }
                                  },
                                ),
                              ],
                              child: StyledListItem(
                                title: annotation.note.toText(),
                                subtitle: StyledLoading(
                                  child: annotationText == null
                                      ? null
                                      : Text(annotationText, maxLines: 1, overflow: .ellipsis),
                                ),
                                trailing: StyledCircleButton.md(
                                  child: Symbols.more_vert.toIcon(),
                                  onPressed: () => context.showStyledSheet(
                                    (context) => StyledSheet(
                                      title: t.labels.annotation.toText(),
                                      children: [
                                        StyledListItem(
                                          title: t.common.edit.toText(),
                                          leading: Symbols.edit.toIcon(),
                                          onPressed: () async {
                                            context.pop();
                                            context.pop();
                                            final newAnnotation = await AnnotationSheet.show(
                                              context,
                                              selection: annotation.selection,
                                              annotation: annotation,
                                            );
                                            if (newAnnotation != null) {
                                              root_ref.ref.updateUser(
                                                (user) => user.withAnnotationUpdated(annotation, newAnnotation),
                                              );
                                            }
                                          },
                                        ),
                                        StyledListItem(
                                          title: t.common.delete.toText(),
                                          leading: Icon(Symbols.delete, color: context.colors.contentCritical),
                                          onPressed: () async {
                                            final confirmed = await context.showStyledDialog(
                                              (context) => StyledDialog.confirmDelete(
                                                cancelLabel: t.common.nevermind.toText(),
                                                title: t.annotationUi.deleteAnnotation.toText(),
                                                body: t.annotationUi.deleteConfirmation.toText(),
                                              ),
                                            );
                                            if (confirmed == true && context.mounted) {
                                              context.pop();
                                              context.pop();
                                              root_ref.ref.updateUser((user) => user.withRemovedAnnotation(annotation));
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
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

  WidgetSpan footnoteButtonSpan(
    BuildContext context, {
    required VerseElement element,
    required List<Footnote> footnotes,
    required bool isUnderlined,
  }) {
    final bibleTextStyle = getBibleTextStyle(context);
    return AnnotatedSizedWidgetSpan<VerseElement>(
      annotation: element,
      size: Size(24, bibleTextStyle.body.fontSize!),
      alignment: .middle,
      child: OverflowBox(
        maxHeight: bibleTextStyle.body.totalHeight + 4,
        maxWidth: 30,
        child: Underline(
          isUnderlined: isUnderlined,
          style: bibleTextStyle.body,
          child: Padding(
            padding: .only(bottom: 4),
            child: StyledCircleButton.sm(
              onPressed: () => context.showStyledSheet(
                (context) => StyledSheet(
                  title: t.labels.footnotes.toText(),
                  children: footnotes
                      .map(
                        (footnote) => StyledListItem(
                          title: MarkdownBuilder(
                            footnote.text,
                            onLinkPressed: (text, link) => PreviewPassageSheet.show(
                              context,
                              verseSelection: VerseSelection.fromOsisId(link),
                              onNavigateToVerseSelection: (selection) {
                                if (onNavigateToVerseSelection != null) {
                                  context.pop();
                                  onNavigateToVerseSelection?.call(selection);
                                }
                              },
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              child: Icon(Symbols.article, color: context.colors.contentDisabled),
            ),
          ),
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
}

class ParagraphHitTester {
  final GlobalKey textKey;
  final BibleTextSelectionWordAnchor? Function(Offset localPosition) resolve;

  const ParagraphHitTester({required this.textKey, required this.resolve});

  BibleTextSelectionWordAnchor? getAnchorAt(Offset globalPosition) {
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

extension on Rect {
  Rect asVerseSelection({required double multiplier}) =>
      .fromCenter(center: center + Offset(0, 2), width: width + 4 * multiplier, height: min(32 * multiplier, height));

  Rect asTextSelection({required double multiplier}) =>
      .fromCenter(center: center + Offset(0, 2), width: width + 2 * multiplier, height: min(28 * multiplier, height));
}
