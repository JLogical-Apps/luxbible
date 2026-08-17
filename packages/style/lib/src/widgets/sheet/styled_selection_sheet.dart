import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:style/src/widgets/sheet/styled_sheet.dart';
import 'package:style/src/widgets/styled_list_item.dart';
import 'package:style/src/widgets/styled_select.dart';

class StyledSelectionSheet<T> extends StyledSheet<T> {
  final List<T> options;
  final T? initialOption;
  final StyledSelectOption<T> Function(T) optionMapper;
  final Widget? aboveOptions;

  StyledSelectionSheet({
    super.key,
    required super.title,
    required this.options,
    this.initialOption,
    required this.optionMapper,
    this.aboveOptions,
    super.trailing,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StyledSheet(
      title: title,
      trailing: trailing,
      children: [
        ?aboveOptions,
        ...options.map(
          (option) => StyledListItem.radio(
            title: optionMapper(option).title,
            subtitle: optionMapper(option).subtitle,
            thirdLine: optionMapper(option).thirdLine,
            leading: optionMapper(option).leading,
            isSelected: option == initialOption,
            onSelected: () => context.pop(option),
          ),
        ),
      ],
    );
  }
}
