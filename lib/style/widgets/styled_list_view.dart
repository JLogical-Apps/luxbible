import 'package:bible/style/widgets/styled_list_item_context.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class StyledListView extends StatelessWidget {
  final List<Widget> children;
  final bool shrinkWrap;
  final EdgeInsets padding;
  final ScrollPhysics? physics;

  const StyledListView({
    super.key,
    required this.children,
    this.shrinkWrap = false,
    this.padding = .zero,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    final separatedChildren = children
        .mapIndexed((i, child) => StyledListItemContext(hideDivider: i + 1 == children.length, child: child))
        .toList();
    return SlidableAutoCloseBehavior(
      child: CustomScrollView(
        shrinkWrap: shrinkWrap,
        physics: physics,
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
