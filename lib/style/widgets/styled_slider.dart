import 'package:flutter/material.dart';

class StyledSlider extends StatelessWidget {
  final double value;
  final (double min, double max) bounds;
  final Function(double)? onChanged;
  final Function(double)? onChangeStart;
  final Function(double)? onChangeEnd;

  const StyledSlider({
    super.key,
    required this.value,
    required this.bounds,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Slider(
        value: value,
        onChanged: onChanged,
        onChangeStart: onChangeStart,
        onChangeEnd: onChangeEnd,
        min: bounds.$1,
        max: bounds.$2,
        padding: .symmetric(horizontal: 8),
      ),
    );
  }
}
