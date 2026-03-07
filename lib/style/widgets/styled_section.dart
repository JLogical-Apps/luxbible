import 'package:bible/style/gap.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_list.dart';
import 'package:flutter/material.dart';

class StyledSection extends StatelessWidget {
  final Widget title;
  final List<Widget> children;

  final EdgeInsets padding;
  final EdgeInsets childPadding;

  const StyledSection({
    super.key,
    required this.title,
    required this.children,
    this.padding = const EdgeInsets.only(top: 36),
    this.childPadding = EdgeInsets.zero,
  });

  StyledSection.child({
    super.key,
    required this.title,
    required Widget child,
    this.padding = const EdgeInsets.only(top: 36),
    this.childPadding = const EdgeInsets.symmetric(horizontal: 16),
  }) : children = [child];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: DefaultTextStyle(style: context.textStyle.headingXs, child: title),
          ),
          gapH12,
          Padding(
            padding: childPadding,
            child: StyledList(children: children),
          ),
        ],
      ),
    );
  }
}
