import 'package:bible/models/book_type.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/testament.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SearchPageResult {
  final Reference? reference;

  const SearchPageResult({required this.reference});
}

class SearchPage extends HookConsumerWidget {
  final String? initialSearch;

  const SearchPage({super.key, this.initialSearch});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final bibles = ref.watch(biblesProvider);

    final bible = user.getBible(bibles);

    final textState = useState(initialSearch ?? '');
    final searchState = useState(textState.value);

    final locationsState = useState(<SearchLocationFilter>[]);
    final locations = locationsState.value;

    List<Reference> getSearchedReferences() {
      final locations = locationsState.value;
      final searchTerms = searchState.value.trim().onlyLetters.toLowerCase().split(' ');
      return searchTerms.isEmpty
          ? <Reference>[]
          : bible.references
                .where((reference) => locations.isEmpty || locations.any((filter) => filter.passes(reference)))
                .where(
                  (reference) =>
                      bible.getVerseByReference(reference)?.searchTerms.containsInOrder(searchTerms) ?? false,
                )
                .toList();
    }

    final searchResultsState = useState(useMemoized(() => getSearchedReferences()));
    final searchResults = searchResultsState.value;

    void search() {
      searchResultsState.value = getSearchedReferences();
    }

    return StyledPage(
      title: 'Search'.toText(),
      backgroundColor: context.colors.surfacePrimary,
      body: Column(
        children: [
          Container(
            padding: .all(16),
            decoration: BoxDecoration(color: context.colors.surfacePrimary, boxShadow: [StyledShadow.down(context)]),
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledTextField(
                  labelText: 'Search',
                  text: textState.value,
                  onChanged: (text) {
                    textState.value = text;
                    searchState.value = '';
                    searchResultsState.value = [];
                  },
                  hintText: 'Search for a word or phrase',
                  onSubmit: (newText) {
                    searchState.value = newText;
                    search();
                  },
                ),
                StyledPillButton(
                  leading: Symbols.book.toIcon(),
                  trailing: Symbols.keyboard_arrow_down.toIcon(),
                  label: (locations.isEmpty ? 'Locations' : locations.map((location) => location.title()).join(', '))
                      .toText(),
                  colorBuilder: locations.isEmpty ? null : .primary,
                  onPressed: () async {
                    final newLocations = await context.showStyledSheet(
                      (context) => StyledMultiSelectionSheet<SearchLocationFilter>(
                        title: 'Locations'.toText(),
                        trailing: locations.isEmpty
                            ? null
                            : StyledCircleButton.lg(
                                onPressed: () => context.pop(<SearchLocationFilter>[]),
                                child: Symbols.reset_settings.toIcon(),
                              ),
                        options: [
                          ...Testament.values.map((testament) => TestamentSearchLocationFilter(testament: testament)),
                          ...BookType.values.map((book) => BookSearchLocationFilter(book: book)),
                        ],
                        initialOptions: locations,
                        optionMapper: (option) => StyledSelectOption(title: option.title().toText()),
                      ),
                    );
                    if (newLocations != null) {
                      locationsState.value = newLocations;
                      search();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: StyledListView(
                padding: .only(bottom: MediaQuery.paddingOf(context).bottom),
                children: [
                  if (searchState.value.isEmpty)
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Padding(
                          padding: .all(16),
                          child: StyledTile.message(
                            titleText: 'Start a search',
                            subtitleText:
                                'Enter a keyword like light, word, or wisdom, then hit enter on the keyboard.',
                            icon: Symbols.search,
                          ),
                        ),
                        if (user.searchHistory.isNotEmpty)
                          StyledSection(
                            title: Text('Recents'),
                            children: user.searchHistory
                                .mapIndexed(
                                  (i, searchResult) => StyledSwipeable(
                                    key: ValueKey(searchResult),
                                    actions: [
                                      StyledSwipeableAction.delete(
                                        onPressed: () => ref.updateUser(
                                          (user) => user.copyWith(searchHistory: user.searchHistory.withRemovedAt(i)),
                                        ),
                                      ),
                                    ],
                                    child: StyledListItem(
                                      leading: Symbols.history.toIcon(),
                                      title: Text(searchResult),
                                      trailing: Symbols.search.toIcon(),
                                      onPressed: () {
                                        textState.value = searchResult;
                                        searchState.value = searchResult;
                                        search();
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                      ],
                    )
                  else if (searchResults.isEmpty)
                    Padding(
                      padding: .all(16),
                      child: StyledTile.message(
                        titleText: 'No Search Results Found',
                        subtitleText: 'Try another search',
                        icon: Symbols.search,
                      ),
                    )
                  else
                    ...searchResults.map(
                      (result) => StyledListItem.navigation(
                        title: result.format().toText(),
                        subtitle: SubstringHighlight(
                          text: bible.getVerseByReference(result)?.text ?? '',
                          term: searchState.value,
                          words: true,
                          textStyle: context.textStyle.paragraphSm.subtle(context),
                          textStyleHighlight: context.textStyle.paragraphSm.subtle(context).bold,
                        ),
                        onPressed: () {
                          ref.updateUser((user) => user.withSearchHistory(searchState.value));
                          context.pop(SearchPageResult(reference: result));
                        },
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

sealed class SearchLocationFilter {
  const SearchLocationFilter();

  bool passes(Reference reference);

  String title();
}

class TestamentSearchLocationFilter extends SearchLocationFilter with EquatableMixin {
  final Testament testament;

  const TestamentSearchLocationFilter({required this.testament});

  @override
  bool passes(Reference reference) => reference.book.testament == testament;

  @override
  List<Object?> get props => [testament];

  @override
  String title() => testament.title();
}

class BookSearchLocationFilter extends SearchLocationFilter with EquatableMixin {
  final BookType book;

  const BookSearchLocationFilter({required this.book});

  @override
  bool passes(Reference reference) => reference.book == book;

  @override
  List<Object?> get props => [book];

  @override
  String title() => book.title();
}
