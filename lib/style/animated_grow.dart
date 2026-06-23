import 'package:flutter/material.dart';

class AnimatedGrow extends StatelessWidget {
  final Widget? child;

  final Clip clip;
  final Alignment alignment;
  final Axis axis;
  final Duration duration;

  const AnimatedGrow({
    super.key,
    required this.child,
    this.clip = .none,
    this.alignment = .topCenter,
    this.axis = .vertical,
    this.duration = const Duration(milliseconds: 300),
  });

  AnimatedGrow.showHide({
    super.key,
    required Widget child,
    required bool show,
    this.clip = .none,
    this.alignment = .topCenter,
    this.axis = .vertical,
    this.duration = const Duration(milliseconds: 300),
  }) : child = show
           ? child
           : SizedBox(
               key: ValueKey('empty'),
               width: axis == .vertical ? double.infinity : 0,
               height: axis == .vertical ? 0 : double.infinity,
             );

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: duration,
      curve: Curves.easeInOutCubic,
      alignment: alignment,
      clipBehavior: clip,
      child: AnimatedSwitcher(
        duration: duration,
        reverseDuration: duration,
        switchOutCurve: Curves.easeInCubic,
        switchInCurve: Curves.easeInCubic,
        layoutBuilder: _layoutBuilder,
        transitionBuilder: (child, animation) => child,
        child: child,
      ),
    );
  }

  Widget _layoutBuilder(Widget? currentChild, List<Widget> previousChildren) {
    return Stack(
      clipBehavior: clip,
      alignment: alignment,
      children: [
        if (previousChildren.firstOrNull case final previousChild?)
          Positioned(
            left: axis == .vertical ? 0 : null,
            right: axis == .vertical ? 0 : null,
            top: axis == .horizontal ? 0 : null,
            bottom: axis == .horizontal ? 0 : null,
            child: previousChild,
          ),
        ?currentChild,
      ],
    );
  }
}
