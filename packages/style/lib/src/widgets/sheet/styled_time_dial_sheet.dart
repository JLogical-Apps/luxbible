import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/src/widgets/sheet/styled_sheet.dart';
import 'package:style/src/widgets/styled_rect_button.dart';
import 'package:style/src/widgets/styled_time_dials.dart';

class StyledTimeDialSheet extends StyledSheet<Time> {
  final Time? initialTime;

  StyledTimeDialSheet({super.key, required super.title, required this.initialTime, super.trailing});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeState = useState(initialTime ?? Time.now());

    return StyledSheet(
      title: title,
      trailing: trailing,
      children: [
        Padding(
          padding: .symmetric(horizontal: 16),
          child: StyledTimeDials(value: timeState.value, onChanged: (time) => timeState.value = time),
        ),
      ],
      buttonsBuilder: (context) => [
        StyledRectButton.primary(label: t.common.save.toText(), onPressed: () => context.pop(timeState.value)),
        StyledRectButton.transparent(label: t.common.cancel.toText(), onPressed: () => context.pop()),
      ],
    );
  }
}
