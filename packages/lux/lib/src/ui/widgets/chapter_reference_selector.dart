import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class ChapterReferenceSelector extends HookWidget {
  final ChapterReference? initialReference;
  final ChapterReferenceSelectorController? controller;
  final Function(ChapterPosition, bool shouldSelectVerse) onSelect;

  final Widget? trailing;
  final List<Widget> Function(BuildContext, Function(ChapterPosition) onSelect)? aboveBooksBuilder;

  const ChapterReferenceSelector({
    super.key,
    required this.onSelect,
    this.initialReference,
    this.controller,
    this.trailing,
    this.aboveBooksBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final controller = this.controller ?? useChapterReferenceSelectorController(initialReference: initialReference);
    return Column(
      children: [
        ChapterReferenceSelectorHeading(controller: controller, onSelect: onSelect, trailing: trailing),
        Expanded(
          child: ListView(
            controller: controller.scrollController,
            children: [
              ChapterReferenceSelectorBody(
                controller: controller,
                onSelect: onSelect,
                aboveBooksBuilder: aboveBooksBuilder,
              ),
              Builder(builder: (context) => SizedBox(height: MediaQuery.viewInsetsOf(context).bottom)),
            ],
          ),
        ),
      ],
    );
  }
}

class ChapterReferenceSelectorHeading extends HookWidget {
  final ChapterReferenceSelectorController controller;
  final Function(ChapterPosition, bool shouldSelectVerse) onSelect;

  final Widget? trailing;
  final bool showShadow;

  const ChapterReferenceSelectorHeading({
    super.key,
    required this.controller,
    required this.onSelect,
    this.trailing,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    useListenable(controller.bookTextState);
    useListenable(controller.chapterNumState);
    useListenable(controller.verseNumState);
    useListenable(controller.isShowingVersesState);
    useListenable(controller.isScrollingDownState);
    useOnListenableChange(controller.bookFocusNode, () {
      final book = controller.book;
      if (controller.bookFocusNode.hasPrimaryFocus) {
        controller.showBooks();
      } else if (book != null) {
        controller.setBookText(book.title(isPlural: true).titleCase);
      }
    });
    useOnFocusNodeFocused(controller.chapterFocusNode, controller.showChapters);
    useOnFocusNodeFocused(controller.bookFocusNode, controller.hideVerses);
    useOnFocusNodeFocused(controller.chapterFocusNode, controller.hideVerses);

    final book = controller.book;

    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [if (showShadow) StyledShadow.down(context)],
        color: context.colors.surfacePrimary,
      ),
      child: Padding(
        padding: EdgeInsets.all(16).copyWith(top: 0),
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: Stack(
                children: [
                  StyledTextField(
                    text: controller.bookText,
                    readOnly: !controller.isScrollingDown,
                    onChanged: controller.setBookText,
                    onRawTextChanged: (oldText, newText) {
                      if (newText == '$oldText ' && controller.getBook(text: oldText) != null) {
                        controller.showChapters();
                        controller.chapterFocusNode.requestFocus();
                        return false;
                      }
                      return true;
                    },
                    onTextEditValueChanged: (value) => controller.setBookTextSelection(value.selection),
                    autofocus: true,
                    suggestedText: book?.title(isPlural: true),
                    hintText: t.navigation.book,
                    autocorrect: false,
                    textStyle: context.textStyle.paragraphLg,
                    textCapitalization: .words,
                    action: .next,
                    textInputType: .text,
                    focusNode: controller.bookFocusNode,
                  ),
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: .translucent,
                      onTap: !controller.isScrollingDown ? () => controller.setIsScrollingDown(true) : null,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 60,
              child: StyledTextField(
                text: controller.chapterNum?.toString() ?? '',
                onChanged: book == null ? null : (text) => controller.setChapterNum(int.tryParse(text)),
                onRawTextChanged: (oldText, newText) {
                  if (newText == '$oldText ' && controller.chapterNum != null) {
                    controller.showVerses();
                    controller.verseFocusNode.requestFocus();
                    return false;
                  }
                  return true;
                },
                hintText: t.navigation.chapter,
                textStyle: context.textStyle.paragraphLg,
                textInputType: .numberWithOptions(signed: true),
                focusNode: controller.chapterFocusNode,
                onSubmit: (text) {
                  final chapterNum = int.tryParse(text);
                  if (book != null && chapterNum != null) {
                    onSelect(
                      ChapterPosition(
                        reference: ChapterReference(book: book, chapterNum: chapterNum),
                      ),
                      false,
                    );
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  if (book != null) RangeTextInputFormatter(min: 1, max: book.bookInfo.numChapters),
                ],
              ),
            ),
            if ((book, controller.chapterNum) case (final book?, final chapterNum?) when controller.isShowingVerses)
              SizedBox(
                width: 112,
                child: StyledTextField(
                  text: controller.verseNum?.toString() ?? '',
                  onChanged: (text) => controller.setVerseNum(int.tryParse(text)),
                  hintText: t.navigation.verse,
                  textStyle: context.textStyle.paragraphLg,
                  textInputType: .numberWithOptions(signed: true),
                  focusNode: controller.verseFocusNode,
                  onSubmit: (text) {
                    final verseNum = int.tryParse(text);
                    if (verseNum != null) {
                      onSelect(
                        ChapterPosition(
                          reference: ChapterReference(book: book, chapterNum: chapterNum),
                          verseNum: verseNum,
                        ),
                        true,
                      );
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    RangeTextInputFormatter(min: 1, max: book.bookInfo.getNumVerses(chapterNum)),
                  ],
                ),
              )
            else
              ?trailing,
          ],
        ),
      ),
    );
  }
}

class ChapterReferenceSelectorBody extends HookWidget {
  final ChapterReferenceSelectorController controller;
  final Function(ChapterPosition, bool shouldSelectVerse) onSelect;
  final List<Widget> Function(BuildContext, Function(ChapterPosition) onSelect)? aboveBooksBuilder;

  const ChapterReferenceSelectorBody({
    super.key,
    required this.controller,
    required this.onSelect,
    this.aboveBooksBuilder,
  });

  void select(ChapterPosition position) {
    controller.chapterNumState.value = position.reference.chapterNum;
    onSelect(position, false);
  }

  @override
  Widget build(BuildContext context) {
    useListenable(controller.bookTextState);
    useListenable(controller.bookTextSelectionState);
    useListenable(controller.chapterNumState);
    useListenable(controller.verseNumState);
    useListenable(controller.isShowingChaptersState);
    useListenable(controller.isShowingVersesState);
    useOnStickyScrollDirectionChanged(
      controller.scrollController,
      (direction) => controller.setIsScrollingDown(direction == ScrollDirection.forward),
    );

    final book = controller.book;
    final matchingBooks = controller.matchingBooks();

    if ((book, controller.chapterNum) case (final book?, final chapterNum?) when controller.isShowingVerses) {
      final chapterReference = ChapterReference(book: book, chapterNum: chapterNum);
      return StyledList(
        key: ValueKey(Reference),
        children: chapterReference.references
            .where(
              (reference) =>
                  controller.verseNum == null ||
                  reference.verseNum.toString().startsWith(controller.verseNum.toString()),
            )
            .map(
              (reference) => StyledListItem(
                title: reference.format().toText(),
                trailing: Symbols.expand_circle_right.toIcon(),
                onPressed: () =>
                    onSelect(ChapterPosition(reference: chapterReference, verseNum: reference.verseNum), true),
              ),
            )
            .toList(),
      );
    }

    if (controller.isShowingChapters && book != null) {
      return StyledList(
        key: ValueKey(ChapterReference),
        children:
            List.generate(
                  book.bookInfo.numChapters,
                  (chapterIndex) => ChapterReference(book: book, chapterNum: chapterIndex + 1),
                )
                .where(
                  (chapterReference) =>
                      controller.chapterNum == null ||
                      chapterReference.chapterNum.toString().startsWith(controller.chapterNum.toString()),
                )
                .map(
                  (chapterReference) => StyledListItem(
                    title: chapterReference.format().toText(),
                    trailing: Symbols.expand_circle_right.toIcon(),
                    onPressed: () => select(ChapterPosition(reference: chapterReference)),
                  ),
                )
                .toList(),
      );
    }

    return Column(
      key: ValueKey(BookType),
      crossAxisAlignment: .start,
      children: [
        if (matchingBooks.isNotEmpty && (controller.isBookFullySelected || controller.bookText.isEmpty))
          ...?aboveBooksBuilder?.call(context, select),
        if (matchingBooks.isEmpty)
          Padding(
            padding: .all(16),
            child: StyledBanner(message: t.common.noMatches.toText()),
          )
        else
          ...StyledSection(
            title: t.labels.books.toText(),
            padding: .only(top: 24),
            children: (controller.isBookFullySelected ? BookType.values : matchingBooks)
                .map(
                  (book) => StyledListItem(
                    title: book.title(isPlural: true).toText(),
                    trailing: Symbols.chevron_right.toIcon(),
                    onPressed: () {
                      controller.setBookText(book.title(isPlural: true));
                      WidgetsBinding.instance.addPostFrameCallback((_) => controller.chapterFocusNode.requestFocus());
                    },
                  ),
                )
                .toList(),
          ).buildChildren(context),
      ],
    );
  }
}

class ChapterReferenceSelectorController {
  final ValueNotifier<String> bookTextState;
  final ValueNotifier<TextSelection> bookTextSelectionState;
  final ValueNotifier<int?> chapterNumState;
  final ValueNotifier<int?> verseNumState;
  final ValueNotifier<bool> isShowingChaptersState;
  final ValueNotifier<bool> isShowingVersesState;
  final ValueNotifier<bool> isScrollingDownState;

  final FocusNode bookFocusNode;
  final FocusNode chapterFocusNode;
  final FocusNode verseFocusNode;
  final ScrollController scrollController;

  ChapterReferenceSelectorController({
    required this.bookTextState,
    required this.bookTextSelectionState,
    required this.chapterNumState,
    required this.verseNumState,
    required this.isShowingChaptersState,
    required this.isShowingVersesState,
    required this.isScrollingDownState,
    required this.bookFocusNode,
    required this.chapterFocusNode,
    required this.verseFocusNode,
    required this.scrollController,
  });

  String get bookText => bookTextState.value;

  TextSelection get bookTextSelection => bookTextSelectionState.value;

  int? get chapterNum => chapterNumState.value;

  int? get verseNum => verseNumState.value;

  bool get isScrollingDown => isScrollingDownState.value;

  List<BookType> matchingBooks({String? text, bool onlyEqual = false}) => BookType.values
      .where(
        (book) => onlyEqual
            ? ((text ?? bookText).toLowerCase() == book.title(isPlural: true).toLowerCase())
            : (text ?? bookText).passesSearch(book.title(isPlural: true).keywords, similarityLimit: null),
      )
      .toList();

  BookType? getBook({String? text}) =>
      matchingBooks(text: text, onlyEqual: true).singleOrNull ?? matchingBooks(text: text).singleOrNull;

  BookType? get book => getBook();

  bool get isBookFullySelected =>
      bookTextSelection.baseOffset == 0 && bookTextSelection.extentOffset == bookText.length;

  bool get isShowingChapters => isShowingChaptersState.value;

  bool get isShowingVerses => isShowingVersesState.value;

  void setBookText(String text) {
    final previousBook = book;
    bookTextState.value = text;
    if (book != previousBook) {
      chapterNumState.value = null;
    }
  }

  void setBookTextSelection(TextSelection selection) => bookTextSelectionState.value = selection;

  void setChapterNum(int? value) => chapterNumState.value = value;

  void setVerseNum(int? value) => verseNumState.value = value;

  void showBooks() => isShowingChaptersState.value = false;

  void showChapters() => isShowingChaptersState.value = true;

  void showVerses() {
    if (book != null && chapterNum != null) {
      isShowingVersesState.value = true;
      verseNumState.value = null;
    }
  }

  void hideVerses() => isShowingVersesState.value = false;

  void setIsScrollingDown(bool value) => isScrollingDownState.value = value;
}

ChapterReferenceSelectorController useChapterReferenceSelectorController({ChapterReference? initialReference}) {
  final bookText = initialReference?.book.title(isPlural: true) ?? '';
  return ChapterReferenceSelectorController(
    bookTextState: useState(bookText),
    bookTextSelectionState: useState(TextSelection(baseOffset: 0, extentOffset: bookText.length)),
    chapterNumState: useState(initialReference?.chapterNum),
    verseNumState: useState(null),
    isShowingChaptersState: useState(false),
    isShowingVersesState: useState(false),
    isScrollingDownState: useState(true),
    bookFocusNode: useFocusNode(),
    chapterFocusNode: useFocusNode(),
    verseFocusNode: useFocusNode(),
    scrollController: useScrollController(),
  );
}
