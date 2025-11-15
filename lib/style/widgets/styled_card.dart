import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_list.dart';
import 'package:flutter/material.dart';

class StyledCard extends StatelessWidget {
  final Widget child;

  final Color? color;

  const StyledCard({super.key, required this.child, this.color});

  StyledCard.list({super.key, required List<Widget> children, this.color}) : child = StyledList(children: children);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColoredBox(color: color ?? context.colors.surfacePrimary, child: child),
    );
  }
}
