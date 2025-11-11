import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_material.dart';
import 'package:flutter/material.dart';

class StyledTile extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  const StyledTile({super.key, required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.colors.borderOpaque, width: 2),
        ),
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: DefaultTextStyle(
                style: context.textStyle.paragraphMd,
                textAlign: TextAlign.start,
                child: child,
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                ignoring: onPressed == null,
                child: StyledMaterial(
                  onPressed: onPressed,
                  padding: EdgeInsets.all(16),
                  child: SizedBox.expand(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
