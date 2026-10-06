import 'package:bible/models/creed.dart';
import 'package:bible/ui/sheets/preview_passage_sheet.dart';
import 'package:bible/ui/widgets/passage_list_item.dart';
import 'package:bible/ui/widgets/rich_content_view.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class CreedItemView extends StatelessWidget {
  final CreedItem item;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const CreedItemView({super.key, required this.item, required this.onNavigateToVerseSelection});

  @override
  Widget build(BuildContext context) => Padding(
    padding: .only(left: 16, right: 16, bottom: 24, top: 4),
    child: Column(
      crossAxisAlignment: .stretch,
      spacing: 16,
      children: [
        RichContentList(content: item.body, onNavigateToVerseSelection: onNavigateToVerseSelection),
        if (item.passages.isNotEmpty)
          StyledExpandableTile(
            title: t.creeds.scriptureProofs.toText(),
            children: item.passages
                .map(
                  (passage) => PassageListItem(
                    verseSelection: passage,
                    maxLines: 4,
                    onPressed: () => PreviewPassageSheet.show(
                      context,
                      verseSelection: passage,
                      onNavigateToVerseSelection: onNavigateToVerseSelection,
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    ),
  );
}
