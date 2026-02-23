import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_card.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:flutter/material.dart';

class StyledBanner extends StatelessWidget {
  final Widget? message;

  StyledBanner({super.key, Widget? message, String? messageText})
    : message = message ?? messageText?.mapIfNonNull(Text.new) ?? SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return StyledCard.child(
      color: context.colors.surfaceDisabled,
      child: StyledListItem(title: message),
    );
  }
}
