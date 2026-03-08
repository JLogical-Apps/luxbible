import 'package:bible/models/color_enum.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_sheet.dart';
import 'package:bible/style/widgets/styled_circle_button.dart';
import 'package:bible/ui/widgets/colored_circle.dart';
import 'package:flutter/material.dart';

class StyledColorSheet extends StyledSheet<ColorEnum> {
  final ColorEnum? initialColor;

  const StyledColorSheet({super.key, required super.title, super.trailing, this.initialColor});

  @override
  Widget build(BuildContext context) {
    return StyledSheet.child(
      title: title,
      trailing: trailing,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: .spaceEvenly,
          children: ColorEnum.values
              .map(
                (color) => StyledCircleButton.lg(
                  child: ColoredCircle(color: color.toHue(context.colors).primary, isSelected: initialColor == color),
                  onPressed: () => Navigator.of(context).pop(color),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
