import 'package:bible/ui/widgets/sized_widget_span.dart';
import 'package:flutter/material.dart';

extension ListSpanExtensions on List<InlineSpan> {
  int getCharacterOffsetFromPosition({required Offset localPosition, required double width}) {
    final textPainter =
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

    return textPainter.getPositionForOffset(localPosition).offset;
  }
}
