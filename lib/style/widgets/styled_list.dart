import 'package:bible/style/widgets/styled_list_item_context.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class StyledList extends StatelessWidget {
  final List<Widget> children;

  const StyledList({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SlidableAutoCloseBehavior(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children
            .mapIndexed(
              (i, child) => StyledListItemContext(
                hideDivider: i + 1 == children.length,
                child: child,
              ),
            )
            .toList(),
      ),
    );
  }
}
