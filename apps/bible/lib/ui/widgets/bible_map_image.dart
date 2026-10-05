import 'package:bible/models/bible_map.dart';
import 'package:flutter/material.dart';

// Maps stay on a light background in dark mode, since inverting the grayscale print art turns its relief shading into
// a negative.
class BibleMapImage extends StatelessWidget {
  final BibleMap map;
  final int? cacheWidth;

  const BibleMapImage({super.key, required this.map, this.cacheWidth});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: Colors.white,
    child: Padding(
      padding: .all(8),
      child: Image.asset(map.imagePath, cacheWidth: cacheWidth),
    ),
  );
}
