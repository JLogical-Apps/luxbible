import 'package:bible/style/gap.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/text_style_extensions.dart';
import 'package:bible/style/widgets/styled_divider.dart';
import 'package:bible/style/widgets/styled_list_item_context.dart';
import 'package:bible/style/widgets/styled_material.dart';
import 'package:bible/style/widgets/styled_radio.dart';
import 'package:bible/utils/extensions/map_if_non_null.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class StyledListItem extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;

  final Function()? onPressed;

  StyledListItem({
    super.key,
    Widget? title,
    String? titleText,
    Widget? subtitle,
    String? subtitleText,
    Widget? leading,
    IconData? leadingIcon,
    Widget? trailing,
    IconData? trailingIcon,
    this.onPressed,
  }) : title = title ?? titleText?.mapIfNonNull(Text.new),
       subtitle = subtitle ?? subtitleText?.mapIfNonNull(Text.new),
       leading = leading ?? leadingIcon?.mapIfNonNull(Icon.new),
       trailing = trailing ?? trailingIcon?.mapIfNonNull(Icon.new);

  StyledListItem.navigation({
    super.key,
    Widget? title,
    String? titleText,
    Widget? subtitle,
    String? subtitleText,
    Widget? leading,
    IconData? leadingIcon,
    this.onPressed,
  }) : title = title ?? titleText?.mapIfNonNull(Text.new),
       subtitle = subtitle ?? subtitleText?.mapIfNonNull(Text.new),
       leading = leading ?? leadingIcon?.mapIfNonNull(Icon.new),
       trailing = Icon(Symbols.chevron_right);

  StyledListItem.radio({
    super.key,
    Widget? title,
    String? titleText,
    Widget? subtitle,
    String? subtitleText,
    Widget? leading,
    IconData? leadingIcon,
    required bool selected,
    required Function() onSelected,
  }) : title = title ?? titleText?.mapIfNonNull(Text.new),
       subtitle = subtitle ?? subtitleText?.mapIfNonNull(Text.new),
       leading = leading ?? leadingIcon?.mapIfNonNull(Icon.new),
       onPressed = onSelected,
       trailing = StyledRadio(selected: selected);

  @override
  Widget build(BuildContext context) {
    final itemContext = StyledListItemContext.maybeOf(context);

    return StyledMaterial(
      color: Colors.transparent,
      onPressed: onPressed,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 64),
        child: IntrinsicHeight(
          child: Row(
            children: [
              if (leading case final leading?)
                SizedBox(
                  width: 64,
                  child: IconTheme.merge(
                    data: IconThemeData(color: context.colors.contentPrimary, size: 24),
                    child: leading,
                  ),
                )
              else
                gapW16,
              Expanded(
                child: Stack(
                  children: [
                    Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              spacing: 4,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (title case final title?)
                                  DefaultTextStyle(style: context.textStyle.labelMd, child: title),
                                if (subtitle case final subtitle?)
                                  DefaultTextStyle(
                                    style: context.textStyle.paragraphSm.subtle(context),
                                    child: subtitle,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        if (trailing case final trailing?)
                          ConstrainedBox(
                            constraints: BoxConstraints(minWidth: 56),
                            child: Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: IconTheme.merge(
                                data: IconThemeData(color: context.colors.contentDisabled, size: 24),
                                child: trailing,
                              ),
                            ),
                          )
                        else
                          gapW16,
                      ],
                    ),
                    if (itemContext?.hideDivider == false)
                      Positioned(left: 0, right: 0, bottom: 0, child: StyledDivider()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
