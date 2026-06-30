import 'package:bible/style/color_builder.dart';
import 'package:bible/style/gap.dart';
import 'package:bible/style/styled_shadow.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class StyledPage extends StatelessWidget {
  final Widget? title;
  final Widget body;
  final ColorBuilder? backgroundColor;

  final Widget? leading;
  final Widget? trailing;
  final bool showShadow;
  final Function(BuildContext)? onBackPressed;

  const StyledPage({
    super.key,
    this.title,
    required this.body,
    this.backgroundColor,
    this.leading,
    this.trailing,
    this.showShadow = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final onBackPressed = this.onBackPressed;
    final leading =
        this.leading ??
        (onBackPressed != null || ModalRoute.of(context)?.canPop == true
            ? StyledCircleButton.lg(
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
      appBar: appBar != null && showShadow
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
