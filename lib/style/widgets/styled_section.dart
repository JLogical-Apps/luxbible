import 'package:bible/style/gap.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_list.dart';
import 'package:bible/utils/extensions/map_if_non_null.dart';
import 'package:flutter/material.dart';

class StyledSection extends StatelessWidget {
  final Widget title;
  final Widget child;

  final EdgeInsets padding;
  final EdgeInsets childPadding;

  StyledSection({
    super.key,
    String? titleText,
    Widget? title,
    required this.child,
    this.padding = const EdgeInsets.only(top: 36),
    this.childPadding = const EdgeInsets.symmetric(horizontal: 16),
  }) : title = title ?? titleText?.mapIfNonNull(Text.new) ?? SizedBox.shrink();

  StyledSection.list({
    super.key,
    String? titleText,
    Widget? title,
    required List<Widget> children,
    this.padding = const EdgeInsets.only(top: 36),
    this.childPadding = EdgeInsets.zero,
  }) : title = title ?? titleText?.mapIfNonNull(Text.new) ?? SizedBox.shrink(),
       child = StyledList(children: children);

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
          Padding(padding: childPadding, child: child),
        ],
      ),
    );
  }
}
