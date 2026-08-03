import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:utils_core/utils_core.dart';

class ParagraphTextLayout {
  final Paragraph paragraph;
  final List<InlineSpan> renderSpans;
  final double maxWidth;
  final double hangingIndent;
  final GlobalKey textKey;

  ParagraphTextLayout({
    required this.paragraph,
    required this.renderSpans,
    required this.maxWidth,
    required this.hangingIndent,
    required this.textKey,
  });
}

class ParagraphText extends StatelessWidget {
  final Paragraph paragraph;
  final List<InlineSpan> originalSpans;
  final bool useParagraphLayout;
  final TextDirection textDirection;
  final Iterable<Widget> Function(BuildContext context, ParagraphTextLayout layout)? overlayBuilder;

  const ParagraphText({
    super.key,
    required this.paragraph,
    required this.originalSpans,
    required this.useParagraphLayout,
    this.textDirection = .ltr,
    this.overlayBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final versesParagraph = paragraph.as<VersesParagraph>();
    final blockIndent = versesParagraph?.type.blockIndent ?? 0.0;
    final hangingIndent = versesParagraph?.type.hangingIndent ?? 0.0;

    return Padding(
      padding: useParagraphLayout ? (versesParagraph?.type.padding ?? .zero).copyWith(left: blockIndent) : .zero,
      child: LayoutBuilder(
        builder: (context, constraints) => HookBuilder(
          builder: (context) {
            final textKey = GlobalKey(debugLabel: versesParagraph?.verses.first.verseNum.toString());
            final renderSpans = useMemoized(
              () => versesParagraph != null && useParagraphLayout
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
                          isLeadingSpan: (span) => span is IsAnnotatedSpan<VerseElement> && span.annotation.isLeading,
                        )
                  : originalSpans,
              [originalSpans, constraints.maxWidth, useParagraphLayout, textDirection],
            );

            final layout = ParagraphTextLayout(
              paragraph: paragraph,
              renderSpans: renderSpans,
              maxWidth: constraints.maxWidth,
              hangingIndent: hangingIndent,
              textKey: textKey,
            );

            return Stack(
              clipBehavior: .none,
              fit: .passthrough,
              children: [
                ...?overlayBuilder?.call(context, layout),
                Text.rich(
                  key: textKey,
                  TextSpan(children: renderSpans),
                  style: TextStyle(inherit: false),
                  textAlign: versesParagraph?.type.textAlign ?? .start,
                  textDirection: textDirection,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

Iterable<Widget> buildVerseAnchorOverlays({
  required List<Paragraph> paragraphs,
  required VersesParagraph paragraph,
  required List<InlineSpan> renderSpans,
  required double maxWidth,
  TextDirection textDirection = .ltr,
  required Map<Reference, GlobalKey>? keyByReference,
  required Reference Function(Verse verse) getVerseReference,
}) => paragraph.verses
    .map((verse) => getVerseReference(verse))
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
