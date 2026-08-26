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

  final Function()? onHeaderPressed;

  final bool showChildren;
  final List<Widget> children;

  const StyledStickyHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onHeaderPressed,
    this.showChildren = true,
    required this.children,
  });

  StyledStickyHeader.child({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onHeaderPressed,
    required Widget child,
  }) : showChildren = true,
       children = [Padding(padding: .symmetric(horizontal: 16), child: child)];

  @override
  Widget build(BuildContext context) {
    return StickyHeaderBuilder(
      builder: (context, state) {
        final isAtTop = state < 0;
        return Column(
          children: [
            StyledMaterial(
              padding: .all(16),
              colorBuilder: .surfacePrimary,
              onPressed: onHeaderPressed,
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
              opacity: isAtTop ? 1 : 0,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              child: StyledDivider(height: 2),
            ),
          ],
        );
      },
      content: StyledSizeAndFade.showHide(
        show: showChildren,
        child: StyledList(children: children),
      ),
    );
  }
}
