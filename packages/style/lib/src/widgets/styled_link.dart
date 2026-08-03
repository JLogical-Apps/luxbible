import 'package:style/src/style_context_extensions.dart';
import 'package:style/src/text_style_extensions.dart';
import 'package:flutter/material.dart';

class StyledLink extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const StyledLink(this.text, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(text, style: context.textStyle.labelMd.underlined),
    );
  }
}
