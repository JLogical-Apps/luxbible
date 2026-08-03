import 'package:flutter/material.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class StyledTile extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  final bool isSelected;
  final EdgeInsets padding;

  const StyledTile({super.key, required this.child, this.onPressed, this.isSelected = false, this.padding = .zero});

  StyledTile.message({
    super.key,
    required Widget leading,
    required Widget title,
    Widget? subtitle,
    this.onPressed,
    this.padding = .zero,
  }) : isSelected = false,
       child = Builder(
         builder: (context) => StyledListItem(
           leading: IconTheme.merge(
             data: IconThemeData(color: context.colors.contentTertiary),
             child: leading,
           ),
           title: DefaultTextStyle.merge(
             style: TextStyle(color: context.colors.contentTertiary),
             child: title,
           ),
           subtitle: subtitle?.mapIfNonNull(
             (subtitle) => DefaultTextStyle.merge(
               child: subtitle,
               style: TextStyle(color: context.colors.contentTertiary),
             ),
           ),
         ),
       );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: .circular(12),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        foregroundDecoration: BoxDecoration(
          borderRadius: .circular(12),
          border: Border.all(color: context.colors.border(isSelected), width: isSelected ? 3 : 2),
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
                child: StyledMaterial(onPressed: onPressed, padding: .all(16), child: SizedBox.expand()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
