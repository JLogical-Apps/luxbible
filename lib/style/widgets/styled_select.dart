import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_selection_sheet.dart';
import 'package:bible/style/widgets/styled_material.dart';
import 'package:bible/utils/extensions/object_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class StyledSelect<T> extends StatelessWidget {
  final List<T> options;
  final T selectedOption;
  final Function(T) onSelected;
  final StyledSelectOption<T> Function(T) optionMapper;

  final String dialogTitle;

  const StyledSelect({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onSelected,
    required this.optionMapper,
    required this.dialogTitle,
  });

  @override
  Widget build(BuildContext context) {
    return StyledMaterial(
      padding: EdgeInsets.all(12),
      color: context.colors.surfaceSecondary,
      borderRadius: BorderRadius.circular(8),
      onPressed: () async {
        final newSelection = await context.showStyledSheet(
          StyledSelectionSheet(
            titleText: dialogTitle,
            options: options,
            optionMapper: optionMapper,
            initialOption: selectedOption,
          ),
        );
        if (newSelection is T) {
          onSelected(newSelection);
        }
      },
      child: Row(
        spacing: 8,
        children: [
          Expanded(
            child: DefaultTextStyle(
              style: context.textStyle.paragraphLg,
              maxLines: 1,
              overflow: TextOverflow.fade,
              child: optionMapper(selectedOption).title,
            ),
          ),
          Icon(Symbols.keyboard_arrow_down, color: context.colors.contentTertiary),
        ],
      ),
    );
  }
}

class StyledSelectOption<T> {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;

  StyledSelectOption({
    Widget? title,
    String? titleText,
    Widget? subtitle,
    String? subtitleText,
    Widget? leading,
    IconData? leadingIcon,
  }) : title = title ?? titleText?.mapIfNonNull(Text.new) ?? SizedBox.shrink(),
       subtitle = subtitle ?? subtitleText?.mapIfNonNull(Text.new),
       leading = leading ?? leadingIcon?.mapIfNonNull(Icon.new);
}
