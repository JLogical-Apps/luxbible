import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:style/src/widgets/styled_sticky_header.dart';

// Unlike StyledStickyHeader, these stack when nested in each other's sliver, so a section header pins below its
// chapter header.
class StyledSliverStickyHeader extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final EdgeInsets headerPadding;

  final Widget sliver;

  const StyledSliverStickyHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.headerPadding = const .all(16),
    required this.sliver,
  });

  @override
  Widget build(BuildContext context) => SliverStickyHeader.builder(
    builder: (context, state) => StyledStickyHeaderBar(
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      padding: headerPadding,
      isPinned: state.isPinned,
    ),
    sliver: sliver,
  );
}
