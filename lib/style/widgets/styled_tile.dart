import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:flutter/material.dart';

class StyledTile extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  final EdgeInsets padding;

  const StyledTile({super.key, required this.child, this.onPressed, this.padding = EdgeInsets.zero});

  StyledTile.message({
    super.key,
    required IconData icon,
    required String titleText,
    String? subtitleText,
    this.onPressed,
    this.padding = EdgeInsets.zero,
  }) : child = Builder(
         builder: (context) => StyledListItem(
           leading: Icon(icon, color: context.colors.contentTertiary),
           title: Text(titleText, style: TextStyle(color: context.colors.contentTertiary)),
           subtitle: subtitleText?.mapIfNonNull(
             (text) => Text(text, style: TextStyle(color: context.colors.contentTertiary)),
           ),
         ),
       );

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
              padding: padding,
              child: DefaultTextStyle(style: context.textStyle.paragraphMd, textAlign: TextAlign.start, child: child),
            ),
            Positioned.fill(
              child: IgnorePointer(
                ignoring: onPressed == null,
                child: StyledMaterial(onPressed: onPressed, padding: EdgeInsets.all(16), child: SizedBox.expand()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
