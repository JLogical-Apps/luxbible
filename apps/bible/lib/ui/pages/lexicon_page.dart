import 'package:bible/models/strong.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/ui/sheets/strong_sheet.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

enum StrongLanguage {
  hebrew,
  greek;

  String title() => switch (this) {
    hebrew => t.languages.hebrew,
    greek => t.languages.greek,
  };

  bool matches(Strong strong) => switch (this) {
    hebrew => strong.id.startsWith('H'),
    greek => strong.id.startsWith('G'),
  };
}

class LexiconPage extends HookConsumerWidget {
  const LexiconPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strongs = ref.watch(strongsProvider);
    final entries = useMemoized(
      () => strongs.values.sorted((a, b) {
        if (a.id[0] != b.id[0]) {
          return a.id.startsWith('H') ? -1 : 1;
        }
        return (int.tryParse(a.id.substring(1)) ?? 0).compareTo(int.tryParse(b.id.substring(1)) ?? 0);
      }),
      [strongs],
    );

    final searchState = useState('');
    final search = searchState.value.trim().toUpperCase();

    final languageState = useState<StrongLanguage?>(null);
    final language = languageState.value;

    final matchingEntries = entries
        .where((strong) => language == null || language.matches(strong))
        .where((strong) => search.isEmpty || strong.id.toUpperCase().startsWith(search))
        .toList();

    return StyledPage(
      title: t.labels.lexicon.toText(),
      body: Column(
        children: [
          Container(
            padding: MediaQuery.viewPaddingOf(context).onlyHorizontal + .all(16),
            decoration: BoxDecoration(color: context.colors.surfacePrimary, boxShadow: [StyledShadow.down(context)]),
            child: Column(
              spacing: 12,
              crossAxisAlignment: .start,
              children: [
                StyledTextField(
                  text: searchState.value,
                  hintText: t.searchUi.strongNumberHint,
                  onChanged: (text) => searchState.value = text,
                ),
                StyledPillButton.md(
                  colorBuilder: language == null ? null : .primary,
                  leading: Symbols.translate.toIcon(),
                  label: (language?.title() ?? t.labels.language).toText(),
                  trailing: Symbols.keyboard_arrow_down.toIcon(),
                  onPressed: () async {
                    final newLanguage = await context.showStyledSheet(
                      (context) => StyledSelectionSheet(
                        title: t.labels.language.toText(),
                        trailing: language == null
                            ? null
                            : StyledCircleButton.md(
                                child: Symbols.delete.toIcon(),
                                onPressed: () {
                                  languageState.value = null;
                                  context.pop();
                                },
                              ),
                        options: StrongLanguage.values,
                        optionMapper: (option) => StyledSelectOption(title: option.title().toText()),
                        initialOption: language,
                      ),
                    );
                    if (newLanguage != null) {
                      languageState.value = newLanguage;
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: StyledListView(
                children: [
                  if (matchingEntries.isEmpty)
                    Padding(
                      padding: .all(16),
                      child: StyledTile.message(
                        title: t.emptyStates.noMatchingTerms.toText(),
                        subtitle: t.emptyStates.tryAnotherSearch.toText(),
                        leading: Symbols.search.toIcon(),
                      ),
                    ),
                  ...matchingEntries.map(
                    (strong) => StyledListItem.navigation(
                      title: SingleChildScrollView(
                        scrollDirection: .horizontal,
                        child: Row(
                          spacing: 8,
                          children: [
                            StyledTag.sm(child: strong.id.toText()),
                            Text([strong.languageText, strong.transliteration].join('  ·  ')),
                          ],
                        ),
                      ),
                      subtitle: MarkdownBuilder(strong.definition, maxLines: 2),
                      onPressed: () => StrongSheet.showWithBreadcrumbs(
                        context,
                        strongId: strong.id,
                        onNavigateToVerseSelection: (verseSelection) => context.pop(verseSelection),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
