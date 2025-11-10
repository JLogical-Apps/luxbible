import 'package:bible/style/gap.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_divider.dart';
import 'package:bible/style/widgets/styled_dock.dart';
import 'package:bible/style/widgets/styled_list.dart';
import 'package:bible/utils/extensions/map_if_non_null.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class StyledSheet extends StatelessWidget {
  final Widget title;
  final Widget body;
  final List<Widget> Function(BuildContext)? buttonsBuilder;

  StyledSheet({
    super.key,
    Widget? title,
    String? titleText,
    required this.body,
    this.buttonsBuilder,
  }) : title = title ?? titleText?.mapIfNonNull(Text.new) ?? SizedBox.shrink();

  StyledSheet.list({
    super.key,
    Widget? title,
    String? titleText,
    required List<Widget> children,
    this.buttonsBuilder,
  }) : title = title ?? titleText?.mapIfNonNull(Text.new) ?? SizedBox.shrink(),
       body = StyledList(children: children);

  @override
  Widget build(BuildContext context) {
    final buttons = buttonsBuilder?.call(context) ?? [];

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfacePrimary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 12,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: context.colors.borderOpaque,
                ),
              ),
            ),
          ),
          gapH8,
          SizedBox(
            height: 48,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                spacing: 8,
                children: [
                  SizedBox(
                    width: 48,
                    child: Center(
                      child: IconButton(
                        icon: Icon(Symbols.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultTextStyle(
                          style: context.textStyle.headingXs,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          child: title,
                        ),
                      ],
                    ),
                  ),
                  gapW48,
                ],
              ),
            ),
          ),
          gapH8,
          StyledDivider(height: 2),
          Flexible(
            child: DefaultTextStyle(
              style: context.textStyle.paragraphMd,
              child: StyledDock(body: body, buttonsBuilder: buttonsBuilder),
            ),
          ),
        ],
      ),
    );
  }
}
