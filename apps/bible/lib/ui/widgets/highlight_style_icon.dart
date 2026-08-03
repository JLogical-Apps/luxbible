import 'package:bible/models/highlight_style.dart';
import 'package:style/style.dart';
import 'package:flutter/material.dart';

class HighlightStyleIcon extends StatelessWidget {
  final HighlightStyle style;
  final ComponentSize size;

  const HighlightStyleIcon({super.key, required this.style, this.size = .md});

  @override
  Widget build(BuildContext context) => style.type.buildPreview(context, color: style.color, size: size);
}
