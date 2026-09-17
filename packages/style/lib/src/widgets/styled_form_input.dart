import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/src/gap.dart';
import 'package:style/src/style_context_extensions.dart';
import 'package:style/src/text_style_extensions.dart';
import 'package:style/src/widgets/styled_size_and_fade.dart';

class StyledFormInput extends StatelessWidget {
  final Widget? label;
  final Widget? description;
  final Widget? error;

  final EdgeInsets labelPadding;

  final Widget child;

  const StyledFormInput({
    super.key,
    this.label,
    this.description,
    this.error,
    this.labelPadding = .zero,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final error = this.error;

    return Column(
      crossAxisAlignment: .start,
      children: [
        if (label case final label?)
          Padding(
            padding: labelPadding,
            child: DefaultTextStyle(child: label, style: context.textStyle.labelMd),
          ),
        if (description case final description?)
          Padding(
            padding: labelPadding,
            child: DefaultTextStyle(child: description, style: context.textStyle.paragraphSm.subtle()),
          ),
        if (label != null || description != null) gapH8,
        child,
        StyledSizeAndFade(
          child: error == null
              ? SizedBox(key: ValueKey('empty'), width: double.infinity)
              : Padding(
                  padding: .only(top: 8),
                  child: Row(
                    crossAxisAlignment: .center,
                    spacing: 4,
                    children: [
                      Icon(Symbols.error, size: 14, color: context.colors.contentCritical),
                      DefaultTextStyle(child: error, style: context.textStyle.labelSm.regular.critical()),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
