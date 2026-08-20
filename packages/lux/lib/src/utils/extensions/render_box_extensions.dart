import 'package:flutter/rendering.dart';

extension RenderBoxExtensions on RenderBox {
  Size? get sizeOrNull => hasSize ? size : null;
}
