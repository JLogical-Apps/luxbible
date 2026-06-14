import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_symbols_icons/symbols.dart';

class StyledDialog<T> extends HookWidget {
  final Widget title;

  final Widget body;
  final EdgeInsets bodyPadding;

  final List<Widget> Function(BuildContext) buttonsBuilder;

  const StyledDialog({
    super.key,
    required this.title,
    required this.body,
    this.bodyPadding = const .symmetric(horizontal: 16),
    required this.buttonsBuilder,
  });

  StyledDialog.confirm({
    super.key,
    required this.title,
    required this.body,
    this.bodyPadding = const .symmetric(horizontal: 16),
  }) : buttonsBuilder = ((context) => [StyledRectButton.primary(label: 'Ok'.toText(), onPressed: () => context.pop())]);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.colors.surfacePrimary, borderRadius: .circular(16)),
      padding: .symmetric(vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Padding(
              padding: .symmetric(horizontal: 16),
              child: Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: DefaultTextStyle(style: context.textStyle.headingSm, child: title),
                  ),
                  StyledCircleButton.md(child: Symbols.close.toIcon(), onPressed: () => Navigator.of(context).pop()),
                ],
              ),
            ),
            gapH8,
            ...[
              Padding(
                padding: bodyPadding,
                child: DefaultTextStyle(style: context.textStyle.paragraphMd, child: body),
              ),
              gapH16,
            ],
            Padding(
              padding: .symmetric(horizontal: 16),
              child: Column(spacing: 8, children: buttonsBuilder(context)),
            ),
          ],
        ),
      ),
    );
  }
}
