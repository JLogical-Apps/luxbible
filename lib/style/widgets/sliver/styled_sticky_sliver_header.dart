import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_divider.dart';
import 'package:bible/utils/extensions/map_if_non_null.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class StyledSliverStickyHeader extends StatelessWidget {
  final Widget title;
  final Widget? trailing;

  final Widget sliver;

  StyledSliverStickyHeader({super.key, Widget? title, String? titleText, this.trailing, required this.sliver})
    : title = title ?? titleText?.mapIfNonNull(Text.new) ?? SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader.builder(
      builder: (context, state) {
        final isAtTop = state.isPinned;
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: context.colors.surfacePrimary,
              child: Row(
                children: [
                  Expanded(
                    child: DefaultTextStyle(style: context.textStyle.labelMd, child: title),
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
      sliver: sliver,
    );
  }
}
