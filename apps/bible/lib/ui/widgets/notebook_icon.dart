import 'package:bible/models/notebook.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class NotebookIcon extends ConsumerWidget {
  final Notebook? notebook;
  final bool isInverted;

  const NotebookIcon({super.key, required this.notebook, this.isInverted = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = isInverted ? context.colors.inverted : context.colors;
    final notebook = this.notebook;
    final isVisible = notebook?.isVisible ?? ref.watch(userProvider).isDefaultNotebookVisible;
    return Icon(Symbols.book_2, color: notebook?.color.toHue(colors).medium, fill: isVisible ? 1 : 0);
  }
}
