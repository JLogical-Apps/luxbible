import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/book_type.dart';
import 'package:bible/models/reference/chapter_position.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/pages/bibles_page.dart';
import 'package:bible/ui/widgets/bible_tile.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:bible/utils/extensions/string_extensions.dart';
import 'package:bible/utils/hook_utils.dart';
import 'package:bible/utils/input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:utils_core/utils_core.dart';

class ChapterReferenceSearchPageResult {
  final ChapterPosition position;
  final String? bookmarkId;

  const ChapterReferenceSearchPageResult({required this.position, this.bookmarkId});
}

class ChapterReferenceSearchPage extends HookConsumerWidget {
  final ChapterReference initialReference;

  const ChapterReferenceSearchPage({super.key, required this.initialReference});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    final bookTextState = useState(initialReference.book.title());
    final bookTextSelectionState = useState<TextSelection>(
      TextSelection(baseOffset: 0, extentOffset: bookTextState.value.length),
    );
    final isBookFullySelected =
        bookTextSelectionState.value.baseOffset == 0 &&
        bookTextSelectionState.value.extentOffset == bookTextState.value.length;

    final chapterNumState = useState<int?>(initialReference.chapterNum);

    final bookFocusNode = useListenable(useFocusNode());
    final chapterFocusNode = useListenable(useFocusNode());
    final viewModeState = useState(_ViewMode.book);

    List<BookType> getMatchingBooks({String? text, bool onlyEqual = false}) => BookType.values
        .where(
          (book) => onlyEqual
              ? ((text ?? bookTextState.value).toLowerCase() == book.title().toLowerCase())
              : (text ?? bookTextState.value).passesSearch(book.title().keywords, similarityLimit: null),
        )
        .toList();
    BookType? getBook({String? text}) =>
        getMatchingBooks(text: text, onlyEqual: true).singleOrNull ?? getMatchingBooks(text: text).singleOrNull;

    final book = getBook();
    final previousBook = usePrevious(book);

    final isFirstFrame = useIsFirstFrame();
    usePostFrameEffect(() {
      if (book != previousBook && !isFirstFrame) {
        chapterNumState.value = null;
      }
      return null;
    }, [book, previousBook]);

    useOnListenableChange(bookFocusNode, () {
      final book = getBook();
      if (bookFocusNode.hasPrimaryFocus) {
        viewModeState.value = _ViewMode.book;
      }

      if (!bookFocusNode.hasPrimaryFocus && book != null) {
        bookTextState.value = book.title().titleCase;
      }
    });

    useOnFocusNodeFocused(chapterFocusNode, () => viewModeState.value = _ViewMode.chapter);

    final scrollController = useScrollController();
    final isScrollingDownState = useState(true);
    useOnStickyScrollDirectionChanged(
      scrollController,
      (direction) => isScrollingDownState.value = direction == ScrollDirection.forward,
    );

    final recents = user.viewHistory.where((position) => position.reference != initialReference).toList();

    return StyledPage(
      leading: StyledCircleButton.lg(child: Symbols.close.toIcon(), onPressed: () => Navigator.of(context).pop()),
      body: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(boxShadow: [StyledShadow.down(context)], color: context.colors.surfacePrimary),
            child: Padding(
              padding: EdgeInsets.all(16).copyWith(top: 0),
              child: Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        StyledTextField(
                          text: bookTextState.value,
                          readOnly: !isScrollingDownState.value,
                          onChanged: (text) {
                            if (text.endsWith(' ') && getBook(text: text.trim()) != null) {
                              bookTextState.value = text.trim();
                              chapterFocusNode.requestFocus();
                            } else {
                              bookTextState.value = text;
                            }
                          },
                          onTextEditValueChanged: (value) => bookTextSelectionState.value = value.selection,
                          autofocus: true,
                          suggestedText: book?.title(),
                          hintText: 'Book',
                          autocorrect: false,
                          textStyle: context.textStyle.paragraphLg,
                          textCapitalization: .words,
                          action: .next,
                          textInputType: .text,
                          focusNode: bookFocusNode,
                        ),
                        Positioned.fill(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: !isScrollingDownState.value ? () => isScrollingDownState.value = true : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: StyledTextField(
                      text: chapterNumState.value?.toString() ?? '',
                      onChanged: book == null ? null : (text) => chapterNumState.value = int.tryParse(text),
                      hintText: 'Chapter',
                      textStyle: context.textStyle.paragraphLg,
                      textInputType: .numberWithOptions(signed: true),
                      focusNode: chapterFocusNode,
                      onSubmit: (text) {
                        final chapterNum = int.tryParse(text);
                        if (book == null || chapterNum == null) {
                          return;
                        }

                        context.pop(ChapterReference(book: book, chapterNum: chapterNum).toResult());
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        if (book != null) RangeTextInputFormatter(min: 1, max: book.bookInfo.numChapters),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 112,
                    child: StyledMaterial(
                      padding: .all(12),
                      colorBuilder: .surfaceSecondary,
                      borderRadius: .circular(8),
                      onPressed: () async {
                        final newTranslation = await context.showStyledSheet<BibleTranslation>(
                          (context) => StyledSheet(
                            title: 'Bible Translation'.toText(),
                            trailing: StyledCircleButton.lg(
                              child: Symbols.tune.toIcon(),
                              onPressed: () {
                                context.pop();
                                context.push(BiblesPage());
                              },
                            ),
                            children: user.biblesOrDefault
                                .map(
                                  (translation) => BibleTile(
                                    translation: translation,
                                    trailing: StyledRadio(isSelected: translation == user.translation),
                                    onPressedOverride: () => context.pop(translation),
                                  ),
                                )
                                .toList(),
                          ),
                        );
                        if (newTranslation != null) {
                          ref.updateUser((user) => user.copyWith(translation: newTranslation));
                        }
                      },
                      child: Row(
                        spacing: 8,
                        children: [
                          Expanded(
                            child: Text(
                              user.translation.title(),
                              style: context.textStyle.paragraphLg,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          Icon(Symbols.keyboard_arrow_down, color: context.colors.contentTertiary),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: viewModeState.value == _ViewMode.book || book == null
                ? ListView(
                    key: ValueKey(BookType),
                    controller: scrollController,
                    children: [
                      if (getMatchingBooks().isNotEmpty && (isBookFullySelected || bookTextState.value.isEmpty)) ...[
                        if (user.bookmarkById.isNotEmpty)
                          StyledSection(
                            title: 'Bookmarks'.toText(),
                            padding: .only(top: 24),
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: .symmetric(horizontal: 16),
                                child: Row(
                                  spacing: 16,
                                  children: user.bookmarkById
                                      .mapToIterable(
                                        (bookmarkId, bookmark) => StyledTile(
                                          onPressed: () =>
                                              context.pop(bookmark.position.toResult(bookmarkId: bookmarkId)),
                                          padding: .all(16),
                                          child: Row(
                                            spacing: 12,
                                            crossAxisAlignment: .center,
                                            children: [
                                              Icon(
                                                Symbols.bookmark,
                                                color: bookmark.color.toHue(context.colors).medium,
                                              ),
                                              Column(
                                                crossAxisAlignment: .start,
                                                children: [
                                                  Text(bookmark.name, style: context.textStyle.labelMd),
                                                  Text(
                                                    bookmark.chapter.format(),
                                                    style: context.textStyle.paragraphSm.subtle(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        if (recents.isNotEmpty)
                          StyledSection(
                            title: 'Recents'.toText(),
                            padding: .only(top: 24),
                            children: recents
                                .map(
                                  (position) => StyledSwipeable(
                                    key: ValueKey(position.reference),
                                    actions: [
                                      StyledSwipeableAction.delete(
                                        onPressed: () => ref.updateUser(
                                          (user) => user.copyWith(viewHistory: user.viewHistory.withRemoved(position)),
                                        ),
                                      ),
                                    ],
                                    child: StyledListItem(
                                      leading: Symbols.history.toIcon(),
                                      title: position.reference.format().toText(),
                                      trailing: Symbols.expand_circle_right.toIcon(),
                                      onPressed: () => context.pop(position.toResult()),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                      ],

                      if (getMatchingBooks().isEmpty)
                        Padding(
                          padding: .all(16),
                          child: StyledBanner(message: 'No Matches'.toText()),
                        )
                      else
                        ...StyledSection(
                          title: 'Books'.toText(),
                          padding: .only(top: 24),
                          children: (isBookFullySelected ? BookType.values : getMatchingBooks())
                              .map(
                                (book) => StyledListItem(
                                  title: book.title().toText(),
                                  trailing: Symbols.chevron_right.toIcon(),
                                  onPressed: () {
                                    bookTextState.value = book.title();
                                    WidgetsBinding.instance.addPostFrameCallback(
                                      (_) => chapterFocusNode.requestFocus(),
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        ).buildChildren(context),
                    ],
                  )
                : StyledListView(
                    key: ValueKey(ChapterReference),
                    controller: scrollController,
                    children:
                        List.generate(
                              book.bookInfo.numChapters,
                              (chapterIndex) => ChapterReference(book: book, chapterNum: chapterIndex + 1),
                            )
                            .where(
                              (chapterReference) =>
                                  chapterNumState.value == null ||
                                  chapterReference.chapterNum.toString().startsWith(chapterNumState.value.toString()),
                            )
                            .map(
                              (chapterReference) => StyledListItem(
                                title: chapterReference.format().toText(),
                                trailing: Symbols.expand_circle_right.toIcon(),
                                onPressed: () => context.pop(chapterReference.toResult()),
                              ),
                            )
                            .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}

enum _ViewMode { book, chapter }

extension on ChapterReference {
  ChapterReferenceSearchPageResult toResult({String? bookmarkId, double scrollPercent = 0}) =>
      ChapterReferenceSearchPageResult(
        position: ChapterPosition(reference: this, scrollPercent: scrollPercent),
        bookmarkId: bookmarkId,
      );
}

extension on ChapterPosition {
  ChapterReferenceSearchPageResult toResult({String? bookmarkId}) =>
      ChapterReferenceSearchPageResult(position: this, bookmarkId: bookmarkId);
}
