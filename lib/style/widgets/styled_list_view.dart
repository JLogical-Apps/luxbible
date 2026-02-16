import 'package:bible/style/widgets/styled_list_item_context.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class StyledListView extends StatelessWidget {
  final List<Widget> children;
  final bool shrinkWrap;

  const StyledListView({super.key, required this.children, this.shrinkWrap = false});

  @override
  Widget build(BuildContext context) {
    return SlidableAutoCloseBehavior(
      child: ListView(
        shrinkWrap: shrinkWrap,
        children: children
            .mapIndexed((i, child) => StyledListItemContext(hideDivider: i + 1 == children.length, child: child))
            .toList(),
      ),
    );
  }
}
