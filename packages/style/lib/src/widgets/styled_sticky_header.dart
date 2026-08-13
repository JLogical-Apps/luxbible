import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:style/src/style_context_extensions.dart';
import 'package:style/src/widgets/styled_divider.dart';
import 'package:style/src/widgets/styled_list.dart';

class StyledStickyHeader extends StatelessWidget {
  final Widget title;

  final Widget? trailing;

  final List<Widget> children;

  const StyledStickyHeader({super.key, required this.title, this.trailing, required this.children});

  StyledStickyHeader.child({super.key, required this.title, this.trailing, required Widget child})
    : children = [Padding(padding: .symmetric(horizontal: 16), child: child)];

  @override
  Widget build(BuildContext context) {
    return StickyHeaderBuilder(
      builder: (context, state) {
        final isAtTop = state < 0;
        return Column(
          children: [
            Container(
              padding: .all(16),
              color: context.colors.surfacePrimary,
              child: Row(
                children: [
                  Expanded(
                    child: DefaultTextStyle(style: context.textStyle.headingXxs, child: title),
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
      content: StyledList(children: children),
    );
  }
}
