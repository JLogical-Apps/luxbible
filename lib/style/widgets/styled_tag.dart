import 'package:bible/style/style_context_extensions.dart';
import 'package:flutter/material.dart';

class StyledTag extends StatelessWidget {
  final String text;

  const StyledTag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.colors.surfaceSecondary, borderRadius: BorderRadius.circular(999)),
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(text, style: context.textStyle.labelXs),
    );
  }
}
