import 'package:bible/style/widgets/sheet/styled_sheet.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/style/widgets/styled_select.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class StyledSelectionSheet<T> extends StyledSheet<T> {
  final List<T> options;
  final T? initialOption;
  final StyledSelectOption<T> Function(T) optionMapper;
  final Widget? aboveOptions;

  const StyledSelectionSheet({
    super.key,
    required super.title,
    required this.options,
    this.initialOption,
    required this.optionMapper,
    this.aboveOptions,
    super.trailing,
  });

  @override
  Widget build(BuildContext context) {
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
