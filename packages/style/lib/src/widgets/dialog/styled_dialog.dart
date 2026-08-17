import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

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

  static StyledDialog<bool> confirm({
    required Widget title,
    required Widget body,
    EdgeInsets bodyPadding = const .symmetric(horizontal: 16),
  }) => StyledDialog(
    title: title,
    body: body,
    bodyPadding: bodyPadding,
    buttonsBuilder: ((context) => [
      StyledRectButton.primary(label: t.common.ok.toText(), onPressed: () => context.pop()),
    ]),
  );

  static StyledDialog<bool> confirmOrCancel({
    required Widget title,
    required Widget body,
    Widget? confirmLabel,
    Widget? cancelLabel,
    EdgeInsets bodyPadding = const .symmetric(horizontal: 16),
  }) => StyledDialog(
    title: title,
    body: body,
    bodyPadding: bodyPadding,
    buttonsBuilder: ((context) => [
      StyledRectButton.primary(label: confirmLabel ?? t.common.ok.toText(), onPressed: () => context.pop(true)),
      StyledRectButton.transparent(label: cancelLabel ?? t.common.cancel.toText(), onPressed: () => context.pop(false)),
    ]),
  );

  static StyledDialog<bool> confirmDelete({
    required Widget title,
    required Widget body,
    Widget? deleteLabel,
    Widget? cancelLabel,
    EdgeInsets bodyPadding = const .symmetric(horizontal: 16),
  }) => StyledDialog(
    title: title,
    body: body,
    bodyPadding: bodyPadding,
    buttonsBuilder: ((context) => [
      StyledRectButton.critical(label: deleteLabel ?? t.common.delete.toText(), onPressed: () => context.pop(true)),
      StyledRectButton.transparent(label: cancelLabel ?? t.common.cancel.toText(), onPressed: () => context.pop(false)),
    ]),
  );

  @override
  Widget build(BuildContext context) {
    final isDismissible = ModalRoute.of(context)?.barrierDismissible ?? true;
    return Padding(
      padding: .only(
        bottom: MediaQuery.paddingOf(context.rootContext).bottom + MediaQuery.viewInsetsOf(context).bottom + 16,
      ),
      child: ClipRRect(
        borderRadius: .circular(16),
        child: Container(
          decoration: BoxDecoration(color: context.colors.surfacePrimary, borderRadius: .circular(16)),
          child: Column(
            mainAxisSize: .min,
            children: [
              gapH16,
              Padding(
                padding: .symmetric(horizontal: 16),
                child: Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: DefaultTextStyle(style: context.textStyle.headingSm, child: title),
                    ),
                    if (isDismissible)
                      StyledCircleButton.md(
                        child: Symbols.close.toIcon(),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                  ],
                ),
              ),
              gapH8,
              Flexible(
                child: MediaQuery.removeViewPadding(
                  context: context,
                  removeBottom: true,
                  child: StyledDock(
                    children: [
                      Padding(
                        padding: bodyPadding,
                        child: DefaultTextStyle(style: context.textStyle.paragraphMd, child: body),
                      ),
                    ],
                    buttonsBuilder: buttonsBuilder,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
