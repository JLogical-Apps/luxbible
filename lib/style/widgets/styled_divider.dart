import 'package:bible/style/style_context_extensions.dart';
import 'package:flutter/material.dart';

class StyledDivider extends StatelessWidget {
  final double height;

  const StyledDivider({super.key, this.height = 1});

  @override
  Widget build(BuildContext context) {
    return Divider(height: height, color: context.colors.borderOpaque, thickness: height);
  }
}
