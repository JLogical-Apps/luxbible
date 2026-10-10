import 'package:bible/art/advent/advent_candles.dart';
import 'package:bible/art/advent/advent_scene.dart';
import 'package:bible/models/advent_stage.dart';
import 'package:bible/models/bible_plan.dart';
import 'package:bible/models/bible_plan_season.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class AdventBanner extends StatelessWidget {
  final BiblePlan plan;
  final DateTime date;
  final Function() onPressed;

  const AdventBanner({super.key, required this.plan, required this.date, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final season = BiblePlanSeason.advent;
    final daysUntilStart = season.getDaysUntilStart(date);
    final daysUntilEnd = season.getDaysUntilEnd(date);
    final stage = AdventStage.fromDate(date);

    final countdown = daysUntilStart > 0
        ? t.biblePlans.beginsInDays(count: daysUntilStart)
        : daysUntilEnd > 0
        ? t.biblePlans.daysUntilChristmas(count: daysUntilEnd)
        : t.biblePlans.christmasDay;

    // The text sits on the night scene, so it stays dark-themed even in light mode.
    return Theme(
      data: darkTheme,
      child: Builder(
        builder: (context) => StyledMaterial.overlay(
          onPressed: onPressed,
          borderRadius: .circular(12),
          child: Stack(
            children: [
              Positioned.fill(child: AdventScene(progress: stage.progress)),
              Positioned.fill(child: ColoredBox(color: Colors.black.withValues(alpha: 0.2))),
              Padding(
                padding: .symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    gapW8,
                    SizedBox(
                      width: 48,
                      height: 42,
                      child: AdventCandles(litCandles: stage.litCandles, isComplete: stage.isComplete),
                    ),
                    gapW24,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        spacing: 2,
                        children: [
                          Text(plan.getDisplayName(BiblePlanType.advent.name), style: context.textStyle.displayXxxs),
                          Text(countdown, style: context.textStyle.labelMd.copyWith(color: context.colors.yellow.dark)),
                        ],
                      ),
                    ),
                    gapW16,
                    Symbols.chevron_right.toIcon(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
