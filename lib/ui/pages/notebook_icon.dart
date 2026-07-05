import 'package:bible/models/notebook.dart';
import 'package:bible/style/style.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class NotebookIcon extends StatelessWidget {
  final Notebook? notebook;
  final bool isInverted;

  const NotebookIcon({super.key, required this.notebook, this.isInverted = false});

  @override
  Widget build(BuildContext context) {
    final colors = isInverted ? context.colors.inverted : context.colors;
    final notebook = this.notebook;
    final hue = notebook?.color.toHue(colors);
    return Icon(
      Symbols.book_2,
      color: hue?.medium.withValues(alpha: notebook == null || notebook.isVisible ? 1 : 1),
      fill: notebook == null || notebook.isVisible ? 1 : 0,
    );
  }
}
