import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:style/src/widgets/styled_list_item_context.dart';

class StyledList extends StatelessWidget {
  final List<Widget> children;

  const StyledList({super.key, required this.children});

  static List<Widget> dividedItems({required List<Widget> children}) => children
      .mapIndexed((i, child) => StyledListItemContext(showDivider: i + 1 < children.length, child: child))
      .toList();

  @override
  Widget build(BuildContext context) {
    return SlidableAutoCloseBehavior(
      child: Column(
        crossAxisAlignment: .stretch,
        children: dividedItems(children: children),
      ),
    );
  }
}
