import 'package:flutter/material.dart';
import 'package:style/src/widgets/styled_rich_text_plan.dart';

class StyledRichText extends StatelessWidget {
  final List<StyledRichTextPart> parts;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;

  const StyledRichText({super.key, this.parts = const [], this.textAlign, this.style, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: parts.map((part) => part.toSpan(context, style ?? DefaultTextStyle.of(context).style)).toList(),
      ),
      textAlign: textAlign ?? DefaultTextStyle.of(context).textAlign,
      maxLines: maxLines,
      overflow: maxLines == null ? null : .ellipsis,
    );
  }
}
