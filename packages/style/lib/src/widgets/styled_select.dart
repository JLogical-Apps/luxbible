import 'package:style/style.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class StyledSelect<T> extends StatelessWidget {
  final List<T> options;
  final T selectedOption;
  final Function(T) onSelected;
  final StyledSelectOption<T> Function(T) optionMapper;

  final Widget label;

  final Widget? dialogTrailing;

  const StyledSelect({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onSelected,
    required this.optionMapper,
    required this.label,
    this.dialogTrailing,
  });

  @override
  Widget build(BuildContext context) {
    return StyledFormInput(
      label: label,
      child: StyledMaterial(
        padding: .all(12),
        colorBuilder: .surfaceSecondary,
        borderRadius: .circular(8),
        onPressed: () async {
          final newSelection = await context.showStyledSheet(
            (context) => StyledSelectionSheet<(T,)>(
              title: label,
              options: options.map((option) => (option,)).toList(),
              optionMapper: (record) {
                final option = optionMapper(record.$1);
                return StyledSelectOption<(T,)>(
                  title: option.title,
                  subtitle: option.subtitle,
                  thirdLine: option.thirdLine,
                  leading: option.leading,
                );
              },
              initialOption: (selectedOption,),
              trailing: dialogTrailing,
            ),
          );
          if (newSelection != null) {
            onSelected(newSelection.$1);
          }
        },
        child: Row(
          children: [
            gapW4,
            Expanded(
              child: DefaultTextStyle(
                style: context.textStyle.paragraphLg,
                maxLines: 1,
                overflow: .clip,
                child: optionMapper(selectedOption).title,
              ),
            ),
            gapW8,
            Icon(Symbols.keyboard_arrow_down, color: context.colors.contentTertiary),
          ],
        ),
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
