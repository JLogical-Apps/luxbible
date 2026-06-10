import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/styled_shadow.dart';
import 'package:bible/style/widgets/styled_list_item_context.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StyledReorderableList extends HookWidget {
  static Size? draggedChildSize;

  final List<Widget> children;
  final Function(int oldIndex, int newIndex) onReorder;

  final bool shrinkWrap;

  const StyledReorderableList({super.key, required this.children, required this.onReorder, this.shrinkWrap = false});

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      shrinkWrap: shrinkWrap,
      children: children
          .mapIndexed(
            (i, child) => StyledListItemContext(key: child.key, showDivider: i + 1 < children.length, child: child),
          )
          .toList(),
      onReorderItem: onReorder,
      proxyDecorator: (widget, _, _) => Container(
        decoration: BoxDecoration(color: context.colors.surfacePrimary, boxShadow: [StyledShadow.down(context)]),
        child: widget,
      ),
    );
  }
}
