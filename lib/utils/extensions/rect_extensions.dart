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
}
