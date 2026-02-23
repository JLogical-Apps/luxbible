import 'package:flutter/material.dart';

class AnimatedGrow extends StatelessWidget {
  final Widget? child;

  final Clip clip;
  final Alignment alignment;
  final Axis axis;

  const AnimatedGrow({
    super.key,
    required this.child,
    this.clip = Clip.none,
    this.alignment = Alignment.topCenter,
    this.axis = Axis.vertical,
  });

  AnimatedGrow.showHide({
    super.key,
    required Widget child,
    required bool show,
    this.clip = Clip.none,
    this.alignment = Alignment.topCenter,
    this.axis = Axis.vertical,
  }) : child = show
           ? child
           : SizedBox(
               key: ValueKey('empty'),
               width: axis == Axis.vertical ? double.infinity : 0,
               height: axis == Axis.vertical ? 0 : double.infinity,
             );

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      alignment: alignment,
      clipBehavior: clip,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        reverseDuration: Duration(milliseconds: 300),
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
            left: axis == Axis.vertical ? 0 : null,
            right: axis == Axis.vertical ? 0 : null,
            top: axis == Axis.horizontal ? 0 : null,
            bottom: axis == Axis.horizontal ? 0 : null,
            child: previousChild,
          ),
        ?currentChild,
      ],
    );
  }
}
