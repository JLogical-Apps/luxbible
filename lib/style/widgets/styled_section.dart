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
    this.padding = const .only(top: 36),
    this.childPadding = .zero,
  });

  StyledSection.child({
    super.key,
    required this.title,
    required Widget child,
    this.padding = const .only(top: 36),
    this.childPadding = const .symmetric(horizontal: 16),
  }) : children = [child];

  List<Widget> buildChildren(BuildContext context) => [
    SizedBox(height: padding.top),
    Padding(
      padding: .symmetric(horizontal: 16),
      child: DefaultTextStyle(style: context.textStyle.headingXs, child: title),
    ),
    gapH12,
    SizedBox(height: childPadding.top),
    ...StyledList.dividedItems(
      children: children
          .map((child) => Padding(padding: childPadding.copyWith(top: 0, bottom: 0), child: child))
          .toList(),
    ),
    SizedBox(height: childPadding.bottom + padding.bottom),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: .start, children: buildChildren(context));
  }
}
