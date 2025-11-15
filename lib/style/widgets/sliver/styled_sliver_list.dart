import 'package:bible/style/widgets/styled_list_item_context.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class StyledSliverList extends StatelessWidget {
  final List<Widget> children;

  const StyledSliverList({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SlidableAutoCloseBehavior(
      child: SliverList(
        delegate: SliverChildListDelegate(
          children
              .mapIndexed((i, child) => StyledListItemContext(hideDivider: i + 1 == children.length, child: child))
              .toList(),
        ),
      ),
    );
  }
}
