import 'package:bible/ui/widgets/sized_widget_span.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:utils_core/utils_core.dart';

mixin IsAnnotatedSpan<T> on InlineSpan {
  T get annotation;
}

class AnnotatedTextSpan<T> extends TextSpan with IsAnnotatedSpan<T> {
  @override
  final T annotation;

  const AnnotatedTextSpan({required super.text, super.style, required this.annotation});

  List<InlineSpan> withInjectedSpans(
    Map<int, InlineSpan> spanByOffset, {
    required T Function(T, int offset) annotationModifier,
  }) {
    final spans = <InlineSpan>[this];
    for (final MapEntry(:key, :value)
        in spanByOffset.where((offset, span) => text!.length > offset).entries.sortedBy((entry) => -entry.key)) {
      final textSpan = spans.removeAt(0) as AnnotatedTextSpan<T>;
      final text = textSpan.text ?? '';
      spans.insertAll(0, [
        AnnotatedTextSpan(annotation: annotation, text: text.substring(0, key), style: style),
        value,
        AnnotatedTextSpan(annotation: annotationModifier(annotation, key), text: text.substring(key), style: style),
      ]);
    }

    return spans;
  }
}

class AnnotatedSizedWidgetSpan<T> extends SizedWidgetSpan with IsAnnotatedSpan<T> {
  @override
  final T annotation;

  AnnotatedSizedWidgetSpan({required super.child, required super.size, super.alignment, required this.annotation});
}
