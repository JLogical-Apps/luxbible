import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:utils_core/utils_core.dart';

extension RectIterableExtensions on Iterable<Rect> {
  Iterable<Rect> withMergedLines() => groupListsBy((rect) => (rect.top, rect.bottom)).mapToIterable(
    (_, rects) => Rect.fromLTRB(
      rects.map((rect) => rect.left).min,
      rects.first.top,
      rects.map((rect) => rect.right).max,
      rects.first.bottom,
    ),
  );

  Iterable<Rect> withHangingIndent(double indent) {
    if (indent <= 0 || isEmpty) return this;
    final firstTop = map((rect) => rect.top).min;
    return map(
      (rect) => rect.top > firstTop
          ? Rect.fromLTRB(indent.clamp(rect.left, rect.right), rect.top, rect.right, rect.bottom)
          : rect,
    );
  }
}
