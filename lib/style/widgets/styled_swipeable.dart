import 'package:bible/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_symbols_icons/symbols.dart';

class StyledSwipeable extends StatelessWidget {
  final Widget child;

  final List<StyledSwipeableAction> actions;

  const StyledSwipeable({required super.key, required this.child, required this.actions});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Slidable(
          key: super.key,
          enabled: actions.isNotEmpty,
          groupTag: '0',
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            extentRatio: 64 * actions.length / constraints.maxWidth,
            children: actions.map((action) {
              final color = action.colorBuilder(context.colors);
              return Flexible(
                child: StyledMaterial(
                  onPressed: action.onPressed,
                  colorBuilder: action.colorBuilder,
                  child: SizedBox.expand(child: Icon(action.icon, color: color.foreground())),
                ),
              );
            }).toList(),
          ),
          child: child,
        );
      },
    );
  }
}

class StyledSwipeableAction {
  final ColorBuilder colorBuilder;
  final IconData icon;
  final Function() onPressed;

  const StyledSwipeableAction({required this.icon, required this.colorBuilder, required this.onPressed});

  StyledSwipeableAction.delete({required this.onPressed}) : colorBuilder = .backgroundError, icon = Symbols.delete;
}
