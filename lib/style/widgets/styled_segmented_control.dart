import 'dart:math';

import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class StyledSegmentedControl<T> extends StatelessWidget {
  final List<T> options;
  final T selectedOption;
  final Function(T) onOptionSelected;
  final String Function(T) textBuilder;

  const StyledSegmentedControl({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
    required this.textBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textStyle.labelSm;
    return Container(
      decoration: BoxDecoration(color: context.colors.backgroundPrimary, borderRadius: .circular(8)),
      padding: .all(4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final optionTextWidths = options
              .map((option) => textBuilder(option))
              .map((text) => textStyle.getWidth(text))
              .toList();
          final selectionIndex = options.indexOfOrNull(selectedOption);

          final availablePaddingSpace = constraints.maxWidth - optionTextWidths.sum;
          const preferredPadding = 16;
          final paddingPerOption = min(availablePaddingSpace / options.length, preferredPadding * 2);
          final optionWidths = optionTextWidths.map((width) => width + paddingPerOption).toList();

          const height = 28.0;

          return SizedBox(
            height: height,
            child: Stack(
              children: [
                AnimatedPositioned(
                  key: ValueKey(options.contains(selectedOption) ? 'has-selection' : 'no-selection'),
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic,
                  left: selectionIndex == null ? 0 : optionWidths.take(selectionIndex).sum,
                  child: selectionIndex != null
                      ? AnimatedContainer(
                          height: height,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOutCubic,
                          width: optionWidths[selectionIndex],
                          decoration: BoxDecoration(color: context.colors.contentPrimary, borderRadius: .circular(6)),
                        )
                      : SizedBox.shrink(),
                ),
                Row(
                  mainAxisSize: .min,
                  children: options
                      .mapIndexed(
                        (i, option) => GestureDetector(
                          onTap: () => onOptionSelected(option),
                          child: Container(
                            color: Colors.transparent,
                            width: optionWidths[i],
                            child: Center(
                              child: AnimatedDefaultTextStyle(
                                style: textStyle.copyWith(
                                  color: i == selectionIndex ? context.colors.contentPrimaryInverse : null,
                                ),
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOutCubic,
                                child: Text(textBuilder(option)),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
