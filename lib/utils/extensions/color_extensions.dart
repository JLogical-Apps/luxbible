import 'package:flutter/material.dart';

extension IterableColorExtensions on Iterable<Color> {
  Color get mix => reduce((a, b) => Color.alphaBlend(a, b));
  Color? get mixOrNull => isEmpty ? null : reduce((a, b) => Color.alphaBlend(a, b));
}
