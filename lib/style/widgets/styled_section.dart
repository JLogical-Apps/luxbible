import 'package:bible/style/style.dart';
import 'package:flutter/material.dart';

class StyledSection extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;

  final List<Widget> children;

  final EdgeInsets padding;
  final EdgeInsets childPadding;

  const StyledSection({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.children,
    this.padding = const .only(top: 36),
    this.childPadding = .zero,
  });

  StyledSection.child({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    required Widget child,
    this.padding = const .only(top: 36),
    this.childPadding = const .symmetric(horizontal: 16),
  }) : children = [child];

  List<Widget> buildChildren(BuildContext context) => [
    SizedBox(height: padding.top),
    Padding(
      padding: .symmetric(horizontal: 16),
      child: Row(
        spacing: 8,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                DefaultTextStyle(style: context.textStyle.headingXs, child: title),
                if (subtitle case final subtitle?)
                  DefaultTextStyle(style: context.textStyle.paragraphSm.subtle(context), child: subtitle),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
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
