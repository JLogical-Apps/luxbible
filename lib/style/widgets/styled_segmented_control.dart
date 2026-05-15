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
      width: double.infinity,
      decoration: BoxDecoration(color: context.colors.backgroundPrimary, borderRadius: .circular(12)),
      padding: .all(4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final selectionIndex = options.indexOfOrNull(selectedOption);

          final width = constraints.maxWidth / options.length;
          const height = 48.0;

          return SizedBox(
            height: height,
            child: Stack(
              children: [
                AnimatedPositioned(
                  key: ValueKey(options.contains(selectedOption) ? 'has-selection' : 'no-selection'),
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic,
                  left: selectionIndex == null ? 0 : width * selectionIndex,
                  child: selectionIndex != null
                      ? AnimatedContainer(
                          height: height,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOutCubic,
                          width: width,
                          decoration: BoxDecoration(
                            color: context.colors.surfacePrimary,
                            borderRadius: .circular(8),
                            border: Border.all(color: context.colors.borderSelected, width: 1),
                          ),
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
                            width: width,
                            padding: .symmetric(horizontal: 16),
                            child: Center(
                              child: AnimatedDefaultTextStyle(
                                style: textStyle.copyWith(
                                  color: i == selectionIndex ? null : context.colors.contentSecondary,
                                ),
                                textAlign: .center,
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
