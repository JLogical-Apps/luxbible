import 'package:bible/extensions/collection_extensions.dart';
import 'package:bible/providers/bible_provider.dart';
import 'package:bible/style/gap.dart';
import 'package:bible/style/style_context_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BiblePage extends HookConsumerWidget {
  const BiblePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bible = ref.watch(bibleProvider);

    final pageController = usePageController(initialPage: 0);
    final selectedVersesState = useState(<int>[]);

    return Scaffold(
      backgroundColor: context.colors.backgroundPrimary,
      body: PageView.builder(
        controller: pageController,
        onPageChanged: (_) => selectedVersesState.value = [],
        itemBuilder: (context, pageIndex) {
          final chapterReference = bible.getChapterReferenceByPageIndex(pageIndex);
          final chapter = bible.getChapterByReference(chapterReference);

          return ListView(
            padding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 8) +
                EdgeInsets.only(
                  top: MediaQuery.paddingOf(context).top + 24,
                  bottom: MediaQuery.paddingOf(context).bottom,
                ),
            children: [
              Text(
                '${chapterReference.book.title()} ${chapterReference.chapterNum}',
                style: context.textStyle.bibleChapter,
              ),
              gapH8,
              ...chapter.verses.mapIndexed(
                (i, verse) => GestureDetector(
                  onTap: () =>
                      selectedVersesState.value = selectedVersesState.value.withToggle(i),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          child: Transform.translate(
                            offset: Offset(0, -3),
                            child: Text(
                              (i + 1).toString(),
                              style: context.textStyle.bibleVerseNumber,
                            ),
                          ),
                          alignment: PlaceholderAlignment.top,
                        ),
                        TextSpan(
                          text: ' ${verse.text}',
                          style: context.textStyle.bibleBody.copyWith(
                            decoration: selectedVersesState.value.contains(i)
                                ? TextDecoration.underline
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
