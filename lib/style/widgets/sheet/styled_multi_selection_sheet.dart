import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StyledMultiSelectionSheet<T> extends HookWidget {
  final Widget title;
  final Widget? trailing;

  final List<T> options;
  final List<T> initialOptions;
  final StyledSelectOption<T> Function(T) optionMapper;

  StyledMultiSelectionSheet({
    super.key,
    Widget? title,
    String? titleText,
    this.trailing,
    required this.options,
    this.initialOptions = const [],
    required this.optionMapper,
  }) : title = title ?? titleText?.mapIfNonNull(Text.new) ?? SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    final selectedOptionsState = useState(initialOptions);
    return StyledSheet(
      title: title,
      trailing: trailing,
      children: options
          .map(
            (option) => StyledListItem.checkbox(
              title: optionMapper(option).title,
              subtitle: optionMapper(option).subtitle,
              leading: optionMapper(option).leading,
              selected: selectedOptionsState.value.contains(option),
              onSelected: (selected) => selectedOptionsState.value = selectedOptionsState.value.withToggle(option),
            ),
          )
          .toList(),
      buttonsBuilder: (context) => [
        StyledRectButton.primary(onPressed: () => context.pop(selectedOptionsState.value), labelText: 'Save'),
      ],
    );
  }
}
