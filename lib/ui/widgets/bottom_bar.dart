import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

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
        decoration: BoxDecoration(
          color: color ?? context.colors.surfacePrimary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: StyledListItem(
          title: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
          leading: StyledCircleButton.lg(onPressed: onClosePressed, child: Symbols.close.toIcon()),
          trailing: Row(
            children: [
              ...buttons,
              StyledCircleButton.lg(onPressed: onMorePressed, child: Symbols.more_vert.toIcon()),
            ],
          ),
        ),
      ),
    );
  }
}
