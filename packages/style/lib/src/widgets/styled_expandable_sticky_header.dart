import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:style/src/widgets/styled_circle_button.dart';
import 'package:style/src/widgets/styled_sticky_header.dart';

class StyledExpandableStickyHeader extends HookWidget {
  final Widget title;
  final Widget? subtitle;
  final List<Widget> children;
  final bool initiallyShown;

  const StyledExpandableStickyHeader({
    super.key,
    required this.title,
    required this.children,
    this.subtitle,
    this.initiallyShown = true,
  });

  @override
  Widget build(BuildContext context) {
    final showChildrenState = useState(initiallyShown);
    return StyledStickyHeader(
      title: title,
      subtitle: subtitle,
      trailing: StyledCircleButton.md(
        onPressed: () => showChildrenState.value = !showChildrenState.value,
        child: AnimatedRotation(
          turns: showChildrenState.value ? 0.5 : 0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          child: Symbols.keyboard_arrow_down.toIcon(),
        ),
      ),
      onHeaderPressed: () => showChildrenState.value = !showChildrenState.value,
      showChildren: showChildrenState.value,
      children: children,
    );
  }
}
