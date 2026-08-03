import 'package:flutter/material.dart';
import 'package:utils_core/utils_core.dart';

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

  Future<void> scrollIntoView({double alignment = 0.5, Axis? axis, required Duration duration}) async {
    final context = currentContext;
    if (context == null || !context.mounted) return;

    final scrollable = Scrollable.maybeOf(context, axis: axis);
    if (scrollable == null) return;

    scrollable.position.ensureVisible(
      context.findRenderObject()!,
      alignment: alignment,
      duration: duration,
      curve: Curves.easeInOutCubic,
    );
  }
}
