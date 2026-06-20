import 'dart:ui';

import 'package:bible/ui/widgets/annotated_span.dart';
import 'package:bible/ui/widgets/sized_widget_span.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/num_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class BreakSpan extends TextSpan {
  const BreakSpan({super.style}) : super(text: '\n');
}

extension InlineSpanExtensions on InlineSpan {
  int get textLength => switch (this) {
    WidgetSpan() => 1,
    TextSpan(:final text) => text?.length ?? 0,
    _ => throw UnimplementedError(),
  };

  InlineSpan slice<T>(int start, int end, T Function(T annotation, int charactersAdded) annotationModifier) =>
      switch (this) {
        AnnotatedTextSpan<T> span => AnnotatedTextSpan<T>(
          annotation: annotationModifier(span.annotation, start),
          text: span.text!.substring(start, end),
          style: span.style,
        ),
        TextSpan span => TextSpan(text: span.text!.substring(start, end), style: span.style),
        _ => throw UnimplementedError(),
      };
}

extension TextSpanExtensions on TextSpan {
  List<InlineSpan> withInjectedSpans(Map<int, InlineSpan> spanByOffset) {
    final spans = <InlineSpan>[this];
    for (final MapEntry(:key, :value) in spanByOffset.entries.sortedBy((entry) => -entry.key)) {
      final textSpan = spans.removeAt(0) as TextSpan;
      final text = textSpan.text ?? '';
      spans.insertAll(0, [
        TextSpan(text: text.substring(0, key), style: style),
        value,
        TextSpan(text: text.substring(key), style: style),
      ]);
    }

    return spans;
  }
}

extension ListSpanExtensions on List<InlineSpan> {
  int getCharacterOffsetFromPosition({
    required Offset localPosition,
    required double width,
    required TextAlign textAlign,
    TextDirection textDirection = .ltr,
  }) {
    var initialOffset = _getTextPainter(
      width: width,
      textAlign: textAlign,
      textDirection: textDirection,
    ).getPositionForOffset(localPosition).offset;
    // Account for WidgetSpans and line-breaks in selection
    var accountedLength = 0;
    for (final span in this) {
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

  List<InlineSpan> withHangingIndent<T>({
    required double width,
    required TextAlign textAlign,
    required double hangingIndent,
    required T Function(T annotation, int charactersAdded) annotationModifier,
  }) {
    final runoverWidth = width - hangingIndent;
    if (hangingIndent <= 0 || runoverWidth <= 0) return this;

    List<InlineSpan> breakSpans() => [BreakSpan(), SizedWidgetSpan.space(size: Size(hangingIndent, 0))];

    final result = <InlineSpan>[];
    var remaining = this;
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
    return result;
  }

  int? _secondLineStart({required double width, required TextAlign textAlign}) {
    final painter = _getTextPainter(width: width, textAlign: textAlign);
    final lineMetrics = painter.computeLineMetrics();
    if (lineMetrics.length <= 1) return null;

    return painter
        .getPositionForOffset(Offset(0, lineMetrics.first.height + lineMetrics[1].height / 2))
        .offset
        .nullIfZero;
  }

  (List<InlineSpan>, List<InlineSpan>) splitAt<T>(
    int offset,
    T Function(T annotation, int charactersAdded) annotationModifier,
  ) {
    final head = <InlineSpan>[];
    final tail = <InlineSpan>[];
    var raw = 0;
    for (final span in this) {
      final length = span.textLength;
      if (raw + length <= offset) {
        head.add(span);
      } else if (raw >= offset) {
        tail.add(span);
      } else if (span is TextSpan) {
        final at = offset - raw;
        head.add(span.slice<T>(0, at, annotationModifier));
        tail.add(span.slice<T>(at, span.text!.length, annotationModifier));
      }
      raw += length;
    }
    return (head, tail);
  }

  List<InlineSpan> withUnorphanedLeadingSpans({
    required double width,
    required TextAlign textAlign,
    required bool Function(InlineSpan span) isLeadingSpan,
    TextDirection textDirection = .ltr,
  }) {
    if (none(isLeadingSpan)) return this;

    int? firstOrphanedLeadingSpan(List<InlineSpan> spans) {
      final painter = spans._getTextPainter(width: width, textAlign: textAlign, textDirection: textDirection);

      double topAt(int offset) => painter
          .getBoxesForSelection(
            TextSelection(baseOffset: offset, extentOffset: offset + 1),
            boxHeightStyle: .max,
          )
          .first
          .top;

      int offsetOf(int index) => spans.take(index).map((span) => span.textLength).sum;

      bool isOrphaned(int groupStart) {
        final start = offsetOf(groupStart);
        final groupSize = spans.skip(groupStart).takeWhile(isLeadingSpan).length;

        final groupTop = topAt(start);
        final wordTop = topAt(start + groupSize);
        final precedingTop = topAt(start - 1);

        final startsLine = precedingTop != groupTop;
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

    var spans = this;
    while (true) {
      final breakAt = firstOrphanedLeadingSpan(spans);
      if (breakAt == null) return spans;
      spans = spans.withInsert(breakAt, BreakSpan());
    }
  }

  List<TextBox> getBoxesForSelection({
    required int baseOffset,
    required int extentOffset,
    required double width,
    required TextAlign textAlign,
    TextDirection textDirection = .ltr,
  }) => _getTextPainter(width: width, textAlign: textAlign, textDirection: textDirection).getBoxesForSelection(
    TextSelection(baseOffset: baseOffset, extentOffset: extentOffset),
    boxHeightStyle: BoxHeightStyle.max,
  );

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
