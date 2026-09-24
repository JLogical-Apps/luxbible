import 'package:bible/models/highlight_style.dart';
import 'package:flutter/material.dart';
import 'package:style/style.dart';

class HighlightStyleIcon extends StatelessWidget {
  final HighlightStyle style;
  final ComponentSize size;
  final bool invertContent;

  const HighlightStyleIcon({super.key, required this.style, this.size = .md, this.invertContent = false});

  @override
  Widget build(BuildContext context) =>
      style.type.buildPreview(context, color: style.color, size: size, invertContent: invertContent);
}
