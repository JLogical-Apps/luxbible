import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_card.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:flutter/material.dart';

class StyledBanner extends StatelessWidget {
  final Widget message;
  final Color? color;

  const StyledBanner({super.key, required this.message, this.color});

  @override
  Widget build(BuildContext context) {
    return StyledCard.child(
      color: color ?? context.colors.surfaceTertiary,
      child: StyledListItem(title: message),
    );
  }
}
