import 'package:bible/providers/dictionary_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/sheets/dictionary_sheet.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class DictionaryPage extends HookConsumerWidget {
  const DictionaryPage({super.key});

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
      title: 'Dictionary'.toText(),
      body: Column(
        children: [
          Container(
            padding: .all(16),
            decoration: BoxDecoration(color: context.colors.surfacePrimary, boxShadow: [StyledShadow.down(context)]),
            child: StyledTextField(
              text: searchState.value,
              hintText: 'Search for a word',
              onChanged: (text) => searchState.value = text,
              autocorrect: false,
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
                        title: 'No matching words'.toText(),
                        subtitle: 'Try another search'.toText(),
                        leading: Symbols.search.toIcon(),
                      ),
                    ),
                  ...matchingEntries.map(
                    (entry) => StyledListItem.navigation(
                      title: entry.title.toText(),
                      subtitle: Text(entry.definition, maxLines: 2, overflow: .ellipsis),
                      onPressed: () => DictionarySheet.show(context, entry: entry),
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
