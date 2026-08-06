import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';

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
}
