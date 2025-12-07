import 'dart:ui';

import 'package:bible/ui/widgets/sized_widget_span.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

extension ListSpanExtensions on List<InlineSpan> {
  int getCharacterOffsetFromPosition({required Offset localPosition, required double width}) {
    var initialOffset = _getTextPainter(width: width).getPositionForOffset(localPosition).offset - 1;
    // Account for WidgetSpans in selection
    var accountedLength = 0;
    for (var span in this) {
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

  List<TextBox> getBoxesForSelection({required int baseOffset, required int extentOffset, required double width}) =>
      _getTextPainter(width: width).getBoxesForSelection(
        TextSelection(baseOffset: baseOffset, extentOffset: extentOffset),
        boxHeightStyle: BoxHeightStyle.max,
      );

  TextPainter _getTextPainter({required double width}) =>
      (TextPainter(
          text: TextSpan(children: this),
          textDirection: TextDirection.ltr,
        ))
        ..setPlaceholderDimensions(
          whereType<SizedWidgetSpan>()
              .map((span) => PlaceholderDimensions(size: span.size, alignment: PlaceholderAlignment.middle))
              .toList(),
        )
        ..layout(maxWidth: width);
}
