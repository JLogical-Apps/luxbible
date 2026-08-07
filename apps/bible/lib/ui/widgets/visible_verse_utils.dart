import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:utils_core/utils_core.dart';

List<Reference> getVisibleReferencesInViewport({
  required Map<Reference, GlobalKey> keyByReference,
  required double viewportTop,
  required double viewportBottom,
}) => keyByReference
    .where((reference, key) {
      final top = key.globalTop?.mapIfNonNull((top) => top + 32);
      return top != null && top >= viewportTop && top <= viewportBottom;
    })
    .keys
    .toList();
