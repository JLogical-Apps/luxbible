import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

    await scrollable.position.ensureVisible(
      context.findRenderObject()!,
      alignment: alignment,
      duration: duration,
      curve: curve,
    );
  }

  // getOffsetToReveal falls short in a SliverMainAxisGroup by subtracting every visible sticky header before it.
  double? get scrollOffset => switch (currentContext?.findRenderObject()) {
    final RenderSliver sliver when sliver.attached => sliver.constraints.precedingScrollExtent,
    final RenderObject object when object.attached => RenderAbstractViewport.of(
      object,
    ).getOffsetToReveal(object, 0).offset,
    _ => null,
  };

  // The extra pixel absorbs rounding after jumpToTop lands exactly on the offset.
  bool hasReachedTop({double padding = 0}) {
    final context = currentContext;
    final offset = scrollOffset;
    return context != null && offset != null && offset - padding <= Scrollable.of(context).position.pixels + 1;
  }

  Future<void> jumpToTop({double padding = 0}) async {
    final context = currentContext;
    final offset = scrollOffset;
    if (context == null || !context.mounted || offset == null) return;

    final position = Scrollable.of(context).position;
    void jumpTo(double offset) => position.jumpTo(offset.clamp(position.minScrollExtent, position.maxScrollExtent));

    jumpTo(offset - padding);

    final sliver = context.findRenderObject();
    if (sliver is! RenderSliver) return;

    // Pinned headers above the sliver only report how much they cover it once it is scrolled under them.
    await WidgetsBinding.instance.endOfFrame;
    if (!sliver.attached) return;
    jumpTo(position.pixels - sliver.constraints.overlap);
  }
}
