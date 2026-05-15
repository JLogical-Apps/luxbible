import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/testament.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/strongs_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/sheets/strong_sheet.dart';
import 'package:bible/ui/widgets/verse_text.dart';
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
import 'package:utils_core/utils_core.dart';

class SearchPageResult {
  final Reference reference;

  const SearchPageResult({required this.reference});
}

class SearchPage extends HookConsumerWidget {
  final String? initialSearch;
  final ChapterReference? currentChapterReference;

  const SearchPage({super.key, this.initialSearch, this.currentChapterReference});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final bibles = ref.watch(studyBiblesProvider);

    final bible = user.getStudyBible(bibles);

    final strongs = ref.watch(strongsProvider);

    final textState = useState(initialSearch ?? '');
    final searchState = useState(textState.value);

    final locationsState = useState(<SearchLocationFilter>[]);
    final locations = locationsState.value;

    List<Reference> getSearchedReferences() {
      final locations = locationsState.value;
      final search = searchState.value.trim();

      final validReferences = bible.references
          .where((reference) => locations.isEmpty || locations.any((filter) => filter.passes(reference)))
          .toList();

      if (search.isStrongId) {
        return validReferences
            .where((reference) => bible.getVerseByReference(reference)?.strongIds.contains(search) ?? false)
            .toList();
      }

      final searchTerms = search.onlyLetters.toLowerCase().split(' ');
      return searchTerms.isEmpty
          ? <Reference>[]
          : validReferences
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
              crossAxisAlignment: .start,
              children: [
                StyledTextField(
                  labelText: 'Search',
                  text: textState.value,
                  autofocus: true,
                  onChanged: (text) {
                    textState.value = text;
                    searchState.value = '';
                    searchResultsState.value = [];
                  },
                  hintText: 'Search for a word or phrase',
                  onSubmit: (newText) {
                    textState.value = newText;
                    searchState.value = newText;
                    search();
                  },
                ),
                StyledPillButton(
                  leading: Symbols.book.toIcon(),
                  trailing: Symbols.keyboard_arrow_down.toIcon(),
                  label:
                      (locations.isEmpty
                              ? 'Locations'
                              : locations
                                    .sortedByIndexIn(SearchLocationFilter.values)
                                    .map((location) => location.title())
                                    .join(', '))
                          .toText(),
                  colorBuilder: locations.isEmpty ? null : .primary,
                  onPressed: () async {
                    final newLocations = await context.showStyledSheet(
                      (context) => StyledMultiSelectionSheet<SearchLocationFilter>(
                        title: 'Locations'.toText(),
                        optionsByCategory: SearchLocationFilterGroup.values.mapToMap(
                          (group) =>
                              MapEntry(group.title(), group.getFilters(currentBook: currentChapterReference?.book)),
                        ),
                        initialOptions: locations,
                        optionMapper: (option) => StyledSelectOption(title: option.title().toText()),
                        aboveButtonsBuilder: (context, selectedOptions, updateSelectedOptions) => Column(
                          children: [
                            StyledListItem(
                              title: Text(
                                [
                                  'Selected: ',
                                  selectedOptions.isEmpty
                                      ? 'None'
                                      : selectedOptions
                                            .sortedByIndexIn(SearchLocationFilter.values)
                                            .map((option) => option.title())
                                            .join(', '),
                                ].join(),
                                maxLines: 1,
                                overflow: .ellipsis,
                              ),
                              trailing: selectedOptions.isEmpty
                                  ? null
                                  : StyledLink('Clear', onPressed: () => updateSelectedOptions([])),
                            ),
                            StyledDivider(height: 2),
                          ],
                        ),
                        searchKeywordsMapper: (option) => option.title().keywords,
                      ),
                    );
                    if (newLocations != null) {
                      locationsState.value = newLocations;
                      searchState.value = textState.value;
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
                            title: 'Start a search'.toText(),
                            subtitle: 'Enter a keyword like light, word, or wisdom, then hit enter on the keyboard.'
                                .toText(),
                            leading: Symbols.search.toIcon(),
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
                        title: 'No Search Results Found'.toText(),
                        subtitle: 'Try another search'.toText(),
                        leading: Symbols.search.toIcon(),
                      ),
                    )
                  else ...[
                    if (searchState.value.isStrongId)
                      if (strongs[searchState.value] case final strong?)
                        Padding(
                          padding: .all(16),
                          child: StyledTile(
                            child: StyledListItem.navigation(
                              title: Row(
                                spacing: 8,
                                children: [
                                  StyledBadge(text: strong.id),
                                  Text([strong.languageText, strong.transliteration].join('  ·  ')),
                                ],
                              ),
                              subtitle: strong.definition.toText(),
                              onPressed: () => StrongSheet.showWithContext(context, ref, strongId: strong.id),
                            ),
                          ),
                        ),
                    ...searchResults.map((result) {
                      final verse = bible.getVerseByReference(result);
                      if (verse == null) {
                        return null;
                      }

                      return StyledListItem(
                        title: result.format().toText(),
                        subtitle: searchState.value.trim().isStrongId
                            ? VerseText(verse: verse, highlightStrongId: searchState.value.trim())
                            : SubstringHighlight(
                                text: bible.getVerseByReference(result)?.text ?? '',
                                term: searchState.value,
                                words: true,
                                textStyle: context.textStyle.paragraphSm.subtle(context),
                                textStyleHighlight: context.textStyle.paragraphSm.subtle(context).bold,
                              ),
                        trailing: Symbols.expand_circle_right.toIcon(),
                        onPressed: () {
                          ref.updateUser((user) => user.withSearchHistory(searchState.value));
                          context.pop(SearchPageResult(reference: result));
                        },
                      );
                    }).nonNulls,
                  ],
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

  static List<SearchLocationFilter> get values => [
    ...Testament.values.map((testament) => TestamentSearchLocationFilter(testament: testament)),
    ...BookType.values.map((book) => BookSearchLocationFilter(book: book)),
  ];

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

enum SearchLocationFilterGroup {
  currentBook,
  testaments,
  books;

  List<SearchLocationFilter> getFilters({required BookType? currentBook}) => switch (this) {
    .currentBook => [if (currentBook != null) BookSearchLocationFilter(book: currentBook)],
    testaments => Testament.values.map((testament) => TestamentSearchLocationFilter(testament: testament)).toList(),
    books => BookType.values.map((book) => BookSearchLocationFilter(book: book)).toList(),
  };

  String title() => switch (this) {
    currentBook => 'Current Book',
    testaments => 'Testaments',
    books => 'Books',
  };
}
