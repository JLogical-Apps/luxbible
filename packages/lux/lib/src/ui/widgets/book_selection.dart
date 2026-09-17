import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class BookSelectionSheet {
  static Future<Set<BookType>?> show(
    BuildContext context, {
    required Set<BookType> initialBooks,
    required Widget title,
    BookType? currentBook,
    bool includeWholeBible = false,
  }) => context.showStyledSheet((context, _) {
    final selectedBooksState = useState(initialBooks);
    final searchState = useState('');

    return StyledSheet(
      title: title,
      aboveButtons: Column(
        children: [
          BookSelectionSummary(
            selectedBooks: selectedBooksState.value,
            onChanged: (books) => selectedBooksState.value = books,
          ),
          StyledDivider(height: 2),
          Padding(
            padding: .all(16),
            child: StyledTextField(
              text: searchState.value,
              onChanged: (value) => searchState.value = value,
              hintText: t.common.search,
            ),
          ),
        ],
      ),
      children: [
        BookSelectionSections(
          selectedBooks: selectedBooksState.value,
          onChanged: (books) => selectedBooksState.value = books,
          includeWholeBible: includeWholeBible,
          currentBook: currentBook,
          search: searchState.value,
        ),
      ],
      buttonsBuilder: (context) => [
        StyledRectButton.primary(label: t.common.save.toText(), onPressed: () => context.pop(selectedBooksState.value)),
      ],
    );
  });
}

class BookSelectionSections extends StatelessWidget {
  final Set<BookType> selectedBooks;
  final Function(Set<BookType>) onChanged;
  final bool includeWholeBible;
  final BookType? currentBook;
  final String search;

  const BookSelectionSections({
    super.key,
    required this.selectedBooks,
    required this.onChanged,
    this.includeWholeBible = false,
    this.currentBook,
    this.search = '',
  });

  bool isMatching(String title) => search.isEmpty || search.passesSearch(title.keywords);

  Widget getGroupItem(String title, Iterable<BookType> books) => StyledListItem.checkbox(
    title: title.toText(),
    isSelected: selectedBooks.containsAll(books),
    onSelected: (isSelected) => onChanged(selectedBooks.withGroup(books, isSelected: isSelected)),
  );

  @override
  Widget build(BuildContext context) => Column(
    children: [
      if (!Testament.values.any((testament) => isMatching(testament.title())) &&
          !BookType.values.any((book) => isMatching(book.title(isPlural: true))) &&
          !(includeWholeBible && isMatching(t.testaments.wholeBible)))
        Padding(
          padding: .all(16),
          child: StyledTile.message(
            leading: Symbols.search.toIcon(),
            title: t.emptyStates.noSearchResults.toText(),
            subtitle: t.emptyStates.tryAnotherSearch.toText(),
          ),
        ),
      if (includeWholeBible && isMatching(t.testaments.wholeBible))
        StyledSection(
          title: t.testaments.wholeBible.toText(),
          padding: .only(top: 24),
          children: [getGroupItem(t.testaments.wholeBible, BookType.values)],
        ),
      if (currentBook case final currentBook? when isMatching(currentBook.title(isPlural: true)))
        StyledSection(
          title: t.searchLocations.currentBook.toText(),
          padding: .only(top: 24),
          children: [
            getGroupItem(currentBook.title(isPlural: true), [currentBook]),
          ],
        ),
      if (Testament.values.any((testament) => isMatching(testament.title())))
        StyledSection(
          title: t.searchLocations.testaments.toText(),
          padding: .only(top: 24),
          children: Testament.values
              .where((testament) => isMatching(testament.title()))
              .map(
                (testament) =>
                    getGroupItem(testament.title(), BookType.values.where((book) => book.testament == testament)),
              )
              .toList(),
        ),
      if (BookType.values.any((book) => isMatching(book.title(isPlural: true))))
        StyledSection(
          title: t.searchLocations.books.toText(),
          padding: .only(top: 24),
          children: BookType.values
              .where((book) => isMatching(book.title(isPlural: true)))
              .map((book) => getGroupItem(book.title(isPlural: true), [book]))
              .toList(),
        ),
    ],
  );
}

class BookSelectionSummary extends StatelessWidget {
  final Set<BookType> selectedBooks;
  final Function(Set<BookType>) onChanged;

  const BookSelectionSummary({super.key, required this.selectedBooks, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final titles = selectedBooks.selectionTitles;
    return StyledListItem(
      title: Text(
        '${t.selectionUi.selected}${titles.isEmpty ? t.common.none : titles.join(', ')}',
        maxLines: 1,
        overflow: .ellipsis,
      ),
      trailing: selectedBooks.isNotEmpty ? StyledLink(t.common.clear, onPressed: () => onChanged({})) : null,
    );
  }
}

extension BookTypeSetExtensions on Set<BookType> {
  Set<BookType> withGroup(Iterable<BookType> books, {required bool isSelected}) =>
      isSelected ? {...this, ...books} : difference(books.toSet());

  List<String> get selectionTitles {
    if (isEmpty) return [];
    if (containsAll(BookType.values)) return [t.testaments.wholeBible];

    final selectedTestaments = Testament.values.where(
      (testament) => containsAll(BookType.values.where((book) => book.testament == testament)),
    );
    return [
      ...selectedTestaments.map((testament) => testament.title()),
      ...BookType.values
          .where((book) => contains(book) && !selectedTestaments.contains(book.testament))
          .map((book) => book.title(isPlural: true)),
    ];
  }
}
