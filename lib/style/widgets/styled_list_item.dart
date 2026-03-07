import 'package:bible/style/style.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class StyledListItem extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;

  final Function()? onPressed;

  final bool enabled;
  final ComponentSize size;

  const StyledListItem({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onPressed,
    this.size = ComponentSize.md,
    this.enabled = true,
  });

  StyledListItem.navigation({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.onPressed,
    this.size = ComponentSize.md,
    this.enabled = true,
  }) : trailing = Icon(Symbols.chevron_right);

  StyledListItem.radio({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    required bool selected,
    required Function() onSelected,
    this.size = ComponentSize.md,
    this.enabled = true,
  }) : onPressed = onSelected,
       trailing = StyledRadio(selected: selected);

  StyledListItem.checkbox({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    required bool selected,
    required Function(bool newValue) onSelected,
    this.size = ComponentSize.md,
    this.enabled = true,
  }) : onPressed = (() => onSelected(!selected)),
       trailing = StyledCheckbox(selected: selected);

  @override
  Widget build(BuildContext context) {
    final itemContext = StyledListItemContext.maybeOf(context);

    return StyledMaterial(
      color: Colors.transparent,
      onPressed: onPressed,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: switch (size) {
            ComponentSize.sm => 56,
            ComponentSize.md => 64,
            ComponentSize.lg => 80,
          },
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              if (leading case final leading?)
                SizedBox(
                  width: 64,
                  child: IconTheme.merge(
                    data: IconThemeData(color: context.colors.contentPrimary.disabled(disabled: !enabled), size: 24),
                    child: leading,
                  ),
                )
              else
                gapW16,
              Expanded(
                child: Stack(
                  children: [
                    Row(
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
                                  DefaultTextStyle(
                                    style: context.textStyle.labelMd.disabled(context, disabled: !enabled),
                                    child: title,
                                  ),
                                if (subtitle case final subtitle?)
                                  DefaultTextStyle(
                                    style: context.textStyle.paragraphSm
                                        .subtle(context)
                                        .disabled(context, disabled: !enabled),
                                    child: subtitle,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        if (trailing case final trailing?)
                          ConstrainedBox(
                            constraints: BoxConstraints(minWidth: 64),
                            child: Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: IconTheme.merge(
                                data: IconThemeData(color: context.colors.contentDisabled, size: 24),
                                child: IntrinsicWidth(child: IntrinsicHeight(child: trailing)),
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
