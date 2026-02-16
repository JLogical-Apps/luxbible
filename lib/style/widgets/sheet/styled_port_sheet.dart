import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_sheet.dart';
import 'package:bible/style/widgets/styled_rect_button.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:bible/utils/extensions/port_extensions.dart';
import 'package:flutter/material.dart';
import 'package:port/port.dart';

class StyledPortSheet<T> extends StatelessWidget {
  final Port<T> port;

  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final List<Widget> Function(BuildContext) childrenBuilder;

  StyledPortSheet({
    super.key,
    required this.port,
    Widget? title,
    String? titleText,
    Widget? subtitle,
    String? subtitleText,
    this.trailing,
    required this.childrenBuilder,
  }) : title = title ?? titleText?.mapIfNonNull(Text.new) ?? SizedBox.shrink(),
       subtitle = subtitle ?? subtitleText?.mapIfNonNull(Text.new);

  static Future<T?> show<T>(
    BuildContext context, {
    required Port<T> port,
    Widget? title,
    String? titleText,
    Widget? subtitle,
    String? subtitleText,
    Widget? trailing,
    required List<Widget> Function(BuildContext) childrenBuilder,
  }) => context.showStyledSheet(
    StyledPortSheet(
      port: port,
      title: title,
      titleText: titleText,
      subtitle: subtitle,
      subtitleText: subtitleText,
      trailing: trailing,
      childrenBuilder: childrenBuilder,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StyledSheet.child(
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16) + EdgeInsets.only(top: 16),
        child: PortBuilder(
          port: port,
          builder: (context, port) {
            return Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: childrenBuilder(context),
            );
          },
        ),
      ),
      buttonsBuilder: (context) => [
        StyledRectButton.primary(
          labelText: 'Save',
          onPressed: () async {
            final result = await port.submitIfNoErrors();
            if (!result.isValid) {
              return;
            }

            if (context.mounted) {
              Navigator.of(context).pop(result.data);
            }
          },
        ),
      ],
    );
  }
}
