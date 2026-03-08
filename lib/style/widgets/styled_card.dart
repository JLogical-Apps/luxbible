import 'package:bible/style/color_builder.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_list.dart';
import 'package:flutter/material.dart';

class StyledCard extends StatelessWidget {
  final List<Widget> children;

  final ColorBuilder? colorBuilder;

  const StyledCard({super.key, required this.children, this.colorBuilder});
  StyledCard.child({super.key, required Widget child, this.colorBuilder}) : children = [child];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: .circular(16),
      child: ColoredBox(
        color: colorBuilder?.call(context.colors) ?? context.colors.surfacePrimary,
        child: StyledList(children: children),
      ),
    );
  }
}
