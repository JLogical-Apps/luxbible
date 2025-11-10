import 'package:bible/style/style_context_extensions.dart';
import 'package:flutter/material.dart';

class StyledRadio extends StatelessWidget {
  final bool selected;

  const StyledRadio({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: selected ? context.colors.contentPrimary : Color(0xFF5E5E5E),
        ),
        color: selected ? context.colors.contentPrimary : Colors.transparent,
        shape: BoxShape.circle,
      ),
      height: 24,
      width: 24,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: selected ? context.colors.contentPrimaryInverse : Colors.transparent,
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
