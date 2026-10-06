import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:style/src/widgets/styled_list.dart';
import 'package:style/src/widgets/styled_list_item.dart';
import 'package:style/src/widgets/styled_size_and_fade.dart';
import 'package:style/src/widgets/styled_tile.dart';

class StyledExpandableTile extends HookWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final List<Widget> children;
  final bool isInitiallyExpanded;

  const StyledExpandableTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    required this.children,
    this.isInitiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final isExpandedState = useState(isInitiallyExpanded);
    return StyledTile(
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          StyledListItem(
            leading: leading,
            title: title,
            subtitle: subtitle,
            trailing: AnimatedRotation(
              turns: isExpandedState.value ? 0.5 : 0,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              child: Symbols.keyboard_arrow_down.toIcon(),
            ),
            showDividerOverride: isExpandedState.value,
            onPressed: () => isExpandedState.value = !isExpandedState.value,
          ),
          StyledSizeAndFade.showHide(
            show: isExpandedState.value,
            alignment: .topCenter,
            child: StyledList(children: children),
          ),
        ],
      ),
    );
  }
}
