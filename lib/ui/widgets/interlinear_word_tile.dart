import 'package:bible/models/bible/interlinear_data.dart';
import 'package:bible/models/bible/word.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/sheets/strong_sheet.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intersperse/intersperse.dart';
import 'package:material_symbols_icons/symbols.dart';

class InterlinearWordTile extends ConsumerWidget {
  final Word word;
  final InterlinearData data;
  final InterlinearDirection direction;
  final Function(VerseSelection) onNavigateToVerseSelection;

  const InterlinearWordTile({
    super.key,
    required this.word,
    required this.data,
    required this.direction,
    required this.onNavigateToVerseSelection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strongs = ref.watch(strongsProvider);
    return switch (direction) {
      .forward => StyledListItem(
        title: Row(
          spacing: 4,
          children: [
            Row(
              spacing: 4,
              children: [
                ?data.inflection?.toText(),
                if (data.strongId case final strongId?) StyledTag(child: strongId.toText()),
              ],
            ),
            if (strongs[data.strongId] case final strong?)
              Text(strong.transliteration, style: TextStyle(color: context.colors.contentSecondary)),
          ].intersperse(Text('·', style: TextStyle(color: context.colors.contentSecondary))).toList(),
        ),
        subtitle: Column(crossAxisAlignment: .start, children: [?word.text?.toText(), ?data.morphology?.toText()]),
        trailing: data.inflection == null ? null : Symbols.chevron_right.toIcon(),
        onPressed: data.inflection == null
            ? null
            : () {
                context.pop();
                StrongSheet.showWithBreadcrumbs(
                  context,
                  word: word,
                  strongId: word.data?.strongId,
                  onNavigateToVerseSelection: onNavigateToVerseSelection,
                );
              },
      ),
      .reverse => StyledListItem(
        title: (word.text ?? '').toText(),
        subtitle: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              spacing: 4,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    if (data.strongId case final strongId?) StyledTag(child: strongId.toText()),
                    ?data.inflection?.toText(),
                  ],
                ),
                if (strongs[data.strongId] case final strong?) strong.transliteration.toText(),
              ].intersperse('·'.toText()).toList(),
            ),
            ?data.morphology?.toText(),
          ],
        ),
        trailing: data.inflection == null ? null : Symbols.chevron_right.toIcon(),
        onPressed: data.inflection == null
            ? null
            : () {
                context.pop();
                StrongSheet.showWithBreadcrumbs(
                  context,
                  word: word,
                  strongId: word.data?.strongId,
                  onNavigateToVerseSelection: onNavigateToVerseSelection,
                );
              },
      ),
    };
  }
}

enum InterlinearDirection {
  reverse,
  forward;

  String title() => switch (this) {
    reverse => 'Reverse',
    forward => 'Forward',
  };

  String description() => switch (this) {
    reverse => 'Words appear in the English reading order.',
    forward => 'Words appear in the original Hebrew or Greek order.',
  };

  IconData icon() => switch (this) {
    reverse => Symbols.fast_rewind,
    forward => Symbols.fast_forward,
  };
}
