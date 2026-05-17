import 'package:bible/style/color_builder.dart';
import 'package:bible/style/gap.dart';
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
  final Function(BuildContext)? onBackPressed;

  const StyledPage({super.key, this.title, required this.body, this.backgroundColor, this.leading, this.onBackPressed});

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
    return Scaffold(
      backgroundColor: backgroundColor?.call(context.colors) ?? context.colors.surfacePrimary,
      appBar: leading != null || title != null
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
              actions: [gapW48],
            )
          : null,
      body: body,
    );
  }
}
