import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:style/style.dart';

class IconCluster extends StatelessWidget {
  final List<(IconData, Color)> icons;

  const IconCluster({super.key, required this.icons});

  @override
  Widget build(BuildContext context) {
    final shownIcons = icons.take(3).toList();
    final extraCount = icons.length - shownIcons.length;
    final alignments = switch ((shownIcons.length, extraCount > 0)) {
      (1, _) => [Alignment.center],
      (2, _) => [Alignment(-0.34, -0.26), Alignment(0.34, 0.26)],
      (_, false) => [Alignment(0, -0.45), Alignment(-0.45, 0.38), Alignment(0.45, 0.38)],
      (_, true) => [Alignment(-0.25, -0.43), Alignment(0.5, 0), Alignment(-0.25, 0.43)],
    };

    return SizedBox.square(
      dimension: 32,
      child: DecoratedBox(
        decoration: BoxDecoration(shape: .circle, color: context.colors.contentPrimary.withValues(alpha: 0.1)),
        child: Stack(
          clipBehavior: .none,
          children: [
            ...shownIcons.mapIndexed(
              (index, entry) => Align(
                alignment: alignments[index],
                child: Icon(entry.$1, size: 10, color: entry.$2),
              ),
            ),
            if (extraCount > 0)
              Positioned(
                right: 0,
                bottom: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: context.colors.contentSecondary, borderRadius: .circular(8)),
                  child: Padding(
                    padding: .symmetric(horizontal: 3, vertical: 1),
                    child: Text(
                      '+$extraCount',
                      style: context.textStyle.labelXxs.copyWith(color: context.colors.contentPrimaryInverse),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
