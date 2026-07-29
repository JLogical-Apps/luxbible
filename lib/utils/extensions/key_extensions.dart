import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:flutter/material.dart';

extension GlobalKeyExtensions on GlobalKey {
  RenderBox? get renderBox => currentContext?.findRenderObject()?.as<RenderBox>();

  double? get globalTop => renderBox?.localToGlobal(.zero).dy;
  double? get globalBottom {
    final renderBox = this.renderBox;
    return renderBox?.localToGlobal(Offset(0, renderBox.size.height)).dy;
  }

  Rect? get globalBounds {
    final renderBox = this.renderBox;
    return renderBox == null
        ? null
        : Rect.fromPoints(
            renderBox.localToGlobal(.zero),
            renderBox.localToGlobal(Offset(renderBox.size.width, renderBox.size.height)),
          );
  }
}
