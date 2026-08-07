import 'package:flutter/material.dart';
import 'package:style/src/style_context_extensions.dart';

class StyledRadio extends StatelessWidget {
  final bool isSelected;

  const StyledRadio({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 3, color: isSelected ? context.colors.contentPrimary : Color(0xFF5E5E5E)),
        color: isSelected ? context.colors.contentPrimary : Colors.transparent,
        shape: BoxShape.circle,
      ),
      height: 24,
      width: 24,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? context.colors.contentPrimaryInverse : Colors.transparent,
            shape: BoxShape.circle,
          ),
          height: 6,
          width: 6,
          child: Container(),
        ),
      ),
    );
  }
}
