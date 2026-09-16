import 'package:bible/models/bible_plan.dart';
import 'package:flutter/material.dart';
import 'package:style/style.dart';

class BiblePlanThumbnail extends StatelessWidget {
  final String displayName;
  final BiblePlanColor color;
  final bool isEnabled;

  final ComponentSize size;

  const BiblePlanThumbnail({
    super.key,
    this.size = .md,
    required this.displayName,
    required this.color,
    this.isEnabled = true,
  });

  BiblePlanThumbnail.fromPlan({Key? key, required BiblePlan plan, required String id, bool isEnabled = true})
    : this(key: key, displayName: plan.getDisplayName(id), color: plan.color, isEnabled: isEnabled);

  @override
  Widget build(BuildContext context) {
    final dimension = switch (size) {
      .lg => 48.0,
      .md => 40.0,
      _ => 32.0,
    };
    return Opacity(
      opacity: isEnabled ? 1 : 0.5,
      child: Container(
        width: dimension,
        height: dimension,
        decoration: BoxDecoration(
          color: color.getHue(context.colors).tertiary,
          borderRadius: .circular(switch (size) {
            .lg => 12,
            .md => 8,
            _ => 6,
          }),
        ),
        child: Center(
          child: Text(
            displayName.isEmpty ? '' : displayName[0].toUpperCase(),
            style: (switch (size) {
              .lg => context.textStyle.displayXs,
              .md => context.textStyle.displayXxs,
              _ => context.textStyle.displayXxxs,
            }).copyWith(color: color.getHue(context.colors).primary),
            textScaler: .noScaling,
          ),
        ),
      ),
    );
  }
}

extension BiblePlanColorExtension on BiblePlan {
  Hue getHue(ColorLibrary colors) => color.getHue(colors);
}

extension BiblePlanHue on BiblePlanColor {
  Hue getHue(ColorLibrary colors) => switch (this) {
    .red => colors.red,
    .orange => colors.orange,
    .yellow => colors.yellow,
    .green => colors.green,
    .blue => colors.blue,
    .violet => colors.violet,
  };
}
