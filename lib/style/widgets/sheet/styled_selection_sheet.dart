import 'package:bible/style/widgets/sheet/styled_sheet.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/style/widgets/styled_select.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:flutter/material.dart';

class StyledSelectionSheet<T> extends StatelessWidget {
  final Widget title;

  final List<T> options;
  final T? initialOption;
  final StyledSelectOption<T> Function(T) optionMapper;

  StyledSelectionSheet({
    super.key,
    Widget? title,
    String? titleText,
    required this.options,
    this.initialOption,
    required this.optionMapper,
  }) : title = title ?? titleText?.mapIfNonNull(Text.new) ?? SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return StyledSheet(
      title: title,
      children: options
          .map(
            (option) => StyledListItem.radio(
              title: optionMapper(option).title,
              selected: option == initialOption,
              onSelected: () => Navigator.of(context).pop(option),
            ),
          )
          .toList(),
    );
  }
}
