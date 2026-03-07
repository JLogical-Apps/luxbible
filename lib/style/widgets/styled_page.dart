import 'package:bible/style/gap.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class StyledPage extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget body;
  final Color? backgroundColor;

  const StyledPage({super.key, this.leading, this.title, required this.body, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final leading =
        this.leading ??
        (ModalRoute.of(context)?.canPop == true
            ? StyledCircleButton.lg(child: Icon(Symbols.chevron_left), onPressed: () => Navigator.of(context).pop())
            : null);
    return Scaffold(
      backgroundColor: backgroundColor ?? context.colors.backgroundPrimary,
      appBar: leading != null || title != null
          ? AppBar(
              backgroundColor: context.colors.surfacePrimary,
              leading: leading,
              leadingWidth: 48,
              centerTitle: true,
              title: DefaultTextStyle(
                style: context.textStyle.headingXs,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                child: title ?? SizedBox.shrink(),
              ),
              actions: [gapW48],
            )
          : null,
      body: body,
    );
  }
}
