import 'package:style/style.dart';
import 'package:flutter/material.dart';

class StyledBanner extends StatelessWidget {
  final Widget? leading;
  final Widget message;
  final StyledTextAction? action;

  final ColorBuilder? colorBuilder;

  const StyledBanner({super.key, this.leading, required this.message, this.action, this.colorBuilder});

  @override
  Widget build(BuildContext context) {
    final action = this.action;
    return StyledCard.child(
      colorBuilder: colorBuilder ?? .surfaceTertiary,
      child: StyledListItem(
        leading: leading,
        title: message,
        trailing: action == null ? null : StyledPillButton.sm(label: action.label, onPressed: action.onPressed),
      ),
    );
  }
}
