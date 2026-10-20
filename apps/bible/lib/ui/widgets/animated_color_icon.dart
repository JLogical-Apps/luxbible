import 'package:flutter/material.dart';

class AnimatedColorIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double? size;

  const AnimatedColorIcon(this.icon, {super.key, required this.color, this.size});

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOutCubic,
    tween: ColorTween(begin: color, end: color),
    builder: (context, color, child) => Icon(icon, size: size, color: color),
  );
}
