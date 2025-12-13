import 'package:bible/style/gap.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/text_style_extensions.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/style/widgets/styled_divider.dart';
import 'package:bible/style/widgets/styled_dock.dart';
import 'package:bible/style/widgets/styled_list.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class StyledSheet extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;

  final Widget body;
  final List<Widget> Function(BuildContext)? buttonsBuilder;

  StyledSheet({
    super.key,
    Widget? title,
    String? titleText,
    Widget? subtitle,
    String? subtitleText,
    this.trailing,
    required this.body,
    this.buttonsBuilder,
  }) : title = title ?? titleText?.mapIfNonNull(Text.new) ?? SizedBox.shrink(),
       subtitle = subtitle ?? subtitleText?.mapIfNonNull(Text.new);

  StyledSheet.list({
    super.key,
    Widget? title,
    String? titleText,
    Widget? subtitle,
    String? subtitleText,
    this.trailing,
    required List<Widget> children,
    this.buttonsBuilder,
  }) : title = title ?? titleText?.mapIfNonNull(Text.new) ?? SizedBox.shrink(),
       subtitle = subtitle ?? subtitleText?.mapIfNonNull(Text.new),
       body = StyledList(children: children);

  @override
  Widget build(BuildContext context) {
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
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(999), color: context.colors.borderOpaque),
              ),
            ),
          ),
          gapH8,
          SizedBox(
            height: subtitle == null ? 48 : 52,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                spacing: 8,
                children: [
                  SizedBox(
                    width: 48,
                    child: Center(
                      child: StyledCircleButton.lg(icon: Symbols.close, onPressed: () => Navigator.of(context).pop()),
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
                        if (subtitle case final subtitle?)
                          DefaultTextStyle(
                            style: context.textStyle.paragraphMd.subtle(context),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            child: subtitle,
                          ),
                      ],
                    ),
                  ),
                  if (trailing case final trailing?) SizedBox(width: 48, child: trailing) else gapW48,
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
