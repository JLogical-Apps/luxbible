import 'package:bible/style/widgets/sheet/styled_sheet.dart';
import 'package:bible/style/widgets/styled_rect_button.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/port_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:port/port.dart';

class StyledPortSheet<T> extends StyledSheet<T> {
  final Port<T> port;

  final List<Widget> Function(BuildContext) childrenBuilder;

  const StyledPortSheet({
    super.key,
    required this.port,
    required super.title,
    super.subtitle,
    super.trailing,
    required this.childrenBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final port = useMemoized(() => this.port);
    return StyledSheet.child(
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16) + .only(top: 16),
        child: PortBuilder(
          port: port,
          builder: (context, port) =>
              Column(spacing: 16, crossAxisAlignment: .start, children: childrenBuilder(context)),
        ),
      ),
      buttonsBuilder: (context) => [
        StyledRectButton.primary(
          label: 'Save'.toText(),
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
