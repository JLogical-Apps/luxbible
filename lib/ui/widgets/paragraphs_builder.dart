import 'dart:math';

import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/footnote.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/models/user/theme_layout_configuration.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/root_ref.dart' as root_ref;
import 'package:bible/style/style.dart';
import 'package:bible/ui/sheets/annotation_sheet.dart';
import 'package:bible/ui/sheets/preview_passage_sheet.dart';
import 'package:bible/ui/widgets/annotated_span.dart';
import 'package:bible/ui/widgets/bible_selection.dart';
import 'package:bible/ui/widgets/highlight_underline.dart';
import 'package:bible/ui/widgets/markdown_builder.dart';
import 'package:bible/ui/widgets/sized_widget_span.dart';
import 'package:bible/ui/widgets/underline.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/num_extensions.dart';
import 'package:bible/utils/extensions/paragraph_style_extensions.dart';
import 'package:bible/utils/extensions/rect_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/span_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intersperse/intersperse.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:utils_core/utils_core.dart';

class ParagraphsBuilder extends HookWidget {
  final List<Paragraph> paragraphs;
  final ChapterReference chapterReference;
  final User user;
  final BibleTranslation translation;

  final List<Reference> underlinedReferences;

  final BibleSelection? selection;
  final Function(VerseSelection)? onNavigateToVerseSelection;

  final Map<Reference, GlobalKey>? keyByReference;
  final Map<Reference, GlobalKey>? keyBySectionReference;

  const ParagraphsBuilder({
    super.key,
    required this.paragraphs,
    required this.chapterReference,
    required this.user,
    required this.translation,
    this.underlinedReferences = const [],
    this.selection,
    this.onNavigateToVerseSelection,
    this.keyByReference,
    this.keyBySectionReference,
  });

  BibleTextSelection? get textSelection => selection?.textSelection;

  List<Reference> get highlightedReferences => selection?.references ?? underlinedReferences;

  BookType get book => chapterReference.book;

  static const hebrewFontFamily = 'Ezra SIL SR';

  TextDirection get textDirection => translation.isRtl && book.testament == .oldTestament ? .rtl : .ltr;
  bool get isLtr => textDirection == .ltr;
  bool get useParagraphs => user.themeLayout.paragraphs && isLtr;

  BibleTextStyle getBibleTextStyle(BuildContext context) =>
      BibleTextStyle(context, config: user.themeLayout, fontSizeSpacing: getFontSizeSpacing(context));

  FontSizeSpacing getFontSizeSpacing(BuildContext context) =>
      user.themeLayout.getFontSizeSpacingFor(translation.language, context.textScaling);

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
        keyByReference: keyByReference,
        keyBySectionReference: keyBySectionReference,
      ).where((entry) => entry.value.isNotEmpty).toList(),
      [
        paragraphs,
        user,
        translation,
        chapterReference,
        highlightedReferences,
        keyByReference,
        keyBySectionReference,
        context.brightness,
      ],
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
        child: Column(
          crossAxisAlignment: .stretch,
          children: paragraphSpansByParagraph.mapEntries((paragraph, originalSpans) {
            final versesParagraph = paragraph.as<VersesParagraph>();
            final blockIndent = user.themeLayout.paragraphs && versesParagraph != null
                ? versesParagraph.type.blockIndent
                : 0.0;
            final hangingIndent = versesParagraph?.type.hangingIndent ?? 0.0;

            return Padding(
              padding: useParagraphs ? (versesParagraph?.type.padding ?? .zero).copyWith(left: blockIndent) : .zero,
              child: LayoutBuilder(
                builder: (context, constraints) => HookBuilder(
                  builder: (context) {
                    final textKey = GlobalKey(debugLabel: versesParagraph?.verses.first.verseNum.toString());

                    final renderSpans = useMemoized(
                      () => versesParagraph != null && useParagraphs
                          ? originalSpans
                                .withHangingIndent<VerseElement>(
                                  width: constraints.maxWidth,
                                  textAlign: versesParagraph.type.textAlign,
                                  hangingIndent: hangingIndent,
                                  annotationModifier: (element, charactersAdded) =>
                                      element.copyWith(anchor: element.anchor.withCharactersAdded(charactersAdded)),
                                )
                                .withUnorphanedLeadingSpans(
                                  width: constraints.maxWidth,
                                  textAlign: versesParagraph.type.textAlign,
                                  textDirection: textDirection,
                                  isLeadingSpan: (span) =>
                                      span is IsAnnotatedSpan<VerseElement> && span.annotation.isLeading,
                                )
                          : originalSpans,
                      [originalSpans, constraints.maxWidth],
                    );

                    if (paragraph is VersesParagraph) {
                      paragraphHitTesters.add(
                        ParagraphHitTester(
                          textKey: textKey,
                          resolve: (localPosition) => getOffsetAnchor(
                            characterOffset: renderSpans.getCharacterOffsetFromPosition(
                              width: constraints.maxWidth,
                              localPosition: localPosition,
                              textAlign: paragraph.type.textAlign,
                              textDirection: textDirection,
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
                          ...buildVerseAnchorOverlays(
                            renderSpans: renderSpans,
                            paragraph: paragraph,
                            maxWidth: constraints.maxWidth,
                          ),
                          ...buildVerseAnnotationOverlays(
                            context,
                            renderSpans: renderSpans,
                            paragraph: paragraph,
                            chapter: chapter,
                            maxWidth: constraints.maxWidth,
                            hangingIndent: hangingIndent,
                          ),
                          ...buildTextSelectionAnnotationOverlays(
                            context,
                            renderSpans: renderSpans,
                            paragraph: paragraph,
                            maxWidth: constraints.maxWidth,
                            hangingIndent: hangingIndent,
                          ),
                          if (textSelection case final textSelection?)
                            ...?() {
                              final (base, extent) =
                                  renderSpans.getTextSelectionCharacterOffsets(
                                    textSelection: textSelection,
                                    translation: translation,
                                    isParagraphs: user.themeLayout.paragraphs,
                                  ) ??
                                  (null, null);
                              if (base == null || extent == null) {
                                return null;
                              }

                              return renderSpans
                                  .getBoxesForSelection(
                                    baseOffset: base,
                                    extentOffset: extent,
                                    width: constraints.maxWidth,
                                    textAlign: paragraph.type.textAlign,
                                    textDirection: textDirection,
                                  )
                                  .map((box) => box.toRect())
                                  .withMergedLines()
                                  .withHangingIndent(hangingIndent)
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
                            }(),
                        ],
                        Text.rich(
                          key: textKey,
                          TextSpan(children: renderSpans),
                          style: TextStyle(inherit: false),
                          textAlign: paragraph.as<VersesParagraph>()?.type.textAlign ?? .start,
                          textDirection: textDirection,
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Iterable<Widget> buildVerseAnnotationOverlays(
    BuildContext context, {
    required List<InlineSpan> renderSpans,
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

  Iterable<Widget> buildVerseAnchorOverlays({
    required List<InlineSpan> renderSpans,
    required VersesParagraph paragraph,
    required double maxWidth,
  }) => paragraph.verses
      .map(getVerseReference)
      .distinct
      .where(
        (reference) =>
            paragraphs.whereType<VersesParagraph>().firstWhereOrNull(
              (candidate) => candidate.verses.any((verse) => verse.verseNum == reference.verseNum),
            ) ==
            paragraph,
      )
      .map((reference) {
        final key = keyByReference?[reference];
        final position = renderSpans.getFirstSpanPositionForReference(reference);
        if (key == null || position == null) {
          return null;
        }

        final box = renderSpans
            .getBoxesForSelection(
              baseOffset: position,
              extentOffset: position + 1,
              width: maxWidth,
              textAlign: paragraph.type.textAlign,
              textDirection: textDirection,
            )
            .firstOrNull;
        if (box == null) {
          return null;
        }

        return Positioned.fromRect(
          rect: box.toRect(),
          child: ExcludeSemantics(child: SizedBox.expand(key: key)),
        );
      })
      .nonNulls;

  Iterable<Widget> buildTextSelectionAnnotationOverlays(
    BuildContext context, {
    required List<InlineSpan> renderSpans,
    required VersesParagraph paragraph,
    required double maxWidth,
    required double hangingIndent,
  }) => user
      .getTextSelectionAnnotationsInVerseSelection(chapterReference.toVerseSelection(), translation: translation)
      .map((record) {
        final (annotation, textSelection) = record;
        final (base, extent) =
            renderSpans.getTextSelectionCharacterOffsets(
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
    required List<InlineSpan> renderSpans,
    required Chapter chapter,
    required Reference first,
    required Reference last,
  }) {
    final base = renderSpans
        .getReferenceCharacterOffsets(
          reference: first,
          translation: translation,
          chapter: chapter,
          isParagraphs: user.themeLayout.paragraphs,
        )
        ?.$1;
    final extent = renderSpans
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
    required List<InlineSpan> renderSpans,
    required VersesParagraph paragraph,
    required Annotation annotation,
    required double maxWidth,
    required double hangingIndent,
    required int base,
    required int extent,
    required Rect Function(Rect box) toRect,
    required Widget Function() buildChild,
  }) => renderSpans
      .getBoxesForSelection(
        baseOffset: base,
        extentOffset: extent,
        width: maxWidth,
        textAlign: paragraph.type.textAlign,
        textDirection: textDirection,
      )
      .map((box) => box.toRect())
      .withMergedLines()
      .withHangingIndent(hangingIndent)
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
    required Map<Reference, GlobalKey>? keyByReference,
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
          SectionParagraph(:final text, :final type) =>
            user.themeLayout.sections.showFor(translation: translation, sectionType: type)
                ? [
                    if (type.isLarge &&
                        paragraphIndex != 0 &&
                        ((previousParagraph is! SectionParagraph || type > previousParagraph.type)))
                      TextSpan(text: '\n', style: bibleTextStyle.body.copyWith(height: 1.5))
                    else if (type.isInline)
                      TextSpan(text: '\n', style: bibleTextStyle.body.copyWith(height: 0.5)),
                    if (chapter.paragraphs.getVerseIntroducedBySectionAt(paragraphIndex) case final verse?
                        when chapter.paragraphs.getFirstSectionIndexIntroducingVerse(verse.verseNum) == paragraphIndex)
                      SizedWidgetSpan(
                        child: SizedBox.shrink(key: keyBySectionReference?[getVerseReference(verse)]),
                        alignment: .top,
                        size: Size.zero,
                      ),
                    TextSpan(
                      text: text,
                      style: type.isLarge
                          ? type == .ms
                                ? bibleTextStyle.majorSection
                                : bibleTextStyle.section
                          : switch (type) {
                              .d => bibleTextStyle.smallHeading,
                              .qa => bibleTextStyle.smallSection,
                              .sp => bibleTextStyle.speakerHeading,
                              _ => throw UnimplementedError(),
                            },
                    ),
                    if (type.isLarge)
                      TextSpan(text: '\n ', style: bibleTextStyle.body.copyWith(height: 0.8))
                    else if (!type.isInline)
                      TextSpan(text: '\n ', style: bibleTextStyle.body.copyWith(height: 0.1)),
                  ]
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
                              bibleTextStyle.verseNumber.getWidth(verse.verseNum.toString()) + 6,
                              bibleTextStyle.body.fontSize! + 6,
                            ),
                            alignment: .middle,
                            child: Padding(
                              padding: .only(right: isLtr ? 4 : 0, left: isLtr ? 0 : 4),
                              child: Text(
                                verse.verseNum.toString(),
                                style: bibleTextStyle.verseNumber.copyWith(
                                  decoration: highlightedReferences.contains(reference) ? .underline : null,
                                ),
                              ),
                            ),
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
                              context.textStyle.labelXs.getWidth('${translation.title()} ${originalVerse.format()}') +
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
                                child: '${translation.title()} ${originalVerse.format()}'.toText(),
                                onPressed: () => context.showStyledDialog(
                                  (context) => StyledDialog.confirm(
                                    title: 'Verse Numbering'.toText(),
                                    body:
                                        'The ${translation.title()} numbers its chapters and verses differently from most English translations use.\n\n'
                                                'The text shown here at ${reference.format()} comes from ${originalVerse.format()} in the ${translation.title()}, remapped so it lines up with the other translations.'
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
                  title: 'Notes'.toText(),
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
                                        title: 'Delete Annotation'.toText(),
                                        body: 'Are you sure you want to delete this annotation?'.toText(),
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
                                      title: 'Annotation'.toText(),
                                      children: [
                                        StyledListItem(
                                          title: 'Edit'.toText(),
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
                                          title: 'Delete'.toText(),
                                          leading: Icon(Symbols.delete, color: context.colors.contentCritical),
                                          onPressed: () async {
                                            final confirmed = await context.showStyledDialog(
                                              (context) => StyledDialog.confirmDelete(
                                                title: 'Delete Annotation'.toText(),
                                                body: 'Are you sure you want to delete this annotation?'.toText(),
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
                  title: 'Footnotes'.toText(),
                  children: footnotes
                      .map(
                        (footnote) => StyledListItem(
                          title: MarkdownBuilder(
                            footnote.text,
                            onLinkPressed: (text, link) => PreviewPassageSheet.show(
                              context,
                              verseSelection: VerseSelection.fromOsisId(link),
                              onNavigateToVerseSelection: onNavigateToVerseSelection,
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

class BibleTextStyle {
  static const baseMultiplier = 0.95;

  final BuildContext context;
  final ThemeLayoutConfiguration config;
  final FontSizeSpacing fontSizeSpacing;

  const BibleTextStyle(this.context, {required this.config, required this.fontSizeSpacing});

  TextStyle get base => TextStyle(
    fontFamily: config.font.fontFamily,
    color: context.colors.contentPrimary,
    decorationColor: context.colors.contentPrimary,
  );

  double get multiplier => baseMultiplier * fontSizeSpacing.multiplier;

  TextStyle get majorSection => base.extraBold.copyWith(fontSize: 28 * multiplier, height: 40 / 28);
  TextStyle get section => base.bold.copyWith(fontSize: 24 * multiplier, height: 40 / 24);
  TextStyle get smallHeading =>
      base.regular.copyWith(fontSize: 20 * multiplier, letterSpacing: 0, height: 40 / 20, fontStyle: .italic);
  TextStyle get smallSection => base.bold.copyWith(fontSize: 20 * multiplier, letterSpacing: 0, height: 40 / 20);
  TextStyle get speakerHeading =>
      base.bold.copyWith(fontSize: 20 * multiplier, letterSpacing: 0, height: 40 / 20, fontStyle: .italic);
  TextStyle get verseNumber =>
      base.bold.copyWith(fontSize: 14 * multiplier, letterSpacing: 0, decorationStyle: .dotted);
  TextStyle get body =>
      base.regular.copyWith(fontSize: 20 * multiplier, letterSpacing: 0, height: 40 / 20, decorationStyle: .dotted);
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

class VerseElement {
  final BibleTextSelectionWordAnchor anchor;
  final bool isBoundInSelection;
  final bool isLeading;

  const VerseElement({required this.anchor, required this.isBoundInSelection, this.isLeading = false});

  VerseElement copyWith({BibleTextSelectionWordAnchor? anchor, bool? isBoundInSelection, bool? isLeading}) =>
      VerseElement(
        anchor: anchor ?? this.anchor,
        isBoundInSelection: isBoundInSelection ?? this.isBoundInSelection,
        isLeading: isLeading ?? this.isLeading,
      );
}

extension on Rect {
  Rect asVerseSelection({required double multiplier}) =>
      .fromCenter(center: center + Offset(0, 2), width: width + 4 * multiplier, height: min(32 * multiplier, height));

  Rect asTextSelection({required double multiplier}) =>
      .fromCenter(center: center + Offset(0, 2), width: width + 2 * multiplier, height: min(28 * multiplier, height));
}

extension on List<InlineSpan> {
  int? getFirstSpanPositionForReference(Reference reference) {
    var cursor = 0;
    return map((span) {
      final position =
          span is IsAnnotatedSpan<VerseElement> &&
              span.annotation.anchor.toReference() == reference &&
              span.textLength > 0
          ? cursor
          : null;
      cursor += span.textLength;
      return position;
    }).nonNulls.firstOrNull;
  }

  BibleTextSelection getContainedTextSelection({required BibleTranslation translation}) {
    final lastAnchor = whereType<IsAnnotatedSpan<VerseElement>>().last;
    return BibleTextSelection(
      start: whereType<IsAnnotatedSpan<VerseElement>>().first.annotation.anchor,
      end: lastAnchor.annotation.anchor.withCharactersAdded(lastAnchor.textLength),
      translation: translation,
    );
  }

  int get maxTextPosition => map((span) => span.textLength).sum;

  int? getTextPosition({required BibleTextSelectionWordAnchor anchor, bool onlyBound = false}) {
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

  (int, int)? getReferenceCharacterOffsets({
    required Chapter chapter,
    required Reference reference,
    required BibleTranslation translation,
    required bool isParagraphs,
  }) {
    if (!getContainedTextSelection(translation: translation).isInReference(reference)) {
      return null;
    }

    return (
      getTextPosition(
            anchor: BibleTextSelectionWordAnchor.fromReference(reference: reference, characterOffset: 0),
            onlyBound: false,
          ) ??
          (isParagraphs ? 1 : 0),
      getTextPosition(
            anchor: BibleTextSelectionWordAnchor.fromReference(
              reference: reference,
              characterOffset: chapter.getVerseByReference(reference)?.text.length ?? 0,
            ),
            onlyBound: false,
          ) ??
          maxTextPosition,
    );
  }

  (int, int)? getTextSelectionCharacterOffsets({
    required BibleTextSelection textSelection,
    required BibleTranslation translation,
    required bool isParagraphs,
  }) {
    if (!getContainedTextSelection(translation: translation).intersects(textSelection)) {
      return null;
    }

    return (
      getTextPosition(anchor: textSelection.start, onlyBound: true) ?? (isParagraphs ? 1 : 0),
      (getTextPosition(anchor: textSelection.end, onlyBound: true) ?? (maxTextPosition - 1)) + 1,
    );
  }
}
