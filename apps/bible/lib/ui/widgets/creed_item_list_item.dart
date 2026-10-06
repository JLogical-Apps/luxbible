import 'package:bible/models/creed.dart';
import 'package:bible/ui/sheets/creed_item_sheet.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class CreedItemListItem extends StatelessWidget {
  final CreedItemReference reference;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const CreedItemListItem({super.key, required this.reference, required this.onNavigateToVerseSelection});

  @override
  Widget build(BuildContext context) {
    final preview = switch (reference.item.title) {
      final title? => Markdown.fromPlainText(title),
      _ => reference.item.preview,
    };
    return StyledListItem.navigation(
      title: reference.title.toText(),
      subtitle: preview?.mapIfNonNull((preview) => MarkdownBuilder(preview.withCollapsedWhitespace, maxLines: 2)),
      onPressed: () =>
          CreedItemSheet.show(context, reference: reference, onNavigateToVerseSelection: onNavigateToVerseSelection),
    );
  }
}
