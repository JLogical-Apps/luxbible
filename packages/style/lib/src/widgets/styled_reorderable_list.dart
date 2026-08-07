import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:style/style.dart';

class StyledReorderableList extends HookWidget {
  static Size? draggedChildSize;

  final List<Widget> children;
  final Function(int oldIndex, int newIndex) onReorder;

  final bool shrinkWrap;

  final bool showProxyBackground;

  const StyledReorderableList({
    super.key,
    required this.children,
    required this.onReorder,
    this.shrinkWrap = false,
    this.showProxyBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    return SlidableAutoCloseBehavior(
      child: ReorderableListView(
        shrinkWrap: shrinkWrap,
        physics: shrinkWrap ? NeverScrollableScrollPhysics() : null,
        children: children
            .mapIndexed(
              (i, child) => StyledListItemContext(key: child.key, showDivider: i + 1 < children.length, child: child),
            )
            .toList(),
        onReorderItem: onReorder,
        proxyDecorator: (widget, _, _) => DecoratedBox(
          decoration: BoxDecoration(
            color: showProxyBackground ? context.colors.surfacePrimary : Colors.transparent,
            boxShadow: [StyledShadow.down(context)],
          ),
          child: widget,
        ),
      ),
    );
  }
}
