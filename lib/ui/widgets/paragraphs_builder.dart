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
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/annotated_span.dart';
import 'package:bible/ui/widgets/simple_markdown.dart';
import 'package:bible/ui/widgets/sized_widget_span.dart';
import 'package:bible/ui/widgets/underline.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/color_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/num_extensions.dart';
import 'package:bible/utils/extensions/paragraph_style_extensions.dart';
import 'package:bible/utils/extensions/rect_extensions.dart';
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

  final Function(Reference)? onReferencePressed;
  final List<Reference> underlinedReferences;

  final bool Function(BibleTextSelection textSelection)? onHandleLongPress;
  final BibleTextSelection? textSelection;
  final Function(BibleTextSelection?, bool isNewSelection)? onTextSelectionUpdated;

  final Map<Reference, GlobalKey>? keyByReference;

  const ParagraphsBuilder({
    super.key,
    required this.paragraphs,
    required this.chapterReference,
    required this.user,
    required this.translation,
    this.onReferencePressed,
    this.underlinedReferences = const [],
    this.onHandleLongPress,
    this.textSelection,
    this.onTextSelectionUpdated,
    this.keyByReference,
  });

  BookType get book => chapterReference.book;

  double get sizeMultiplier => user.themeLayout.fontSizeSpacing.multiplier;

  static const hebrewFontFamily = 'Ezra SIL SR';

  TextDirection get textDirection => translation.isRtl && book.testament == .oldTestament ? .rtl : .ltr;
  bool get isLtr => textDirection == .ltr;
  bool get useParagraphs => user.themeLayout.paragraphs && isLtr;

  @override
  Widget build(BuildContext context) {
    final chapter = Chapter(paragraphs: paragraphs);

    final textSelectionStartAnchorState = useState<BibleTextSelectionWordAnchor?>(null);

    final paragraphHitTesters = <ParagraphHitTester>[];
    BibleTextSelectionWordAnchor? getAnchorAtGlobalPosition(Offset globalPosition) =>
        paragraphHitTesters.map((tester) => tester.getAnchorAt(globalPosition)).nonNulls.firstOrNull;

    return GestureDetector(
      onLongPressStart: (details) {
        if (onHandleLongPress == null) return;

        final anchor = getAnchorAtGlobalPosition(details.globalPosition);
        if (anchor == null) return;

        final wordTextSelection = chapter.getWordsSelection(
          BibleTextSelection.character(anchor: anchor, translation: translation),
        );

        if (!onHandleLongPress!(wordTextSelection)) {
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
      child: Column(
        crossAxisAlignment: .stretch,
        children: getParagraphSpansByParagraph(context, chapter: chapter, keyByReference: keyByReference)
            .where((entry) => entry.value.isNotEmpty)
            .mapEntries((paragraph, originalSpans) {
              final versesParagraph = paragraph.as<VersesParagraph>();
              final blockIndent = user.themeLayout.paragraphs && versesParagraph != null
                  ? versesParagraph.type.blockIndent
                  : 0.0;
              final hangingIndent = versesParagraph?.type.hangingIndent ?? 0.0;

              return Padding(
                padding: useParagraphs ? (versesParagraph?.type.padding ?? .zero).copyWith(left: blockIndent) : .zero,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final textKey = GlobalKey(debugLabel: versesParagraph?.verses.first.verseNum.toString());

                    final renderSpans = versesParagraph != null && useParagraphs
                        ? originalSpans
                              .withHangingIndent<VerseElement>(
                                width: constraints.maxWidth,
                                textAlign: versesParagraph.type.textAlign,
                                hangingIndent: versesParagraph.type.hangingIndent,
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
                        : originalSpans;

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
                          ...paragraph.verses
                              .map((verse) => getVerseReference(verse))
                              .mapToMap(
                                (reference) => MapEntry(
                                  reference,
                                  user.annotations.where(
                                    (annotation) => annotation.verseSelection?.hasReference(reference) == true,
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
                                    renderSpans.getReferenceCharacterOffsets(
                                      reference: reference,
                                      translation: translation,
                                      chapter: chapter,
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
                                        rect: box.asVerseSelection(multiplier: sizeMultiplier),
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
                              .nonNulls
                              .flattened,
                          ...user
                              .getTextSelectionAnnotationsInVerseSelection(
                                chapterReference.toVerseSelection(),
                                translation: translation,
                              )
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
                                        rect: box.asTextSelection(multiplier: sizeMultiplier),
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
                                      rect: box.asTextSelection(multiplier: sizeMultiplier),
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
                          textAlign:
                              paragraph.as<VersesParagraph>()?.type.textAlign ??
                              paragraph.as<SectionParagraph>()?.type.textAlign ??
                              .start,
                          textDirection: textDirection,
                        ),
                      ],
                    );
                  },
                ),
              );
            })
            .toList(),
      ),
    );
  }

  Reference getVerseReference(Verse verse) => chapterReference.getReference(verse.verseNum);

  List<MapEntry<Paragraph, List<InlineSpan>>> getParagraphSpansByParagraph(
    BuildContext context, {
    required Chapter chapter,
    required Map<Reference, GlobalKey>? keyByReference,
  }) {
    final bibleTextStyle = BibleTextStyle(context, config: user.themeLayout);

    var maxPreviousVerseNum = 0;
    return chapter.paragraphs.mapIndexed((paragraphIndex, paragraph) {
      final previousParagraph = paragraphIndex == 0
          ? null
          : chapter.paragraphs[paragraphIndex - 1].as<VersesParagraph>();
      return MapEntry(paragraph, [
        if (previousParagraph?.type.isPoetic == true &&
            paragraph is VersesParagraph &&
            !paragraph.type.isPoetic &&
            user.themeLayout.paragraphs)
          TextSpan(text: '\n', style: bibleTextStyle.body.copyWith(height: 1.5)),
        ...switch (paragraph) {
          SectionParagraph(:final text, :final type) =>
            user.themeLayout.sections
                ? type.isLarge
                      ? [
                          if (paragraphIndex != 0)
                            TextSpan(text: '\n', style: bibleTextStyle.body.copyWith(height: 1.5)),
                          TextSpan(
                            text: text,
                            style: type == .ms ? bibleTextStyle.majorSection : bibleTextStyle.section,
                          ),
                          TextSpan(text: '\n ', style: bibleTextStyle.body.copyWith(height: 0.8)),
                        ]
                      : [TextSpan(text: text, style: bibleTextStyle.smallHeading)]
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
                        SizedWidgetSpan(
                          child: SizedBox.shrink(key: keyByReference?[reference]),
                          size: Size.zero,
                        ),
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
                                  decoration: underlinedReferences.contains(reference) ? .underline : null,
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
                              22 + 2 * sizeMultiplier,
                            ),
                            alignment: .middle,
                            child: Padding(
                              padding: .only(right: isLtr ? 4 : 0, left: isLtr ? 0 : 4, bottom: 2 * sizeMultiplier),
                              child: StyledTag(
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
                            isUnderlined: underlinedReferences.contains(reference),
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
                          fontStyle: word.italic ? .italic : null,
                          decoration: underlinedReferences.contains(reference) ? .underline : null,
                        ),
                      ).withInjectedSpans(
                        {
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
                              .map(
                                (offset, annotations) => MapEntry(
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
                                    isUnderlined: underlinedReferences.contains(reference),
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
                                .map(
                                  (relativeOffset, footnotes) => MapEntry(
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
                                      isUnderlined: underlinedReferences.contains(reference),
                                    ),
                                  ),
                                ),
                        },
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
            user.themeLayout.paragraphs
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
    final bibleTextStyle = BibleTextStyle(context, config: user.themeLayout);
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
                            return StyledListItem(
                              title: annotation.note.toText(),
                              subtitle: StyledLoading(
                                child: annotationText == null
                                    ? null
                                    : Text(annotationText, maxLines: 1, overflow: .ellipsis),
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
    final bibleTextStyle = BibleTextStyle(context, config: user.themeLayout);
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
                  title: 'Footnotes'.toText(),
                  children: footnotes
                      .map((footnote) => StyledListItem(title: SimpleMarkdown(text: footnote.text)))
                      .toList(),
                ),
              ),
              child: Icon(Symbols.article, color: context.colors.contentTertiary),
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
  final ThemeLayoutConfiguration config;
  final BuildContext context;

  const BibleTextStyle(this.context, {required this.config});

  TextStyle get base => TextStyle(
    fontFamily: config.font.fontFamily,
    color: context.colors.contentPrimary,
    decorationColor: context.colors.contentPrimary,
  );

  double get multiplier => config.fontSizeSpacing.multiplier;

  TextStyle get majorSection => base.extraBold.copyWith(fontSize: 28 * multiplier, height: 40 / 28);
  TextStyle get section => base.bold.copyWith(fontSize: 24 * multiplier, height: 40 / 24);
  TextStyle get smallHeading =>
      base.regular.copyWith(fontSize: 20 * multiplier, letterSpacing: 0, height: 40 / 20, fontStyle: .italic);
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
  Rect asVerseSelection({required double multiplier}) => Rect.fromLTWH(
    left - 1,
    top + 3 * (multiplier * 2.5 + 1) / 2,
    width + 4 * multiplier,
    min(32 * multiplier, height),
  );

  Rect asTextSelection({required double multiplier}) =>
      Rect.fromLTWH(left, top + 4 * (multiplier * 2.5 + 1) / 2, width + 2 * multiplier, min(28 * multiplier, height));
}

extension on List<InlineSpan> {
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
