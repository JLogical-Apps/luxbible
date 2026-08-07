import 'package:flutter/material.dart';

extension GlobalKeyExtensions on GlobalKey {
  RenderBox? get renderBox {
    final context = currentContext;
    if (context == null || !context.mounted) return null;

    var isActive = true;
    assert(() {
      isActive = context is Element && context.debugIsActive;
      return true;
    }());

    if (!isActive) return null;

    final renderObject = context.findRenderObject();
    return renderObject is RenderBox && renderObject.attached ? renderObject : null;
  }

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

  Future<void> scrollIntoView({
    double alignment = 0.5,
    Axis? axis,
    required Duration duration,
    Curve curve = Curves.easeInOutCubic,
  }) async {
    final context = currentContext;
    if (context == null || !context.mounted) return;

    final scrollable = Scrollable.maybeOf(context, axis: axis);
    if (scrollable == null) return;

    scrollable.position.ensureVisible(
      context.findRenderObject()!,
      alignment: alignment,
      duration: duration,
      curve: curve,
    );
  }
}
