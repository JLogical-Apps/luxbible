import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/utils/extensions/map_if_non_null.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class StyledPage extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget body;

  StyledPage({
    super.key,
    this.leading,
    Widget? title,
    String? titleText,
    required this.body,
  }) : title = title ?? titleText?.mapIfNonNull(Text.new);

  @override
  Widget build(BuildContext context) {
    final leading =
        this.leading ??
        (ModalRoute.of(context)?.canPop == true
            ? StyledCircleButton(
                icon: Symbols.chevron_left,
                onPressed: () => Navigator.of(context).pop(),
              )
            : null);
    return Scaffold(
      backgroundColor: context.colors.surfacePrimary,
      appBar: leading != null || title != null
          ? AppBar(
              backgroundColor: context.colors.surfacePrimary,
              leading: leading,
              centerTitle: true,
              title: DefaultTextStyle(
                style: context.textStyle.headingXs,
                child: title ?? SizedBox.shrink(),
              ),
            )
          : null,
      body: body,
    );
  }
}
