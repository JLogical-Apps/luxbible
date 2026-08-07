import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/src/widgets/styled_badge.dart';

class StyledEditBadge extends StatelessWidget {
  final Widget child;
  final bool isEdit;

  const StyledEditBadge({super.key, required this.child, this.isEdit = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isEdit)
          Positioned(
            right: 0,
            bottom: 0,
            child: StyledBadge(child: Symbols.edit.toIcon(), colorBuilder: .surfacePrimaryInverted),
          ),
      ],
    );
  }
}
