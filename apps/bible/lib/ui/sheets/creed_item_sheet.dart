import 'package:bible/models/creed.dart';
import 'package:bible/ui/pages/creed_page.dart';
import 'package:bible/ui/widgets/creed_item_view.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class CreedItemSheet {
  static Future<void> show(
    BuildContext context, {
    required CreedItemReference reference,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) => context.showStyledSheetWithBreadcrumbs(breadcrumbText: reference.title, (context, ref) {
    final item = reference.item;
    final (title, heading) = switch ((reference.chapter.heading, item.number, item.title)) {
      (final chapterHeading?, _, _) => (reference.title, chapterHeading),
      (_, _?, _?) => (reference.creed.title, reference.heading),
      _ => (reference.title, null),
    };

    void navigateToVerseSelection(VerseSelection verseSelection) {
      // An article linked from the item replaces this sheet in the breadcrumbs.
      if (context.mounted) context.pop();
      onNavigateToVerseSelection(verseSelection);
    }

    return StyledSheet(
      title: title.toText(),
      trailing: StyledCircleButton.md(
        child: Symbols.open_in_full.toIcon(),
        onPressed: () async {
          final result = await context.push(CreedPage(creed: reference.creed, initialItem: item));
          if (result != null && context.mounted) navigateToVerseSelection(result);
        },
      ),
      children: [
        if (heading != null)
          Padding(
            padding: .only(left: 16, right: 16, top: 16),
            child: Text(heading, style: context.textStyle.headingXxs),
          ),
        Padding(
          padding: .only(top: 16),
          child: CreedItemView(item: item, onNavigateToVerseSelection: navigateToVerseSelection),
        ),
      ],
    );
  });
}
