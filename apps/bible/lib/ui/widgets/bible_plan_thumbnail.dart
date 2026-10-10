import 'package:bible/models/advent_stage.dart';
import 'package:bible/models/bible_plan.dart';
import 'package:bible/models/bible_plan_season.dart';
import 'package:bible/ui/widgets/advent_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:style/style.dart';

class BiblePlanThumbnail extends StatelessWidget {
  final String displayName;
  final BiblePlanColor color;
  final bool isEnabled;
  final bool hasBackground;

  final BiblePlanSeason? season;
  final int completedDayCount;
  final int dayCount;

  final ComponentSize size;

  const BiblePlanThumbnail({
    super.key,
    this.size = .md,
    required this.displayName,
    required this.color,
    this.isEnabled = true,
    this.hasBackground = true,
    this.season,
    this.completedDayCount = 0,
    this.dayCount = 1,
  });

  BiblePlanThumbnail.fromPlan({
    Key? key,
    required BiblePlan plan,
    required String id,
    bool isEnabled = true,
    bool hasBackground = true,
    int completedDayCount = 0,
  }) : this(
         key: key,
         displayName: plan.getDisplayName(id),
         color: plan.color,
         isEnabled: isEnabled,
         hasBackground: hasBackground,
         season: BiblePlanType.getById(id)?.season,
         completedDayCount: completedDayCount,
         dayCount: plan.dayCount,
       );

  @override
  Widget build(BuildContext context) {
    final (double dimension, double borderRadius) = switch (size) {
      .lg => (48, 12),
      .md => (40, 8),
      _ => (32, 6),
    };

    return Opacity(
      opacity: isEnabled ? 1 : 0.5,
      child: switch (season) {
        .advent => AdventThumbnail(
          stage: AdventStage.fromCompletedDays(completedDayCount, dayCount: dayCount),
          dimension: dimension,
          borderRadius: borderRadius,
          hasBackground: hasBackground,
        ),
        null => Container(
          width: dimension,
          height: dimension,
          decoration: BoxDecoration(
            color: hasBackground ? color.getHue(context.colors).tertiary : null,
            borderRadius: .circular(borderRadius),
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
      },
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
