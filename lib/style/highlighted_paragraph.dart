import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class HighlightedParagraph extends StatelessWidget {
  const HighlightedParagraph({
    super.key,
    required this.text,
    required this.style,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.textScaleFactor = 1.0,
    this.maxLines,
    this.ellipsis,
    this.textHeightBehavior,
    this.lineColor, // null => no highlight
    this.radius = 4,
    this.horizontalInset = 8, // extra highlight padding on left/right
    this.verticalInset = 0, // extra highlight padding above/below line box
  });

  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final double textScaleFactor;
  final int? maxLines;
  final String? ellipsis;
  final ui.TextHeightBehavior? textHeightBehavior;

  /// If null, no highlight is drawn.
  final Color? lineColor;
  final double radius;
  final double horizontalInset;
  final double verticalInset;

  @override
  Widget build(BuildContext context) {
    final dir = textDirection ?? Directionality.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Resolve a finite width to layout the paragraph.
        double width;
        if (constraints.maxWidth.isFinite) {
          width = constraints.maxWidth;
        } else {
          // Fallback: derive a reasonable width from the viewport.
          width = MediaQuery.sizeOf(context).width;
        }

        // Build and layout the paragraph.
        final pb =
            ui.ParagraphBuilder(
                ui.ParagraphStyle(
                  textAlign: _toUiTextAlign(textAlign),
                  textDirection: dir,
                  maxLines: maxLines,
                  ellipsis: ellipsis,
                  textHeightBehavior: textHeightBehavior,
                  fontFamily: style.fontFamily,
                  fontSize: (style.fontSize ?? 14) * textScaleFactor,
                  fontWeight: style.fontWeight,
                  fontStyle: style.fontStyle,
                  height: style.height,
                ),
              )
              ..pushStyle(
                ui.TextStyle(
                  color: style.color,
                  fontSize: (style.fontSize ?? 14) * textScaleFactor,
                  fontWeight: style.fontWeight,
                  fontStyle: style.fontStyle,
                  letterSpacing: style.letterSpacing,
                  wordSpacing: style.wordSpacing,
                  height: style.height,
                  decoration: style.decoration,
                  decorationColor: style.decorationColor,
                  decorationStyle: style.decorationStyle,
                  decorationThickness: style.decorationThickness,
                  fontFamily: style.fontFamily,
                  fontFamilyFallback: style.fontFamilyFallback,
                ),
              )
              ..addText(text);

        final paragraph = pb.build();
        paragraph.layout(ui.ParagraphConstraints(width: width));

        final paraHeight = paragraph.height;

        return SizedBox(
          width: width,
          height: paraHeight,
          child: CustomPaint(
            painter: _LineHighlightPainter(
              paragraph: paragraph,
              textAlign: textAlign,
              textDirection: dir,
              lineColor: lineColor,
              radius: radius,
              horizontalInset: horizontalInset,
              verticalInset: verticalInset,
            ),
          ),
        );
      },
    );
  }

  ui.TextAlign _toUiTextAlign(TextAlign a) {
    switch (a) {
      case TextAlign.left:
        return ui.TextAlign.left;
      case TextAlign.right:
        return ui.TextAlign.right;
      case TextAlign.center:
        return ui.TextAlign.center;
      case TextAlign.justify:
        return ui.TextAlign.justify;
      case TextAlign.start:
        return ui.TextAlign.start;
      case TextAlign.end:
        return ui.TextAlign.end;
    }
  }
}

class _LineHighlightPainter extends CustomPainter {
  _LineHighlightPainter({
    required this.paragraph,
    required this.textAlign,
    required this.textDirection,
    required this.lineColor,
    required this.radius,
    required this.horizontalInset,
    required this.verticalInset,
  });

  final ui.Paragraph paragraph;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Color? lineColor; // null => skip drawing
  final double radius;
  final double horizontalInset;
  final double verticalInset;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw highlights first (if requested), then the text paragraph.
    final lines = paragraph.computeLineMetrics();

    if (lineColor != null) {
      final paint = Paint()..color = lineColor!;
      for (final line in lines) {
        final double left = (line.left) - horizontalInset;
        final double top = (line.baseline - line.ascent) - verticalInset + 4;
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

    // Draw the laid out paragraph at the origin.
    canvas.drawParagraph(paragraph, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant _LineHighlightPainter old) {
    return old.paragraph != paragraph ||
        old.lineColor != lineColor ||
        old.radius != radius ||
        old.horizontalInset != horizontalInset ||
        old.verticalInset != verticalInset ||
        old.textAlign != textAlign ||
        old.textDirection != textDirection;
  }
}
