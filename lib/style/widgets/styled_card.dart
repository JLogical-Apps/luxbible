import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_list.dart';
import 'package:flutter/material.dart';

class StyledCard extends StatelessWidget {
  final List<Widget> children;

  final Color? color;

  const StyledCard({super.key, required this.children, this.color});
  StyledCard.child({super.key, required Widget child, this.color}) : children = [child];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColoredBox(
        color: color ?? context.colors.surfacePrimary,
        child: StyledList(children: children),
      ),
    );
  }
}
