import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:port/port.dart';
import 'package:style/src/widgets/sheet/styled_sheet.dart';
import 'package:style/src/widgets/styled_rect_button.dart';

class StyledPortSheet<T> extends StyledSheet<T> {
  final Port<T> port;
  final EdgeInsets bodyPadding;

  StyledPortSheet({
    super.key,
    required this.port,
    this.bodyPadding = const .only(left: 16, right: 16, top: 16),
    required super.title,
    super.subtitle,
    super.trailing,
    required super.childrenBuilder,
  }) : super.builder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final port = useMemoized(() => this.port);
    return StyledSheet.child(
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      child: Padding(
        padding: bodyPadding,
        child: PortBuilder(
          port: port,
          builder: (context, port) =>
              Column(spacing: 16, crossAxisAlignment: .start, children: childrenBuilder(context, ref)),
        ),
      ),
      buttonsBuilder: (context) => [
        StyledRectButton.primary(
          label: Text(MaterialLocalizations.of(context).saveButtonLabel),
          onPressed: () async {
            final result = await port.submitIfNoErrors();
            if (!result.isValid) {
              return;
            }

            if (context.mounted) {
              context.pop(result.data);
            }
          },
        ),
      ],
    );
  }
}
