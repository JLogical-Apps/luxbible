import 'package:bible/style/color_builder.dart';
import 'package:bible/style/widgets/styled_card.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:flutter/material.dart';

class StyledBanner extends StatelessWidget {
  final Widget message;

  final ColorBuilder? colorBuilder;

  const StyledBanner({super.key, required this.message, this.colorBuilder});

  @override
  Widget build(BuildContext context) {
    return StyledCard.child(
      colorBuilder: colorBuilder ?? .surfaceTertiary,
      child: StyledListItem(title: message),
    );
  }
}
