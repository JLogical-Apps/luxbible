import 'package:bible/style/color_library.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_material.dart';
import 'package:bible/utils/extensions/map_if_non_null.dart';
import 'package:flutter/material.dart';

class StyledRectButton extends StatelessWidget {
  final Widget label;
  final Function()? onPressed;

  final Color Function(ColorLibrary) colorBuilder;

  StyledRectButton.primary({super.key, Widget? label, String? labelText, required this.onPressed})
    : label = label ?? labelText?.mapIfNonNull(Text.new) ?? SizedBox.shrink(),
      colorBuilder = ((colors) => colors.contentPrimary);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: StyledMaterial(
        onPressed: onPressed,
        color: colorBuilder(context.colors),
        borderRadius: BorderRadius.circular(8),
        child: Center(child: label),
      ),
    );
  }
}
