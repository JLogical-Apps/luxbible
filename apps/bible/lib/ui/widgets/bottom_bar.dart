import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class BottomBar extends StatelessWidget {
  final String text;

  final Function() onClosePressed;
  final List<Widget> buttons;
  final Function() onMorePressed;

  final Color? color;

  const BottomBar({
    super.key,
    required this.text,
    required this.onClosePressed,
    required this.buttons,
    required this.onMorePressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: color ?? context.colors.surfacePrimary, borderRadius: .circular(8)),
        child: StyledListItem(
          title: Text(text, maxLines: 1, overflow: .ellipsis),
          leading: StyledCircleButton.md(onPressed: onClosePressed, child: Symbols.close.toIcon()),
          trailing: Row(
            children: [
              ...buttons,
              StyledCircleButton.md(onPressed: onMorePressed, child: Symbols.more_vert.toIcon()),
            ],
          ),
          showDividerOverride: false,
        ),
      ),
    );
  }
}
