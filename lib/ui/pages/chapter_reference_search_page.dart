import 'package:bible/extensions/controller_extensions.dart';
import 'package:bible/models/book_type.dart';
import 'package:bible/models/chapter_reference.dart';
import 'package:bible/providers/bible_provider.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:bible/style/styled_shadow.dart';
import 'package:bible/ui/pages/styled_text_field.dart';
import 'package:bible/utils/hook_utils.dart';
import 'package:bible/utils/input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recase/recase.dart';

class ChapterReferenceSearchPage extends HookConsumerWidget {
  final ChapterReference initialReference;

  const ChapterReferenceSearchPage({super.key, required this.initialReference});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bible = ref.watch(bibleProvider);

    final bookTextState = useState(initialReference.book.title());
    final bookTextSelectionState = useState<TextSelection>(
      TextSelection(baseOffset: 0, extentOffset: 0),
    );
    final isBookFullySelected =
        bookTextSelectionState.value.baseOffset == 0 &&
        bookTextSelectionState.value.extentOffset == 0;

    final chapterTextState = useState<int?>(initialReference.chapterNum);

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

    useEffect(() {
      if (book != previousBook) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => chapterTextState.value = null,
        );
      }
      return null;
    }, [book, previousBook]);

    useOnListenableChange(bookFocusNode, () {
      final book = getBook();
      if (!bookFocusNode.hasPrimaryFocus && book != null) {
        bookTextState.value = book.title().titleCase;
      }
    });

    final scrollController = useListenable(useScrollController());
    final isScrollingDownState = useState(true);
    useOnStickyScrollDirectionChanged(
      scrollController.positionOrNull,
      (direction) => isScrollingDownState.value = direction == ScrollDirection.forward,
    );

    return Scaffold(
      backgroundColor: context.colors.surfacePrimary,
      appBar: AppBar(
        backgroundColor: context.colors.surfacePrimary,
        leading: IconButton(
          icon: Icon(Icons.close),
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
                          textStyle: context.textStyle.paragraphLarge,
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
                      text: chapterTextState.value?.toString() ?? '',
                      onChanged: book == null
                          ? null
                          : (text) => chapterTextState.value = int.tryParse(text),
                      hintText: 'Chapter',
                      textStyle: context.textStyle.paragraphLarge,
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
                    children: BookType.values
                        .where(
                          (book) =>
                              isBookFullySelected ||
                              book.title().toUpperCase().startsWith(
                                bookTextState.value.toUpperCase(),
                              ),
                        )
                        .map(
                          (book) => ListTile(
                            title: Text(book.title()),
                            onTap: () {
                              bookTextState.value = book.title();
                              WidgetsBinding.instance.addPostFrameCallback(
                                (_) => chapterFocusNode.requestFocus(),
                              );
                            },
                          ),
                        )
                        .toList(),
                  )
                : ListView(
                    key: ValueKey(ChapterReference),
                    controller: scrollController,
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
                                  chapterTextState.value == null ||
                                  chapterReference.chapterNum.toString().startsWith(
                                    chapterTextState.value.toString(),
                                  ),
                            )
                            .map(
                              (chapterReference) => ListTile(
                                title: Text(chapterReference.format()),
                                onTap: () => Navigator.of(context).pop(chapterReference),
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
