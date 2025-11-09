import 'package:bible/style/gap.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_list_item_context.dart';
import 'package:bible/style/widgets/styled_material.dart';
import 'package:bible/utils/extensions/map_if_non_null.dart';
import 'package:flutter/material.dart';

class StyledListItem extends StatelessWidget {
  final Widget? title;
  final Widget? trailing;

  final Function()? onPressed;

  StyledListItem({
    super.key,
    Widget? title,
    String? titleText,
    Widget? trailing,
    IconData? trailingIcon,
    this.onPressed,
  }) : title = title ?? titleText?.mapIfNonNull(Text.new),
       trailing = trailing ?? trailingIcon?.mapIfNonNull(Icon.new);

  @override
  Widget build(BuildContext context) {
    final itemContext = StyledListItemContext.maybeOf(context);

    return StyledMaterial(
      color: Colors.transparent,
      onPressed: onPressed,
      child: Row(
        children: [
          gapW16,
          Expanded(
            child: Stack(
              children: [
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (title case final title?)
                              DefaultTextStyle(
                                style: context.textStyle.labelMd,
                                child: title,
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (trailing case final trailing?)
                      SizedBox(
                        width: 64,
                        child: IconTheme.merge(
                          data: IconThemeData(
                            color: context.colors.contentDisabled,
                            size: 24,
                          ),
                          child: trailing,
                        ),
                      ),
                  ],
                ),
                if (itemContext?.hideDivider != true)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Divider(height: 1, color: context.colors.borderOpaque),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
