import 'package:bible/style/style.dart';
import 'package:flutter/material.dart';

class StyledProgressBar extends StatelessWidget {
  final double value;
  final Color? color;

  const StyledProgressBar({super.key, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 4,
      child: TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: value.clamp(0.0, 1.0)),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        builder: (context, value, child) => LinearProgressIndicator(
          value: value,
          backgroundColor: context.colors.borderOpaque,
          color: color ?? context.colors.borderSelected,
        ),
      ),
    );
  }
}
