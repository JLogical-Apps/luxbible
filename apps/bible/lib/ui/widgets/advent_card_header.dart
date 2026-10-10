import 'package:bible/models/advent_stage.dart';
import 'package:bible/art/advent/advent_scene.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';

// Draws the scene behind a plan card's header and sets its tabs on the scene's ground. Both always use the dark theme
// so they stay readable on the art. The scene eases to each newly completed day once the page is showing.
class AdventCardHeader extends HookWidget {
  final AdventStage stage;
  final Widget header;
  final Widget tabBar;

  const AdventCardHeader({super.key, required this.stage, required this.header, required this.tabBar});

  @override
  Widget build(BuildContext context) {
    final progress = useAnimatedValue(useWhenVisible(stage.progress), duration: Duration(seconds: 3));

    return Theme(
      data: darkTheme,
      child: ColoredBox(
        color: AdventScenePainter.getGroundColor(progress),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            Stack(
              children: [
                Positioned.fill(child: AdventScene(progress: progress)),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: .topCenter,
                        end: .bottomCenter,
                        colors: [Colors.black.withValues(alpha: 0.35), Colors.transparent],
                        stops: [0, 0.7],
                      ),
                    ),
                  ),
                ),
                // Leaves room below the title row for the hills, where the scene changes most.
                Padding(padding: .only(bottom: 56), child: header),
              ],
            ),
            tabBar,
          ],
        ),
      ),
    );
  }
}
