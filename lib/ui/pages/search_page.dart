import 'package:bible/models/book_type.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/testament.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:substring_highlight/substring_highlight.dart';

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
      titleText: 'Search',
      backgroundColor: context.colors.surfacePrimary,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
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
                  leadingIcon: Symbols.book,
                  trailingIcon: Symbols.keyboard_arrow_down,
                  labelText: locations.isEmpty ? 'Locations' : locations.map((location) => location.title()).join(', '),
                  color: locations.isEmpty ? null : context.colors.contentPrimary,
                  onPressed: () async {
                    final newLocations = await context.showStyledSheet(
                      StyledMultiSelectionSheet<SearchLocationFilter>(
                        titleText: 'Locations',
                        trailingBuilder: locations.isEmpty
                            ? null
                            : (context) => StyledCircleButton.lg(
                                onPressed: () => context.pop(<SearchLocationFilter>[]),
                                icon: Symbols.reset_settings,
                              ),
                        options: [
                          ...Testament.values.map((testament) => TestamentSearchLocationFilter(testament: testament)),
                          ...BookType.values.map((book) => BookSearchLocationFilter(book: book)),
                        ],
                        initialOptions: locations,
                        optionMapper: (option) => StyledSelectOption(titleText: option.title()),
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
                padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
                children: [
                  if (searchState.value.isEmpty)
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: StyledTile.message(
                        titleText: 'Start a search',
                        subtitleText: 'Enter a keyword like light, word, or wisdom, then hit enter on the keyboard.',
                        icon: Symbols.search,
                      ),
                    )
                  else if (searchResults.isEmpty)
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: StyledTile.message(
                        titleText: 'No Search Results Found',
                        subtitleText: 'Try another search',
                        icon: Symbols.search,
                      ),
                    )
                  else
                    ...searchResults.map(
                      (result) => StyledListItem(
                        titleText: result.format(),
                        subtitle: SubstringHighlight(
                          text: bible.getVerseByReference(result)?.text ?? '',
                          term: searchState.value,
                          textStyle: context.textStyle.paragraphSm.subtle(context),
                          textStyleHighlight: context.textStyle.paragraphSm.subtle(context).bold,
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
