import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:style/style.dart';

// Columns are sized from sizingLabels rather than items, so they stay steady while items are filtered.
class StyledTileGrid<T> extends StatelessWidget {
  final List<T> items;
  final List<String> sizingLabels;
  final String Function(T) getLabel;
  final Function(T) onSelect;

  const StyledTileGrid({
    super.key,
    required this.items,
    required this.sizingLabels,
    required this.getLabel,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textStyle.labelMd;
    final textScaler = MediaQuery.textScalerOf(context);
    final tileWidth = max(
      48.0,
      sizingLabels.map((label) => textStyle.getWidth(label, textScaler: textScaler)).max + 16,
    );

    final spacing = 8.0;

    return LayoutBuilder(
      builder: (context, constraints) => GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: .zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: max(1, ((constraints.maxWidth + spacing) / (tileWidth + spacing)).floor()),
          mainAxisExtent: 48,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
        ),
        children: items
            .map(
              (item) => StyledTile(
                onPressed: () => onSelect(item),
                child: Center(child: Text(getLabel(item), style: textStyle)),
              ),
            )
            .toList(),
      ),
    );
  }
}
