import 'package:flutter/material.dart';
import 'package:style/style.dart';

class TitledToolbar extends StatelessWidget {
  final Widget leading;
  final String title;

  const TitledToolbar({super.key, required this.leading, required this.title});

  @override
  Widget build(BuildContext context) => StyledMaterial(
    colorBuilder: .surfacePrimary,
    borderRadius: .circular(999),
    isEnabled: true,
    padding: .symmetric(horizontal: 8),
    child: Row(
      spacing: 4,
      children: [
        leading,
        Expanded(
          child: Padding(
            // Matches MainToolbar's height so switching tabs doesn't resize the bar.
            padding: .symmetric(vertical: 16),
            child: Text(title, style: context.textStyle.labelLg, maxLines: 1, overflow: .ellipsis),
          ),
        ),
      ],
    ),
  );
}
