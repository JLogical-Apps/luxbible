import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/widgets/sheet/styled_selection_sheet.dart';
import 'package:bible/style/widgets/styled_material.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class StyledSelect<T> extends StatelessWidget {
  final List<T> options;
  final T selectedOption;
  final Function(T) onSelected;
  final StyledSelectOption<T> Function(T) optionMapper;

  final String dialogTitle;
  final Widget? dialogTrailing;

  const StyledSelect({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onSelected,
    required this.optionMapper,
    required this.dialogTitle,
    this.dialogTrailing,
  });

  @override
  Widget build(BuildContext context) {
    return StyledMaterial(
      padding: .all(12),
      colorBuilder: .surfaceSecondary,
      borderRadius: .circular(8),
      onPressed: () async {
        final newSelection = await context.showStyledSheet(
          (context) => StyledSelectionSheet(
            title: dialogTitle.toText(),
            options: options,
            optionMapper: optionMapper,
            initialOption: selectedOption,
            trailing: dialogTrailing,
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
              overflow: .clip,
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
  final Widget? thirdLine;
  final Widget? leading;

  StyledSelectOption({required this.title, this.subtitle, this.thirdLine, this.leading});
}
