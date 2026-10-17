import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class BibleAbbreviation extends StatelessWidget {
  final BibleTranslation translation;

  const BibleAbbreviation({super.key, required this.translation});

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: 44,
    child: Container(
      decoration: BoxDecoration(color: context.colors.surfaceTertiary, borderRadius: .circular(8)),
      padding: .all(8),
      child: FittedBox(
        fit: .scaleDown,
        child: Text(translation.multilineTitle(), style: context.textStyle.displayXxxs, textAlign: .center),
      ),
    ),
  );
}
