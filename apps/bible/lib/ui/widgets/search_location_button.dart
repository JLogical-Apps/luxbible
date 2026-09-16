import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class SearchLocationButton extends StatelessWidget {
  final Set<BookType> selectedBooks;
  final Function(Set<BookType>) onBooksSelected;
  final BookType? currentBook;

  const SearchLocationButton({super.key, required this.selectedBooks, required this.onBooksSelected, this.currentBook});

  @override
  Widget build(BuildContext context) {
    return StyledPillButton.md(
      leading: Symbols.book_6.toIcon(),
      trailing: Symbols.keyboard_arrow_down.toIcon(),
      label: (selectedBooks.isEmpty ? t.labels.locations : selectedBooks.selectionTitles.join(', ').withLength(24))
          .toText(),
      colorBuilder: selectedBooks.isEmpty ? null : .primary,
      onPressed: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        final newBooks = await BookSelectionSheet.show(
          context,
          title: t.labels.locations.toText(),
          initialBooks: selectedBooks,
          currentBook: currentBook,
        );
        if (newBooks != null) {
          onBooksSelected(newBooks);
        }
      },
    );
  }
}
