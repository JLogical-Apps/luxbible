import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';

class LaidOutInlineSpans {
  final List<InlineSpan> spans;
  final double width;
  final TextAlign textAlign;
  final TextDirection textDirection;

  LaidOutInlineSpans({required this.spans, required this.width, required this.textAlign, required this.textDirection});

  late final TextPainter textPainter = spans._getTextPainter(
    width: width,
    textAlign: textAlign,
    textDirection: textDirection,
  );

  List<TextBox> getBoxesForSelection({required int baseOffset, required int extentOffset}) =>
      textPainter.getBoxesForSelection(
        TextSelection(baseOffset: baseOffset, extentOffset: extentOffset),
        boxHeightStyle: .max,
      );

  int getCharacterOffsetFromPosition({
    required Offset localPosition,
    required double width,
    required TextAlign textAlign,
    TextDirection textDirection = .ltr,
  }) {
    var initialOffset = textPainter.getPositionForOffset(localPosition).offset;

    // Account for WidgetSpans and line-breaks in selection
    var accountedLength = 0;
    for (final span in spans) {
      if (span is WidgetSpan || span is BreakSpan) {
        initialOffset--;
      } else if (span is TextSpan) {
        accountedLength += span.text?.length ?? 0;
        if (accountedLength > initialOffset) {
          return initialOffset;
        }
      }
    }
    return initialOffset;
  }

  LaidOutInlineSpans withUnorphanedLeadingSpans({required bool Function(InlineSpan span) isLeadingSpan}) {
    if (spans.none(isLeadingSpan)) return this;

    int? firstOrphanedLeadingSpan(List<InlineSpan> spans) {
      final painter = withSpans(spans).textPainter;

      double? topAt(int offset) => painter
          .getBoxesForSelection(
            TextSelection(baseOffset: offset, extentOffset: offset + 1),
            boxHeightStyle: .max,
          )
          .firstOrNull
          ?.top;

      int offsetOf(int index) => spans.take(index).map((span) => span.textLength).sum;

      double? precedingTop(int start) {
        for (var offset = start - 1; offset >= 0; offset--) {
          final top = topAt(offset);
          if (top != null) return top;
        }
        return null;
      }

      bool isOrphaned(int groupStart) {
        final start = offsetOf(groupStart);
        final groupSize = spans.skip(groupStart).takeWhile(isLeadingSpan).length;

        final groupTop = List.generate(groupSize, (offset) => topAt(start + offset)).nonNulls.firstOrNull;
        final wordTop = topAt(start + groupSize);
        if (groupTop == null || wordTop == null) {
          return false;
        }

        final startsLine = precedingTop(start) != groupTop;
        final wordWraps = wordTop != groupTop;
        return !startsLine && wordWraps;
      }

      return spans.indexed
          .firstWhereOrNull(
            (entry) =>
                entry.$1 >= 1 && isLeadingSpan(entry.$2) && !isLeadingSpan(spans[entry.$1 - 1]) && isOrphaned(entry.$1),
          )
          ?.$1;
    }

    var newSpans = spans;
    while (true) {
      final breakAt = firstOrphanedLeadingSpan(newSpans);
      if (breakAt == null) return withSpans(newSpans);
      newSpans = newSpans.withInsert(breakAt, BreakSpan());
    }
  }

  LaidOutInlineSpans withHangingIndent<T>({
    required double hangingIndent,
    required T Function(T annotation, int charactersAdded) annotationModifier,
  }) {
    final runoverWidth = width - hangingIndent;
    if (hangingIndent <= 0 || runoverWidth <= 0) return this;

    List<InlineSpan> breakSpans() => [BreakSpan(), SizedWidgetSpan.space(size: Size(hangingIndent, 0))];

    final result = <InlineSpan>[];
    var remaining = spans;
    while (true) {
      final isFirst = result.isEmpty;
      final breakAt = remaining._secondLineStart(width: isFirst ? width : runoverWidth, textAlign: textAlign);
      if (breakAt == null) {
        if (isFirst) return this;
        result.addAll(remaining);
        break;
      }

      final (head, tail) = remaining.splitAt<T>(breakAt, annotationModifier);
      result
        ..addAll(head)
        ..addAll(breakSpans());
      remaining = tail;
    }
    return withSpans(result);
  }

  LaidOutInlineSpans withSpans(List<InlineSpan> spans) => spans == this.spans
      ? this
      : LaidOutInlineSpans(spans: spans, width: width, textAlign: textAlign, textDirection: textDirection);
}

extension on List<InlineSpan> {
  int? _secondLineStart({required double width, required TextAlign textAlign}) {
    final painter = _getTextPainter(width: width, textAlign: textAlign);
    final lineMetrics = painter.computeLineMetrics();
    if (lineMetrics.length <= 1) return null;

    return painter
        .getPositionForOffset(Offset(0, lineMetrics.first.height + lineMetrics[1].height / 2))
        .offset
        .nullIfZero;
  }

  TextPainter _getTextPainter({
    required double width,
    required TextAlign textAlign,
    TextDirection textDirection = .ltr,
  }) =>
      TextPainter(
          text: TextSpan(children: this),
          textDirection: textDirection,
          textAlign: textAlign,
        )
        ..setPlaceholderDimensions(
          whereType<SizedWidgetSpan>()
              .map((span) => PlaceholderDimensions(size: span.size, alignment: .middle))
              .toList(),
        )
        ..layout(maxWidth: width, minWidth: width);
}
