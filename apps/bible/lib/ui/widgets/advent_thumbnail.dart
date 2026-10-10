import 'package:bible/models/advent_stage.dart';
import 'package:bible/art/advent/advent_candles.dart';
import 'package:bible/art/advent/advent_scene.dart';
import 'package:flutter/material.dart';

class AdventThumbnail extends StatelessWidget {
  final AdventStage stage;
  final double dimension;
  final double borderRadius;
  final bool hasBackground;

  const AdventThumbnail({
    super.key,
    required this.stage,
    required this.dimension,
    required this.borderRadius,
    this.hasBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    final candles = Padding(
      padding: .fromLTRB(dimension * 0.22, dimension * 0.34, dimension * 0.22, dimension * 0.14),
      child: AdventCandles(litCandles: stage.litCandles, isComplete: stage.isComplete),
    );

    if (!hasBackground) return SizedBox.square(dimension: dimension, child: candles);

    return Container(
      width: dimension,
      height: dimension,
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(borderRadius: .circular(borderRadius)),
      foregroundDecoration: BoxDecoration(
        borderRadius: .circular(borderRadius),
        border: .all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Stack(
        children: [
          AdventScene(progress: stage.progress),
          Positioned.fill(child: ColoredBox(color: Colors.black.withValues(alpha: 0.2))),
          Positioned.fill(child: candles),
        ],
      ),
    );
  }
}
