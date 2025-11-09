import 'package:bible/style/color_library.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/styled_material.dart';
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
              final color = action.colorMapper(context.colors);
              return Flexible(
                child: StyledMaterial(
                  onPressed: action.onPressed,
                  color: color,
                  child: SizedBox.expand(
                    child: Icon(
                      action.icon,
                      color: ColorLibrary.fromBackground(color).contentPrimary,
                    ),
                  ),
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
  final Color Function(ColorLibrary) colorMapper;
  final IconData icon;
  final Function() onPressed;

  const StyledSwipeableAction({
    required this.icon,
    required this.colorMapper,
    required this.onPressed,
  });

  StyledSwipeableAction.delete({required this.onPressed})
    : colorMapper = ((colors) => colors.backgroundCritical),
      icon = Symbols.delete;
}
