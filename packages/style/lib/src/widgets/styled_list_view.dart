import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:style/src/widgets/styled_list_item_context.dart';

class StyledListView extends StatelessWidget {
  final List<Widget> children;
  final bool shrinkWrap;
  final EdgeInsets padding;
  final ScrollPhysics? physics;
  final ScrollController? controller;

  const StyledListView({
    super.key,
    required this.children,
    this.shrinkWrap = false,
    this.padding = .zero,
    this.physics,
    this.controller,
  });

  StyledListView.child({
    super.key,
    required Widget child,
    this.shrinkWrap = false,
    this.padding = .zero,
    this.physics,
    this.controller,
  }) : children = [child];

  @override
  Widget build(BuildContext context) {
    final separatedChildren = children
        .mapIndexed((i, child) => StyledListItemContext(showDivider: i + 1 < children.length, child: child))
        .toList();
    return SlidableAutoCloseBehavior(
      child: CustomScrollView(
        shrinkWrap: shrinkWrap,
        physics: physics,
        controller: controller,
        slivers: [
          SliverPadding(
            padding: padding,
            sliver: SliverList.builder(
              itemCount: separatedChildren.length,
              itemBuilder: (context, index) => separatedChildren[index],
            ),
          ),
        ],
      ),
    );
  }
}
