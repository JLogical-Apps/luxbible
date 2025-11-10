import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_card.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/utils/extensions/map_if_non_null.dart';
import 'package:flutter/material.dart';

class StyledBanner extends StatelessWidget {
  final Widget? message;

  StyledBanner({super.key, Widget? message, String? messageText})
    : message = message ?? messageText?.mapIfNonNull(Text.new) ?? SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return StyledCard(
      color: context.colors.surfaceDisabled,
      child: StyledListItem(title: message),
    );
  }
}
