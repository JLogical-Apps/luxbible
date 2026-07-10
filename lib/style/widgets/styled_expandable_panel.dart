import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_symbols_icons/symbols.dart';

class StyledExpandablePanel extends HookWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? thirdLine;
  final List<Widget> children;

  final bool isInitiallyExpanded;
  final Function(bool)? onExpandedChanged;

  final VoidCallback? onHeaderPressed;
  final bool showHeaderDivider;

  final bool isEnabled;

  const StyledExpandablePanel({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.thirdLine,
    required this.children,
    this.isInitiallyExpanded = false,
    this.onExpandedChanged,
    this.onHeaderPressed,
    this.showHeaderDivider = true,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isExpandedState = useState(isInitiallyExpanded);

    void toggle() {
      isExpandedState.value = !isExpandedState.value;
      onExpandedChanged?.call(isExpandedState.value);
    }

    final chevron = AnimatedRotation(
      turns: isExpandedState.value ? 0.5 : 0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      child: Symbols.keyboard_arrow_down.toIcon(),
    );

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        StyledListItem(
          leading: leading,
          title: title,
          subtitle: subtitle,
          thirdLine: thirdLine,
          isEnabled: isEnabled,
          showDividerOverride: false,
          onPressed: onHeaderPressed ?? toggle,
          trailing: onHeaderPressed == null ? chevron : StyledCircleButton.md(onPressed: toggle, child: chevron),
        ),
        AnimatedGrow.showHide(
          show: isExpandedState.value,
          clip: .hardEdge,
          child: Column(
            children: [
              if (showHeaderDivider) StyledDivider(height: 2),
              StyledList(children: children),
            ],
          ),
        ),
      ],
    );
  }
}
