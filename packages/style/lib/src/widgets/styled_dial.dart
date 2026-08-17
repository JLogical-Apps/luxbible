import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:style/src/style_context_extensions.dart';
import 'package:style/src/text_style_extensions.dart';

class StyledDial<T> extends HookWidget {
  final List<T> options;
  final T initiallySelected;
  final Function(T) onSelected;
  final Widget Function(T) itemBuilder;

  const StyledDial({
    super.key,
    required this.options,
    required this.initiallySelected,
    required this.onSelected,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final selected = useState(initiallySelected);
    final controller = useFixedExtentScrollController(initialItem: options.indexOf(initiallySelected));

    return SizedBox(
      width: 88,
      height: 192,
      child: Stack(
        alignment: .center,
        children: [
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: context.colors.backgroundPrimary,
              border: Border.all(color: context.colors.borderOpaque),
              borderRadius: .circular(8),
            ),
          ),
          ListWheelScrollView.useDelegate(
            controller: controller,
            physics: FixedExtentScrollPhysics(),
            itemExtent: 48,
            diameterRatio: 1.4,
            perspective: 0.003,
            overAndUnderCenterOpacity: 0.35,
            onSelectedItemChanged: (index) {
              selected.value = options[index];
              onSelected(options[index]);
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: options.length,
              builder: (context, index) => Center(
                child: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 250),
                  curve: Curves.easeInOutCubic,
                  style: options[index] == selected.value
                      ? context.textStyle.headingSm
                      : context.textStyle.headingSm.subtleTertiary(),
                  child: itemBuilder(options[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
