import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';

class ChapterPageView extends HookWidget {
  final ChapterReference chapterReference;
  final BibleTranslation translation;

  final Widget Function(BuildContext, ChapterReference, Chapter, PassageController) itemBuilder;

  final void Function(ChapterReference)? onPageChanged;

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
      itemBuilder: (context, pageIndex) => HookConsumer(
        builder: (context, ref, child) {
          final chapterReference = ChapterReference.fromBibleChapterIndex(pageIndex);
          final passageController = usePassageController(chapterReference);
          final chapter = ref
              .watch(chapterProvider(translation: translation, chapterReference: chapterReference))
              .value;
          if (chapter == null) {
            return SizedBox.shrink();
          }

          return itemBuilder(context, chapterReference, chapter, passageController);
        },
      ),
    );
  }
}
