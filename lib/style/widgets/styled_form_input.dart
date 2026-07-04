import 'package:bible/style/animated_grow.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/text_style_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class StyledFormInput extends StatelessWidget {
  final Widget? label;
  final Widget? error;

  final Widget child;

  const StyledFormInput({super.key, this.label, this.error, required this.child});

  @override
  Widget build(BuildContext context) {
    final error = this.error;

    return Column(
      crossAxisAlignment: .start,
      children: [
        if (label case final label?)
          Padding(
            padding: .only(bottom: 8),
            child: DefaultTextStyle(child: label, style: context.textStyle.labelMd),
          ),
        child,
        AnimatedGrow(
          alignment: .bottomLeft,
          clip: .hardEdge,
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
