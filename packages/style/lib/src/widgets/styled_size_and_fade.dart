import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';

class StyledSizeAndFade extends StatelessWidget {
  final Widget? child;
  final bool show;

  final Clip clip;
  final Alignment alignment;
  final Axis axis;
  final Duration duration;

  const StyledSizeAndFade({
    super.key,
    required this.child,
    this.clip = .hardEdge,
    this.alignment = .topCenter,
    this.axis = .vertical,
    this.duration = const Duration(milliseconds: 300),
  }) : show = true;

  const StyledSizeAndFade.showHide({
    super.key,
    required Widget this.child,
    required this.show,
    this.clip = .hardEdge,
    this.alignment = .center,
    this.axis = .vertical,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSizeAndFade.showHide(
      child: child,
      show: show,
      alignment: alignment,
      clipBehavior: clip,
      fadeInCurve: Curves.easeInOutCubic,
      fadeOutCurve: Curves.easeInOutCubic,
      fadeDuration: duration,
      sizeCurve: Curves.easeInOutCubic,
      sizeDuration: duration,
    );
  }
}
