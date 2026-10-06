import 'package:bible/models/creed.dart';
import 'package:bible/ui/widgets/creed_item_view.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class CreedItemSheet {
  static Future<void> show(
    BuildContext context, {
    required CreedItemReference reference,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) => context.showStyledSheetWithBreadcrumbs(breadcrumbText: reference.title, (context, ref) {
    final item = reference.item;
    final heading = (item.number == null ? null : item.title) ?? reference.chapter.title;

    void navigateToVerseSelection(VerseSelection verseSelection) {
      context.pop();
      onNavigateToVerseSelection(verseSelection);
    }

    return StyledSheet(
      title: reference.title.toText(),
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
