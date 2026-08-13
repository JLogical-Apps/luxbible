import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

List<InlineSpan> buildSectionParagraphSpans({
  required SectionParagraph paragraph,
  required int paragraphIndex,
  required Paragraph? previousParagraph,
  required BibleTextStyle bibleTextStyle,
  Iterable<InlineSpan> leadingSpans = const [],
  double opacity = 1,
}) {
  final SectionParagraph(:text, :type) = paragraph;
  return [
    if (type.isLarge &&
        paragraphIndex != 0 &&
        (previousParagraph is! SectionParagraph || type > previousParagraph.type))
      TextSpan(text: '\n', style: bibleTextStyle.body.copyWith(height: 1.5))
    else if (type.isInline)
      TextSpan(text: '\n', style: bibleTextStyle.body.copyWith(height: 0.5)),
    ...leadingSpans,
    TextSpan(
      text: text,
      style:
          (type.isLarge
                  ? type == .ms
                        ? bibleTextStyle.majorSection
                        : bibleTextStyle.section
                  : switch (type) {
                      .d => bibleTextStyle.smallHeading,
                      .qa => bibleTextStyle.smallSection,
                      .sp => bibleTextStyle.speakerHeading,
                      _ => throw UnimplementedError(),
                    })
              .copyWith(color: bibleTextStyle.base.color?.withValues(alpha: opacity)),
    ),
    if (type.isLarge)
      TextSpan(text: '\n ', style: bibleTextStyle.body.copyWith(height: 0.8))
    else if (!type.isInline)
      TextSpan(text: '\n ', style: bibleTextStyle.body.copyWith(height: 0.1)),
  ];
}

AnnotatedSizedWidgetSpan<VerseElement> buildVerseNumberSpan({
  required Reference reference,
  required int verseNumber,
  required BibleTextStyle bibleTextStyle,
  required bool isUnderlined,
  required TextDirection textDirection,
  double opacity = 1,
}) => AnnotatedSizedWidgetSpan<VerseElement>(
  annotation: VerseElement(
    anchor: BibleTextSelectionWordAnchor.fromReference(reference: reference, characterOffset: 0),
    isBoundInSelection: false,
    isLeading: true,
  ),
  size: Size(bibleTextStyle.verseNumber.getWidth(verseNumber.toString()) + 6, bibleTextStyle.body.fontSize! + 6),
  alignment: .middle,
  child: Padding(
    padding: .only(right: textDirection == .ltr ? 4 : 0, left: textDirection == .ltr ? 0 : 4),
    child: Opacity(
      opacity: opacity,
      child: Text(
        verseNumber.toString(),
        style: bibleTextStyle.verseNumber.copyWith(decoration: isUnderlined ? .underline : null),
      ),
    ),
  ),
);
