import 'package:bible/style/style.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class StyledListItem extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? thirdLine;
  final Widget? leading;
  final Widget? trailing;

  final Function()? onPressed;

  final bool enabled;
  final ComponentSize size;
  final bool? showDividerOverride;

  const StyledListItem({
    super.key,
    this.title,
    this.subtitle,
    this.thirdLine,
    this.leading,
    this.trailing,
    this.onPressed,
    this.size = ComponentSize.md,
    this.enabled = true,
    this.showDividerOverride,
  });

  StyledListItem.navigation({
    super.key,
    this.title,
    this.subtitle,
    this.thirdLine,
    this.leading,
    this.onPressed,
    this.size = ComponentSize.md,
    this.enabled = true,
    this.showDividerOverride,
  }) : trailing = Icon(Symbols.chevron_right);

  StyledListItem.radio({
    super.key,
    this.title,
    this.subtitle,
    this.thirdLine,
    this.leading,
    required bool selected,
    required Function() onSelected,
    this.size = ComponentSize.md,
    this.enabled = true,
    this.showDividerOverride,
  }) : onPressed = onSelected,
       trailing = StyledRadio(isSelected: selected);

  StyledListItem.checkbox({
    super.key,
    this.title,
    this.subtitle,
    this.thirdLine,
    this.leading,
    required bool isSelected,
    required Function(bool newValue) onSelected,
    this.size = ComponentSize.md,
    this.enabled = true,
    this.showDividerOverride,
  }) : onPressed = (() => onSelected(!isSelected)),
       trailing = StyledCheckbox(isSelected: isSelected);

  StyledListItem.switchControl({
    super.key,
    this.title,
    this.subtitle,
    this.thirdLine,
    this.leading,
    required bool selected,
    required Function(bool newValue) onSelected,
    this.size = ComponentSize.md,
    this.enabled = true,
    this.showDividerOverride,
  }) : onPressed = null,
       trailing = StyledSwitch(isSelected: selected, onSelected: onSelected);

  @override
  Widget build(BuildContext context) {
    final itemContext = StyledListItemContext.maybeOf(context);

    return StyledMaterial(
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
                  child: Center(
                    child: IconTheme.merge(
                      data: IconThemeData(color: context.colors.content(disabled: !enabled), size: 24),
                      child: leading,
                    ),
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
                            padding: .symmetric(vertical: 16),
                            child: Column(
                              spacing: 4,
                              crossAxisAlignment: .start,
                              mainAxisAlignment: .center,
                              children: [
                                if (title case final title?)
                                  DefaultTextStyle(
                                    style: context.textStyle.labelMd.disabled(disabled: !enabled),
                                    child: title,
                                  ),
                                if (subtitle case final subtitle?)
                                  DefaultTextStyle(
                                    style: context.textStyle.paragraphSm.subtle().disabled(disabled: !enabled),
                                    child: subtitle,
                                  ),
                                if (thirdLine case final thirdLine?)
                                  DefaultTextStyle(
                                    style: context.textStyle.paragraphSm.subtle().disabled(disabled: !enabled),
                                    child: thirdLine,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        if (trailing case final trailing?)
                          ConstrainedBox(
                            constraints: BoxConstraints(minWidth: 64),
                            child: Padding(
                              padding: .symmetric(horizontal: 8),
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
                    if ((showDividerOverride ?? itemContext?.showDivider) == true)
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
