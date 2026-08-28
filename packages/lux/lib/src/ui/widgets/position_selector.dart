import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:lux/src/ui/widgets/text_edit_value_extensions.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class PositionSelector extends HookWidget {
  final ChapterReference? initialReference;
  final Function(PositionResult) onSelect;
  final bool forceVerseNum;

  final Widget? trailing;
  final List<Widget> Function(BuildContext, Function(ChapterPosition) onSelect)? aboveBooksBuilder;

  const PositionSelector({
    super.key,
    required this.onSelect,
    this.initialReference,
    this.forceVerseNum = false,
    this.trailing,
    this.aboveBooksBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final initialReference = this.initialReference;
    final selectorState = useState<SelectorState>(
      initialReference == null ? SelectorState(focus: .book) : .chapter(initialReference, focus: .book),
    );

    final scrollController = useScrollController();
    final isScrollingDownState = useState(true);
    useOnStickyScrollDirectionChanged(
      scrollController,
      (direction) => isScrollingDownState.value = direction == .forward,
    );

    return Column(
      children: [
        PositionSelectorHeading(
          selectorState: selectorState,
          onSelect: onSelect,
          trailing: trailing,
          readOnly: !isScrollingDownState.value,
          forceVerseNum: forceVerseNum,
        ),
        Expanded(
          child: ListView(
            controller: scrollController,
            children: [
              PositionSelectorBody(
                selectorState: selectorState,
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

class PositionSelectorHeading extends HookWidget {
  final ValueNotifier<SelectorState> selectorState;

  final Function(PositionResult) onSelect;

  final bool forceVerseNum;

  final Widget? trailing;
  final bool readOnly;

  final Color? color;
  final bool showShadow;

  SelectorState get state => selectorState.value;

  const PositionSelectorHeading({
    super.key,
    required this.selectorState,
    required this.onSelect,
    this.trailing,
    this.forceVerseNum = false,
    this.readOnly = false,
    this.color,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final bookFocusNode = useFocusNode();
    final chapterFocusNode = useFocusNode();
    final verseFocusNode = useFocusNode();

    final SelectorState(:book, :chapterNum, :verseText) = state;

    useOnListenableChange(
      bookFocusNode,
      () => selectorState.value = state.copyWith(
        bookText: state.book?.title(isPlural: true),
        chapterNum: state.chapterNum,
        verseText: state.verseText,
        focus: bookFocusNode.hasPrimaryFocus ? .book : null,
      ),
    );

    useOnFocusNodeFocused(chapterFocusNode, () => selectorState.value = state.withFocus(.chapter));
    useOnFocusNodeFocused(verseFocusNode, () => selectorState.value = state.withFocus(.verse));

    usePostFrameEffect(() {
      final focusNode = (switch (state.focus) {
        .book => bookFocusNode,
        .chapter => chapterFocusNode,
        .verse => verseFocusNode,
      });
      focusNode.requestFocus();
    }, [state.focus]);

    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [if (showShadow) StyledShadow.down(context)],
        color: color ?? context.colors.surfacePrimary,
      ),
      child: Padding(
        padding: EdgeInsets.all(16).copyWith(top: 0),
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: StyledTextField(
                text: state.bookText,
                readOnly: readOnly,
                onRawTextChanged: (oldText, newText) {
                  if (newText.endsWith(' ') && state.getBook(text: oldText) != null) {
                    selectorState.value = state.withFocus(.chapter);
                    return false;
                  }
                  return true;
                },
                onChanged: (value) => selectorState.value = state.withBookText(value),
                onTextEditValueChanged: (value) => selectorState.value = state.withBookSelected(value.isFullySelected),
                suggestedText: book?.title(isPlural: true),
                hintText: t.navigation.book,
                textStyle: context.textStyle.paragraphLg,
                textCapitalization: .words,
                autocorrect: false,
                action: .next,
                textInputType: .text,
                focusNode: bookFocusNode,
              ),
            ),
            SizedBox(
              width: 60,
              child: StyledTextField(
                text: chapterNum?.toString() ?? '',
                readOnly: readOnly,
                onChanged: state.book == null
                    ? null
                    : (text) => selectorState.value = state.withChapterNum(int.tryParse(text)),
                onRawTextChanged: (oldText, newText) {
                  if (newText == '$oldText ' && chapterNum != null) {
                    selectorState.value = state.withFocus(.verse);
                    return false;
                  }
                  return true;
                },
                hintText: t.navigation.chapter,
                textStyle: context.textStyle.paragraphLg,
                textInputType: .numberWithOptions(signed: true),
                focusNode: chapterFocusNode,
                action: forceVerseNum ? .next : .done,
                onSubmit: forceVerseNum
                    ? null
                    : (text) {
                        final chapterNum = int.tryParse(text);
                        if (book != null && chapterNum != null) {
                          onSelect(
                            ChapterPositionResult(
                              position: ChapterPosition(
                                reference: ChapterReference(book: book, chapterNum: chapterNum),
                              ),
                            ),
                          );
                        }
                      },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  if (book != null) RangeTextInputFormatter(min: 1, max: book.bookInfo.numChapters),
                ],
              ),
            ),
            if (trailing == null || state.focus == .verse)
              SizedBox(
                width: 112,
                child: StyledTextField(
                  text: verseText,
                  readOnly: readOnly,
                  onChanged: book == null || chapterNum == null
                      ? null
                      : (text) => selectorState.value = state.withVerseText(text),
                  hintText: t.navigation.verse,
                  textStyle: context.textStyle.paragraphLg,
                  action: .done,
                  textInputType: .numberWithOptions(signed: true),
                  focusNode: verseFocusNode,
                  onSubmit: (text) {
                    if (state.verseSpan case final selection?) {
                      onSelect(PassagePositionResult(selection: selection));
                    }
                  },
                  inputFormatters: [
                    if (book != null && chapterNum != null)
                      VerseRangeTextInputFormatter(max: book.bookInfo.getNumVerses(chapterNum)),
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

class PositionSelectorBody extends HookWidget {
  final ValueNotifier<SelectorState> selectorState;

  final Function(PositionResult) onSelect;
  final List<Widget> Function(BuildContext, Function(ChapterPosition) onSelect)? aboveBooksBuilder;
  final bool forceVerseNum;

  const PositionSelectorBody({
    super.key,
    required this.selectorState,
    required this.onSelect,
    this.aboveBooksBuilder,
    this.forceVerseNum = false,
  });

  @override
  Widget build(BuildContext context) {
    final state = selectorState.value;
    final SelectorState(:bookText, :book, :chapterNum, :chapterReference, :verseNum) = state;
    final matchingBooks = state.getMatchingBooks();

    void select(ChapterPosition position) {
      selectorState.value = .chapter(position.reference, focus: .chapter);
      onSelect(ChapterPositionResult(position: position));
    }

    return switch (state.focus) {
      .book => Column(
        key: ValueKey(BookType),
        crossAxisAlignment: .start,
        children: [
          if (matchingBooks.isNotEmpty && (state.isBookFullySelected || state.bookText.isEmpty))
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
              children: (state.isBookFullySelected ? BookType.values : matchingBooks)
                  .map(
                    (book) => StyledListItem(
                      title: book.title(isPlural: true).toText(),
                      trailing: Symbols.chevron_right.toIcon(),
                      onPressed: () => selectorState.value = .book(book, focus: .chapter),
                    ),
                  )
                  .toList(),
            ).buildChildren(context),
        ],
      ),
      .chapter =>
        book == null
            ? SizedBox.shrink()
            : StyledList(
                key: ValueKey(ChapterReference),
                children:
                    List.generate(
                          book.bookInfo.numChapters,
                          (chapterIndex) => ChapterReference(book: book, chapterNum: chapterIndex + 1),
                        )
                        .where(
                          (chapterReference) =>
                              chapterNum == null ||
                              chapterReference.chapterNum.toString().startsWith(chapterNum.toString()),
                        )
                        .map(
                          (chapterReference) => StyledListItem(
                            title: chapterReference.format().toText(),
                            trailing: forceVerseNum
                                ? Symbols.chevron_right.toIcon()
                                : Symbols.expand_circle_right.toIcon(),
                            onPressed: () {
                              if (forceVerseNum) {
                                selectorState.value = .chapter(chapterReference, focus: .verse);
                              } else {
                                select(ChapterPosition(reference: chapterReference));
                              }
                            },
                          ),
                        )
                        .toList(),
              ),
      .verse =>
        chapterReference == null
            ? SizedBox.shrink()
            : StyledList(
                key: ValueKey(Reference),
                children: chapterReference.references
                    .where(
                      (reference) => verseNum == null || reference.verseNum.toString().startsWith(verseNum.toString()),
                    )
                    .map(
                      (reference) => StyledListItem(
                        title: reference.format().toText(),
                        trailing: Symbols.expand_circle_right.toIcon(),
                        onPressed: () {
                          selectorState.value = .verse(reference);
                          onSelect(
                            PassagePositionResult(
                              selection: VerseSpanReference(start: VerseBiblePointer(reference: reference)),
                            ),
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
    };
  }
}

class SelectorState {
  final String bookText;
  final bool isBookFullySelected;

  final int? chapterNum;
  final String verseText;
  final PositionSelectorFocus focus;

  const SelectorState({
    this.bookText = '',
    this.isBookFullySelected = false,
    this.chapterNum,
    this.verseText = '',
    required this.focus,
  });

  SelectorState.book(BookType book, {required PositionSelectorFocus focus})
    : this(bookText: book.title(isPlural: true), focus: focus);

  SelectorState.chapter(ChapterReference chapterReference, {required PositionSelectorFocus focus})
    : this(
        bookText: chapterReference.book.title(isPlural: true),
        chapterNum: chapterReference.chapterNum,
        focus: focus,
      );

  SelectorState.verse(Reference reference)
    : this(
        bookText: reference.book.title(isPlural: true),
        chapterNum: reference.chapterNum,
        verseText: reference.verseNum.toString(),
        focus: .verse,
      );

  List<BookType> getMatchingBooks({String? text, bool onlyEqual = false}) => BookType.values
      .where(
        (book) => onlyEqual
            ? ((text ?? bookText).toLowerCase() == book.title(isPlural: true).toLowerCase())
            : (text ?? bookText).passesSearch(book.title(isPlural: true).keywords, similarityLimit: null),
      )
      .toList();

  BookType? getBook({String? text}) =>
      getMatchingBooks(text: text, onlyEqual: true).singleOrNull ?? getMatchingBooks(text: text).singleOrNull;

  BookType? get book => getBook(text: bookText);

  ChapterReference? get chapterReference {
    final book = this.book;
    final chapterNum = this.chapterNum;
    return book == null || chapterNum == null ? null : ChapterReference(book: book, chapterNum: chapterNum);
  }

  SelectorState withBookText(String bookText) =>
      bookText == this.bookText ? this : copyWith(bookText: bookText, chapterNum: null, verseText: '');

  SelectorState withBookSelected(bool isFullySelected) =>
      copyWith(isBookFullySelected: isFullySelected, chapterNum: chapterNum, verseText: verseText);

  SelectorState withChapterNum(int? chapterNum) => copyWith(chapterNum: chapterNum, verseText: '');

  SelectorState withVerseText(String verseText) => copyWith(chapterNum: chapterNum, verseText: verseText);

  SelectorState withFocus(PositionSelectorFocus focus) =>
      copyWith(chapterNum: chapterNum, verseText: verseText, focus: focus);

  SelectorState copyWith({
    String? bookText,
    bool? isBookFullySelected,
    required int? chapterNum,
    required String verseText,
    PositionSelectorFocus? focus,
  }) => SelectorState(
    bookText: bookText ?? this.bookText,
    isBookFullySelected: isBookFullySelected ?? this.isBookFullySelected,
    chapterNum: chapterNum,
    verseText: verseText,
    focus: focus ?? this.focus,
  );

  int? get verseNum => int.tryParse(verseText.split('-').first);

  VerseSpanReference? get verseSpan {
    final chapterReference = this.chapterReference;
    final parts = verseText.split('-').map(int.tryParse).toList();
    if (chapterReference == null || ![1, 2].contains(parts.length) || parts.any((part) => part == null)) {
      return null;
    }

    final startVerseNum = parts.first!;
    final endVerseNum = parts.length == 1 ? startVerseNum : parts.last!;
    if (startVerseNum < 1 || startVerseNum > endVerseNum || endVerseNum > chapterReference.numVerses) {
      return null;
    }

    final start = VerseBiblePointer(reference: chapterReference.getReference(startVerseNum));
    final end = VerseBiblePointer(reference: chapterReference.getReference(endVerseNum));
    return VerseSpanReference(start: start, end: start == end ? null : end);
  }
}

enum PositionSelectorFocus { book, chapter, verse }

sealed class PositionResult {
  const PositionResult();
}

class ChapterPositionResult extends PositionResult {
  final ChapterPosition position;

  const ChapterPositionResult({required this.position});
}

class PassagePositionResult extends PositionResult {
  final VerseSpanReference selection;

  const PassagePositionResult({required this.selection});
}
