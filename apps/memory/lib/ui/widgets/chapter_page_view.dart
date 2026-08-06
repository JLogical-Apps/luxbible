import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';

class ChapterPageView extends HookWidget {
  final ChapterReference chapterReference;
  final BibleTranslation translation;

  final Widget Function(BuildContext context, ChapterReference chapterReference, Chapter chapter) itemBuilder;

  final void Function(ChapterReference chapterReference)? onPageChanged;

  const ChapterPageView({
    super.key,
    required this.chapterReference,
    required this.translation,
    required this.itemBuilder,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwipePageView.builder(
      controller: usePageController(initialPage: chapterReference.bibleChapterIndex),
      pageCount: ChapterReference.values.length,
      onPageChanged: (pageIndex) => onPageChanged?.call(.fromBibleChapterIndex(pageIndex)),
      itemBuilder: (context, pageIndex) => Consumer(
        builder: (context, ref, child) {
          final chapterReference = ChapterReference.fromBibleChapterIndex(pageIndex);
          final chapter = ref
              .watch(chapterProvider(translation: translation, chapterReference: chapterReference))
              .value;
          if (chapter == null) {
            return SizedBox.shrink();
          }

          return itemBuilder(context, chapterReference, chapter);
        },
      ),
    );
  }
}
