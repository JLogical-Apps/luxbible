import 'package:bible/models/book_type.dart';
import 'package:bible/models/chapter_reference.dart';
import 'package:bible/providers/bible_provider.dart';
import 'package:bible/providers/user_profile_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/styled_shadow.dart';
import 'package:bible/style/widgets/styled_list.dart';
import 'package:bible/style/widgets/styled_list_item.dart';
import 'package:bible/style/widgets/styled_section.dart';
import 'package:bible/style/widgets/styled_swipeable.dart';
import 'package:bible/style/widgets/styled_text_field.dart';
import 'package:bible/utils/extensions/collection_extensions.dart';
import 'package:bible/utils/hook_utils.dart';
import 'package:bible/utils/input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:recase/recase.dart';

class ChapterReferenceSearchPage extends HookConsumerWidget {
  final ChapterReference initialReference;

  const ChapterReferenceSearchPage({super.key, required this.initialReference});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bible = ref.watch(bibleProvider);
    final userProfile = ref.watch(userProfileProvider);

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

    BookType? getBook() => BookType.values
        .where(
          (book) =>
              book.title().toUpperCase().startsWith(bookTextState.value.toUpperCase()),
        )
        .singleOrNull;

    final book = getBook();
    final previousBook = usePrevious(getBook());

    final isFirstFrame = useIsFirstFrame();
    usePostFrameEffect(() {
      if (book != previousBook && !isFirstFrame) {
        chapterNumState.value = null;
      }
      return null;
    }, [book, previousBook]);

    useOnListenableChange(bookFocusNode, () {
      final book = getBook();
      if (!bookFocusNode.hasPrimaryFocus && book != null) {
        bookTextState.value = book.title().titleCase;
      }
    });

    final scrollController = useScrollController();
    final isScrollingDownState = useState(true);
    useOnStickyScrollDirectionChanged(
      scrollController,
      (direction) => isScrollingDownState.value = direction == ScrollDirection.forward,
    );

    return Scaffold(
      backgroundColor: context.colors.surfacePrimary,
      appBar: AppBar(
        backgroundColor: context.colors.surfacePrimary,
        leading: IconButton(
          icon: Icon(Symbols.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [StyledShadow(context)],
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
                          text: bookTextState.value,
                          readOnly: !isScrollingDownState.value,
                          onChanged: (text) => bookTextState.value = text,
                          onTextEditValueChanged: (value) =>
                              bookTextSelectionState.value = value.selection,
                          autofocus: true,
                          suggestedText: book?.title(),
                          hintText: 'Book',
                          textStyle: context.textStyle.paragraphLg,
                          textCapitalization: TextCapitalization.words,
                          action: TextInputAction.next,
                          textInputType: TextInputType.text,
                          focusNode: bookFocusNode,
                        ),
                        Positioned.fill(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: !isScrollingDownState.value
                                ? () => isScrollingDownState.value = true
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: StyledTextField(
                      text: chapterNumState.value?.toString() ?? '',
                      onChanged: book == null
                          ? null
                          : (text) => chapterNumState.value = int.tryParse(text),
                      hintText: 'Chapter',
                      textStyle: context.textStyle.paragraphLg,
                      textInputType: TextInputType.number,
                      focusNode: chapterFocusNode,
                      onSubmit: (text) {
                        final chapterNum = int.tryParse(text);
                        if (book == null || chapterNum == null) {
                          return;
                        }

                        Navigator.of(
                          context,
                        ).pop(ChapterReference(book: book, chapterNum: chapterNum));
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        if (book != null)
                          RangeTextInputFormatter(
                            min: 1,
                            max: bible.getBookByType(book).chapters.length,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: book == null || bookFocusNode.hasPrimaryFocus
                ? ListView(
                    key: ValueKey(BookType),
                    controller: scrollController,
                    children: [
                      if (userProfile.previouslyViewed.isNotEmpty &&
                          (isBookFullySelected || bookTextState.value.isEmpty))
                        StyledSection.list(
                          titleText: 'Recents',
                          children: userProfile.previouslyViewed
                              .map(
                                (chapterReference) => StyledSwipeable(
                                  key: ValueKey(chapterReference),
                                  actions: [
                                    StyledSwipeableAction.delete(
                                      onPressed: () => ref
                                          .read(userProfileProvider.notifier)
                                          .set(
                                            userProfile.copyWith(
                                              previouslyViewed: userProfile
                                                  .previouslyViewed
                                                  .withRemoved(chapterReference),
                                            ),
                                          ),
                                    ),
                                  ],
                                  child: StyledListItem(
                                    titleText: chapterReference.format(),
                                    trailingIcon: Symbols.expand_circle_right,
                                    onPressed: () =>
                                        Navigator.of(context).pop(chapterReference),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      StyledSection.list(
                        titleText: 'Books',
                        padding: EdgeInsets.only(top: 24),
                        children: BookType.values
                            .where(
                              (book) =>
                                  isBookFullySelected ||
                                  book.title().toUpperCase().startsWith(
                                    bookTextState.value.toUpperCase(),
                                  ),
                            )
                            .map(
                              (book) => StyledListItem(
                                titleText: book.title(),
                                trailingIcon: Symbols.chevron_right,
                                onPressed: () {
                                  bookTextState.value = book.title();
                                  WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => chapterFocusNode.requestFocus(),
                                  );
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    key: ValueKey(ChapterReference),
                    controller: scrollController,
                    child: StyledList(
                      children:
                          List.generate(
                                bible.getBookByType(book).chapters.length,
                                (chapterIndex) => ChapterReference(
                                  book: book,
                                  chapterNum: chapterIndex + 1,
                                ),
                              )
                              .where(
                                (chapterReference) =>
                                    chapterNumState.value == null ||
                                    chapterReference.chapterNum.toString().startsWith(
                                      chapterNumState.value.toString(),
                                    ),
                              )
                              .map(
                                (chapterReference) => StyledListItem(
                                  titleText: chapterReference.format(),
                                  trailingIcon: Symbols.expand_circle_right,
                                  onPressed: () =>
                                      Navigator.of(context).pop(chapterReference),
                                ),
                              )
                              .toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
