import 'package:bible/models/bible_plan.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class BiblePlanThumbnail extends StatelessWidget {
  final BiblePlan plan;

  const BiblePlanThumbnail({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: plan.getHue(context.colors).tertiary, borderRadius: .circular(8)),
      child: Center(
        child: Text(
          plan.name[0].toUpperCase(),
          style: context.textStyle.displayXxs.copyWith(color: plan.getHue(context.colors).primary),
        ),
      ),
    );
  }
}

extension on BiblePlan {
  Hue getHue(ColorLibrary colors) => colors.vibrantHues.loopedElementAt(name.codeUnits.sum);
}
