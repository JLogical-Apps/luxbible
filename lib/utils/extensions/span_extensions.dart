import 'dart:ui';

import 'package:bible/ui/widgets/sized_widget_span.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

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
  }) {
    var initialOffset = _getTextPainter(width: width, textAlign: textAlign).getPositionForOffset(localPosition).offset;
    // Account for WidgetSpans in selection
    var accountedLength = 0;
    for (final span in this) {
      if (span is WidgetSpan) {
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

  int get characterLength => map(
    (span) => switch (span) {
      WidgetSpan() => 1,
      TextSpan(:final text) => text?.length ?? 0,
      _ => throw UnimplementedError(),
    },
  ).sum;

  int getActualOffset(int textOffset) {
    var numWidgetSpans = 0;
    var counter = 0;
    for (final span in this) {
      switch (span) {
        case TextSpan(:final text):
          counter += text?.length ?? 0;
        case WidgetSpan():
          numWidgetSpans++;
      }
      if (counter >= textOffset) {
        return textOffset + numWidgetSpans;
      }
    }
    return textOffset + numWidgetSpans;
  }

  List<TextBox> getBoxesForSelection({
    required int baseOffset,
    required int extentOffset,
    required double width,
    required TextAlign textAlign,
  }) => _getTextPainter(width: width, textAlign: textAlign).getBoxesForSelection(
    TextSelection(baseOffset: baseOffset, extentOffset: extentOffset),
    boxHeightStyle: BoxHeightStyle.max,
  );

  TextPainter _getTextPainter({required double width, required TextAlign textAlign}) =>
      TextPainter(
          text: TextSpan(children: this),
          textDirection: .ltr,
          textAlign: textAlign,
        )
        ..setPlaceholderDimensions(
          whereType<SizedWidgetSpan>()
              .map((span) => PlaceholderDimensions(size: span.size, alignment: .middle))
              .toList(),
        )
        ..layout(maxWidth: width);
}
