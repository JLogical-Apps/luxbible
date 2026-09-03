import 'package:bible/providers/dictionary_provider.dart';
import 'package:bible/ui/sheets/dictionary_sheet.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class DictionaryPage extends HookConsumerWidget implements StyledRoute<VerseSelection> {
  const DictionaryPage({super.key});

  @override
  String get path => '/dictionary';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dictionary = ref.watch(dictionaryProvider);
    final entries = useMemoized(() => dictionary.values.sortedBy((a) => a.title.toUpperCase()), [dictionary]);

    final searchState = useState('');
    final search = searchState.value.trim().toUpperCase();

    final matchingEntries = search.isEmpty
        ? entries
        : entries.where((entry) => entry.title.toUpperCase().startsWith(search)).toList();

    return StyledPage(
      title: t.labels.dictionary.toText(),
      body: Column(
        children: [
          Container(
            padding: MediaQuery.viewPaddingOf(context).onlyHorizontal + .all(16),
            decoration: BoxDecoration(color: context.colors.surfacePrimary, boxShadow: [StyledShadow.down(context)]),
            child: StyledTextField(
              text: searchState.value,
              hintText: t.searchUi.wordHint,
              onChanged: (text) => searchState.value = text,
              autocorrect: false,
            ),
          ),
          Expanded(
            child: StyledScrollbar(
              child: StyledListView(
                padding: .only(bottom: MediaQuery.paddingOf(context).bottom + MediaQuery.viewInsetsOf(context).bottom),
                children: [
                  if (matchingEntries.isEmpty)
                    SafeArea(
                      top: false,
                      bottom: false,
                      child: Padding(
                        padding: .all(16),
                        child: StyledTile.message(
                          title: t.emptyStates.noMatchingWords.toText(),
                          subtitle: t.emptyStates.tryAnotherSearch.toText(),
                          leading: Symbols.search.toIcon(),
                        ),
                      ),
                    ),
                  ...matchingEntries.map(
                    (entry) => StyledListItem.navigation(
                      title: entry.title.toText(),
                      subtitle: MarkdownBuilder(entry.definitions.first.withCollapsedWhitespace, maxLines: 2),
                      onPressed: () => DictionarySheet.show(
                        context,
                        entry: entry,
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
