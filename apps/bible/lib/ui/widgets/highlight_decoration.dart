import 'package:bible/models/highlight_style.dart';
import 'package:bible/ui/widgets/highlight_underline.dart';
import 'package:flutter/material.dart';

class HighlightDecoration extends StatelessWidget {
  final HighlightStyleType type;
  final Color color;
  final double thickness;
  final bool isDimmed;

  const HighlightDecoration({
    super.key,
    required this.type,
    required this.color,
    required this.thickness,
    this.isDimmed = false,
  });

  @override
  Widget build(BuildContext context) {
    final lineColor = color.withValues(alpha: isDimmed ? 0.35 : 0.9);
    return switch (type) {
      .highlight => AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        decoration: BoxDecoration(
          borderRadius: .circular(4),
          color: color.withValues(alpha: isDimmed ? 0.2 : 0.5),
        ),
      ),
      .outline => Stack(
        clipBehavior: .none,
        children: [
          // Text rects hug the glyphs, which is fine for a fill but cramped for a border.
          Positioned(
            left: -thickness * 0.75,
            right: -thickness * 0.75,
            top: -thickness / 2,
            bottom: -thickness / 2,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              decoration: BoxDecoration(
                borderRadius: .circular(6),
                border: Border.all(color: lineColor, width: thickness / 2),
              ),
            ),
          ),
        ],
      ),
      .straightUnderline => HighlightUnderline(color: lineColor, type: .straight, thickness: thickness),
      .dashedUnderline => HighlightUnderline(color: lineColor, type: .dashed, thickness: thickness),
      .doubleUnderline => HighlightUnderline(color: lineColor, type: .double, thickness: thickness),
      .wavyUnderline => HighlightUnderline(color: lineColor, type: .wavy, thickness: thickness),
      .transparent => SizedBox.shrink(),
    };
  }
}
