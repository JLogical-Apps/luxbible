import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/src/color_builder.dart';
import 'package:style/src/gap.dart';
import 'package:style/src/style_context_extensions.dart';
import 'package:style/src/styled_shadow.dart';
import 'package:style/src/widgets/styled_circle_button.dart';

class StyledPage extends StatelessWidget {
  final Widget? title;
  final Widget body;
  final ColorBuilder? backgroundColor;

  final Widget? leading;
  final Widget? trailing;
  final bool showTopShadow;
  final Function(BuildContext)? onBackPressed;

  const StyledPage({
    super.key,
    this.title,
    required this.body,
    this.backgroundColor,
    this.leading,
    this.trailing,
    this.showTopShadow = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final onBackPressed = this.onBackPressed;
    final leading =
        this.leading ??
        (onBackPressed != null || ModalRoute.of(context)?.canPop == true
            ? StyledCircleButton.md(
                child: Symbols.chevron_left.toIcon(),
                onPressed: () => onBackPressed == null ? context.pop() : onBackPressed(context),
              )
            : null);
    final appBar = leading != null || title != null
        ? AppBar(
            backgroundColor: context.colors.surfacePrimary,
            leading: leading,
            leadingWidth: 48,
            centerTitle: true,
            title: DefaultTextStyle(
              style: context.textStyle.headingXs,
              maxLines: 1,
              overflow: .ellipsis,
              child: title ?? SizedBox.shrink(),
            ),
            actions: [trailing ?? gapW48],
          )
        : null;
    return Scaffold(
      backgroundColor: backgroundColor?.call(context.colors) ?? context.colors.surfacePrimary,
      resizeToAvoidBottomInset: false,
      appBar: appBar != null && showTopShadow
          ? PreferredSize(
              preferredSize: appBar.preferredSize,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colors.surfacePrimary,
                  boxShadow: [StyledShadow.down(context)],
                ),
                child: appBar,
              ),
            )
          : appBar,
      body: body,
    );
  }
}
