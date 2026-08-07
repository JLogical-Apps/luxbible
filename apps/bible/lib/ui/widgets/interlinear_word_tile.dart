import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/ui/sheets/strong_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intersperse/intersperse.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class InterlinearWordTile extends ConsumerWidget {
  final Word word;
  final InterlinearData data;
  final InterlinearDirection direction;
  final Function(VerseSelection) onNavigateToVerseSelection;
  final bool popOnAction;

  const InterlinearWordTile({
    super.key,
    required this.word,
    required this.data,
    required this.direction,
    required this.onNavigateToVerseSelection,
    this.popOnAction = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strongs = ref.watch(strongsProvider);
    return switch (direction) {
      .forward => StyledListItem(
        title: SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Row(
            spacing: 4,
            children: [
              Row(
                spacing: 4,
                children: [
                  ?data.inflection?.toText(),
                  if (data.strongId case final strongId?) StyledTag.sm(child: strongId.toText()),
                ],
              ),
              if (data.transliteration case final transliteration?)
                Text(transliteration, style: TextStyle(color: context.colors.contentSecondary)),
            ].intersperse(Text('·', style: TextStyle(color: context.colors.contentSecondary))).toList(),
          ),
        ),
        subtitle: Column(crossAxisAlignment: .start, children: [?word.text?.toText(), ?data.morphology?.toText()]),
        trailing: data.inflection == null ? null : Symbols.chevron_right.toIcon(),
        onPressed: data.inflection == null
            ? null
            : () {
                if (popOnAction) context.pop();
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
            SingleChildScrollView(
              scrollDirection: .horizontal,
              child: Row(
                spacing: 4,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      if (data.strongId case final strongId?) StyledTag.sm(child: strongId.toText()),
                      ?data.inflection?.toText(),
                    ],
                  ),
                  if (strongs[data.strongId] case final strong?) strong.transliteration.toText(),
                ].intersperse('·'.toText()).toList(),
              ),
            ),
            ?data.morphology?.toText(),
          ],
        ),
        trailing: data.inflection == null ? null : Symbols.chevron_right.toIcon(),
        onPressed: data.inflection == null
            ? null
            : () {
                if (popOnAction) context.pop();
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
    reverse => t.interlinearUi.reverse,
    forward => t.interlinearUi.forward,
  };

  String description() => switch (this) {
    reverse => t.interlinearUi.reverseDescription,
    forward => t.interlinearUi.forwardDescription,
  };

  IconData get icon => switch (this) {
    reverse => Symbols.fast_rewind,
    forward => Symbols.fast_forward,
  };
}
