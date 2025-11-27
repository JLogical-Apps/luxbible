import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class HighlightedParagraph extends StatelessWidget {
  final InlineSpan span;
  final Color? lineColor;
  final double verseNumberWidth;

  const HighlightedParagraph(this.span, {super.key, this.lineColor, required this.verseNumberWidth});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle());
        span.build(
          paragraphBuilder,
          dimensions: [PlaceholderDimensions(size: Size(verseNumberWidth, 8), alignment: PlaceholderAlignment.bottom)],
        );

        final paragraph = paragraphBuilder.build();
        paragraph.layout(ui.ParagraphConstraints(width: width));

        final paraHeight = paragraph.height;

        return SizedBox(
          width: width,
          height: paraHeight,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(width, paraHeight),
                painter: _LineHighlightPainter(
                  paragraph: paragraph,
                  lineColor: lineColor,
                  radius: 4,
                  horizontalInset: 4,
                  verticalInset: -3,
                ),
              ),
              Text.rich(span),
            ],
          ),
        );
      },
    );
  }
}

class _LineHighlightPainter extends CustomPainter {
  _LineHighlightPainter({
    required this.paragraph,
    required this.lineColor,
    required this.radius,
    required this.horizontalInset,
    required this.verticalInset,
  });

  final ui.Paragraph paragraph;
  final Color? lineColor;
  final double radius;
  final double horizontalInset;
  final double verticalInset;

  @override
  void paint(Canvas canvas, Size size) {
    if (lineColor == null) {
      return;
    }

    final paint = Paint()..color = lineColor!;
    final lines = paragraph.computeLineMetrics();

    for (final line in lines) {
      // line.left is the x-offset where this line starts
      final double left = line.left - horizontalInset;
      final double top = (line.baseline - line.ascent) - verticalInset;
      final double right = (line.left + line.width) + horizontalInset;
      final double bottom = (line.baseline + line.descent) + verticalInset;

      final rect = RRect.fromLTRBR(
        left.clamp(0.0, double.infinity),
        top.clamp(0.0, double.infinity),
        right,
        bottom,
        Radius.circular(radius),
      );
      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _LineHighlightPainter old) {
    return old.paragraph != paragraph ||
        old.lineColor != lineColor ||
        old.radius != radius ||
        old.horizontalInset != horizontalInset ||
        old.verticalInset != verticalInset;
  }
}
