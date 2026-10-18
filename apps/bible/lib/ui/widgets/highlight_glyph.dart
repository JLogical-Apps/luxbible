import 'package:bible/models/highlight_icon.dart';
import 'package:flutter/material.dart';
import 'package:style/style.dart';

class HighlightGlyph extends StatelessWidget {
  final HighlightIcon? icon;
  final ComponentSize size;
  final bool invertContent;

  const HighlightGlyph({super.key, required this.icon, this.size = .md, this.invertContent = false});

  @override
  Widget build(BuildContext context) {
    final fontSize = switch (size) {
      .lg => 24.0,
      .md => 18.0,
      .sm => 12.0,
    };

    final color = invertContent ? context.colors.contentPrimaryInverse : context.colors.contentPrimary;

    return switch (icon) {
      final icon? => Icon(icon.icon, size: fontSize, color: color),
      null => Text(
        'A',
        textAlign: .center,
        style: TextStyle(fontSize: fontSize, fontWeight: .w600, height: 1, color: color),
      ),
    };
  }
}
