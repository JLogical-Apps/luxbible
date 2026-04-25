import 'package:bible/ui/widgets/sized_widget_span.dart';
import 'package:flutter/material.dart';

mixin IsAnnotatedSpan<T> on InlineSpan {
  T get annotation;
}

class AnnotatedTextSpan<T> extends TextSpan with IsAnnotatedSpan<T> {
  @override
  final T annotation;

  const AnnotatedTextSpan({required super.text, super.style, required this.annotation});
}

class AnnotatedWidgetSpan<T> extends WidgetSpan with IsAnnotatedSpan<T> {
  @override
  final T annotation;

  const AnnotatedWidgetSpan({required super.child, required this.annotation});
}

class AnnotatedSizedWidgetSpan<T> extends SizedWidgetSpan with IsAnnotatedSpan<T> {
  @override
  final T annotation;

  AnnotatedSizedWidgetSpan({required super.child, required super.size, super.alignment, required this.annotation});
}
