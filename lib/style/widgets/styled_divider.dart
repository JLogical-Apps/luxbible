import 'package:bible/style/style_context_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class StyledDivider extends StatelessWidget {
  final double height;

  const StyledDivider({super.key, this.height = 1});

  @override
  Widget build(BuildContext context) {
    return Divider(height: height, color: context.colors.borderOpaque, thickness: height);
  }

  List<Widget> wrapPositioned(List<Widget> children) => children
      .mapIndexed(
        (i, child) => i + 1 == children.length
            ? child
            : Stack(
                children: [
                  child,
                  Positioned(child: this, left: 0, right: 0, bottom: 0),
                ],
              ),
      )
      .toList();
}
