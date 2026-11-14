import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:style/src/style_context_extensions.dart';
import 'package:style/src/text_style_extensions.dart';
import 'package:style/src/widgets/styled_divider.dart';
import 'package:style/src/widgets/styled_list.dart';
import 'package:style/src/widgets/styled_material.dart';
import 'package:style/src/widgets/styled_size_and_fade.dart';

class StyledStickyHeader extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;

  final Widget? trailing;

  final Key? headerKey;
  final Function()? onHeaderPressed;
  final EdgeInsets headerPadding;

  final bool showChildren;
  final List<Widget> children;

  const StyledStickyHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.headerKey,
    this.onHeaderPressed,
    this.headerPadding = const .all(16),
    this.showChildren = true,
    required this.children,
  });

  StyledStickyHeader.child({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.headerKey,
    this.onHeaderPressed,
    this.headerPadding = const .all(16),
    required Widget child,
    EdgeInsets childPadding = const .symmetric(horizontal: 16),
  }) : showChildren = true,
       children = [Padding(padding: childPadding, child: child)];

  @override
  Widget build(BuildContext context) {
    StyledStickyHeaderBar buildHeaderBar({required bool isPinned}) => StyledStickyHeaderBar(
      key: headerKey,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onPressed: onHeaderPressed,
      padding: headerPadding,
      isPinned: isPinned,
    );

    final content = StyledSizeAndFade.showHide(
      show: showChildren,
      child: StyledList(children: children),
    );

    // StickyHeaderBuilder throws without a Scrollable ancestor, such as when a reorderable list's drag proxy rebuilds
    // this in the Overlay.
    if (Scrollable.maybeOf(context) == null) {
      return Column(children: [buildHeaderBar(isPinned: false), content]);
    }

    return StickyHeaderBuilder(
      builder: (context, state) => buildHeaderBar(isPinned: state < 0),
      content: content,
    );
  }
}

class StyledStickyHeaderBar extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final Function()? onPressed;
  final EdgeInsets padding;
  final bool isPinned;

  const StyledStickyHeaderBar({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onPressed,
    this.padding = const .all(16),
    required this.isPinned,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      StyledMaterial(
        padding: padding,
        colorBuilder: .surfacePrimary,
        onPressed: onPressed,
        isEnabled: true,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                spacing: 4,
                children: [
                  DefaultTextStyle(style: context.textStyle.headingXxs, child: title),
                  if (subtitle case final subtitle?)
                    DefaultTextStyle(style: context.textStyle.labelSm.subtle(), child: subtitle),
                ],
              ),
            ),
            ?trailing,
          ],
        ),
      ),
      AnimatedOpacity(
        opacity: isPinned ? 1 : 0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        child: StyledDivider(height: 2),
      ),
    ],
  );
}
