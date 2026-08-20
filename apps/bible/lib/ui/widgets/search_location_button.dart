import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class SearchLocationButton extends StatelessWidget {
  final List<SearchLocationFilter> locations;
  final Function(List<SearchLocationFilter>) onLocationsSelected;
  final BookType? currentBook;

  const SearchLocationButton({super.key, required this.locations, required this.onLocationsSelected, this.currentBook});

  @override
  Widget build(BuildContext context) {
    return StyledPillButton.md(
      leading: Symbols.book_6.toIcon(),
      trailing: Symbols.keyboard_arrow_down.toIcon(),
      label:
          (locations.isEmpty
                  ? t.labels.locations
                  : locations
                        .sortedByIndexIn(SearchLocationFilter.values)
                        .map((location) => location.title())
                        .join(', '))
              .toText(),
      colorBuilder: locations.isEmpty ? null : .primary,
      onPressed: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        final newLocations = await context.showStyledSheet(
          (context, _) => StyledMultiSelectionSheet<SearchLocationFilter>(
            title: t.labels.locations.toText(),
            trailing: locations.isEmpty
                ? null
                : StyledCircleButton.md(
                    child: Symbols.delete.toIcon(),
                    onPressed: () => context.pop(<SearchLocationFilter>[]),
                  ),
            optionsByCategory: SearchLocationFilterGroup.values.mapToMap(
              (group) => MapEntry(group.title(), group.getFilters(currentBook: currentBook)),
            ),
            initialOptions: locations,
            optionMapper: (option) => StyledSelectOption(title: option.title().toText()),
            aboveButtonsBuilder: (context, selectedOptions, updateSelectedOptions) => Column(
              children: [
                StyledListItem(
                  title: Text(
                    [
                      t.selectionUi.selected,
                      selectedOptions.isEmpty
                          ? t.common.none
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
                      : StyledLink(t.common.clear, onPressed: () => updateSelectedOptions([])),
                ),
                StyledDivider(height: 2),
              ],
            ),
            searchKeywordsMapper: (option) => option.title().keywords,
            emptySearchTitle: t.emptyStates.noSearchResults.toText(),
            emptySearchSubtitle: t.emptyStates.tryAnotherSearch.toText(),
          ),
        );
        if (newLocations != null) {
          onLocationsSelected(newLocations);
        }
      },
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
  String title() => book.title(isPlural: true);
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
    currentBook => t.searchLocations.currentBook,
    testaments => t.searchLocations.testaments,
    books => t.searchLocations.books,
  };
}
