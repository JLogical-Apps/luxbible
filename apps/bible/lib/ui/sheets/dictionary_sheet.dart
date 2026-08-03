import 'package:bible/models/dictionary_entry.dart';
import 'package:bible/providers/dictionary_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/ui/sheets/preview_passage_sheet.dart';
import 'package:flutter/material.dart';
import 'package:intersperse/intersperse.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class DictionarySheet {
  static const dictionaryTargetPrefix = 'dictionary:';

  static Future<void> show(
    BuildContext context, {
    required DictionaryEntry entry,
    required Function(VerseSelection) onNavigateToVerseSelection,
  }) => context.showStyledSheetWithBreadcrumbs(
    breadcrumbText: entry.title,
    (context) => StyledSheet(
      title: entry.title.toText(),
      subtitle: t.dictionary.eastons.toText(),
      children: entry.definitions
          .map<Widget>(
            (definition) => Padding(
              padding: .all(16),
              child: MarkdownBuilder(
                definition,
                style: context.textStyle.paragraphMd,
                onLinkPressed: (text, link) {
                  if (link.startsWith(dictionaryTargetPrefix)) {
                    final key = Uri.decodeComponent(link.substring(dictionaryTargetPrefix.length));
                    final linkedEntry = ref.read(dictionaryProvider)[key];
                    if (linkedEntry == null) return;

                    context.pop();
                    show(context, entry: linkedEntry, onNavigateToVerseSelection: onNavigateToVerseSelection);
                  } else {
                    PreviewPassageSheet.show(
                      context,
                      verseSelection: VerseSelection.fromOsisId(link),
                      onNavigateToVerseSelection: (verseSelection) {
                        context.pop();
                        onNavigateToVerseSelection(verseSelection);
                      },
                    );
                  }
                },
              ),
            ),
          )
          .intersperse(StyledDivider(height: 2))
          .toList(),
    ),
  );
}
