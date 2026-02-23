import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_badge.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

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
            child: StyledBadge(icon: Symbols.edit, color: context.colors.inverted.surfacePrimary),
          ),
      ],
    );
  }
}
