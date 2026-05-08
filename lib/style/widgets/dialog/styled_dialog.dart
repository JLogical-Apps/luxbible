import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intersperse/intersperse.dart';
import 'package:material_symbols_icons/symbols.dart';

class StyledDialog<T> extends HookWidget {
  final Widget title;
  final Widget body;

  final List<Widget> Function(BuildContext) buttonsBuilder;

  const StyledDialog({super.key, required this.title, required this.body, required this.buttonsBuilder});

  StyledDialog.confirm({super.key, required this.title, required this.body})
    : buttonsBuilder = ((context) => [StyledRectButton.primary(label: 'Ok'.toText(), onPressed: () => context.pop())]);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.colors.surfacePrimary, borderRadius: .circular(16)),
      padding: .all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: DefaultTextStyle(style: context.textStyle.headingSm, child: title),
                ),
                StyledCircleButton.md(child: Symbols.close.toIcon(), onPressed: () => Navigator.of(context).pop()),
              ],
            ),
            gapH8,
            ...[DefaultTextStyle(style: context.textStyle.paragraphMd, child: body), gapH16],
            ...buttonsBuilder(context).intersperse(gapH8),
          ],
        ),
      ),
    );
  }
}
