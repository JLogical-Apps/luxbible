import 'package:flutter/material.dart';

extension PageControllerExtensions on PageController {
  double? get pageOrNull => hasClients ? page : null;
}

extension ScrollControllerExtensions on ScrollController {
  ScrollPosition? get positionOrNull => hasClients ? position : null;
  Iterable<ScrollPosition>? get positionsOrNull => hasClients ? positions : null;
}
