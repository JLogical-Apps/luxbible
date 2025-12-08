import 'package:bible/style/animated_grow.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/text_style_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class StyledFormInput extends StatelessWidget {
  final String? labelText;
  final String? errorText;

  final Widget child;

  const StyledFormInput({super.key, this.labelText, this.errorText, required this.child});

  @override
  Widget build(BuildContext context) {
    final errorText = this.errorText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText case final labelText?)
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(labelText, style: context.textStyle.labelMd),
          ),
        child,
        AnimatedGrow(
          alignment: Alignment.bottomLeft,
          clip: Clip.hardEdge,
          child: errorText == null
              ? SizedBox(key: ValueKey('empty'), width: double.infinity)
              : Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 4,
                    children: [
                      Icon(Symbols.error, size: 14, color: context.colors.contentError),
                      Text(errorText, style: context.textStyle.labelSm.regular.error(context)),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
