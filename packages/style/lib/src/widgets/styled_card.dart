import 'package:flutter/material.dart';
import 'package:style/src/color_builder.dart';
import 'package:style/src/style_context_extensions.dart';
import 'package:style/src/widgets/styled_list.dart';

class StyledCard extends StatelessWidget {
  final List<Widget> children;

  final EdgeInsets padding;
  final ColorBuilder? colorBuilder;

  const StyledCard({super.key, required this.children, this.colorBuilder, this.padding = .zero});
  StyledCard.child({super.key, required Widget child, this.colorBuilder, this.padding = .zero}) : children = [child];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: .circular(16),
      child: ColoredBox(
        color: colorBuilder?.call(context.colors) ?? context.colors.surfacePrimary,
        child: Padding(
          padding: padding,
          child: StyledList(children: children),
        ),
      ),
    );
  }
}
