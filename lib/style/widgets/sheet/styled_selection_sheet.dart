import 'package:bible/style/widgets/sheet/styled_sheet.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/style/widgets/styled_select.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class StyledSelectionSheet<T> extends StyledSheet<T> {
  final List<T> options;
  final T? initialOption;
  final StyledSelectOption<T> Function(T) optionMapper;

  const StyledSelectionSheet({
    super.key,
    required super.title,
    required this.options,
    this.initialOption,
    required this.optionMapper,
  });

  @override
  Widget build(BuildContext context) {
    return StyledSheet(
      title: title,
      children: options
          .map(
            (option) => StyledListItem.radio(
              title: optionMapper(option).title,
              subtitle: optionMapper(option).subtitle,
              leading: optionMapper(option).leading,
              selected: option == initialOption,
              onSelected: () => context.pop(option),
            ),
          )
          .toList(),
    );
  }
}
