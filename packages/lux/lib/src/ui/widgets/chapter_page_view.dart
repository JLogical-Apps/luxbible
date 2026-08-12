import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';

class ChapterPageView extends ConsumerWidget {
  final PageController controller;
  final Widget Function(BuildContext, ChapterReference, Chapter, PassageController) itemBuilder;
  final Function(ChapterReference)? onPageChanged;
  final Function(ChapterReference)? onSwipe;

  const ChapterPageView({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.onPageChanged,
    this.onSwipe,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configuration = ref.watch(luxReaderConfigurationProvider);
    return SwipePageView.builder(
      controller: controller,
      pageCount: ChapterReference.values.length,
      onSwipe: (pageIndex) => onSwipe?.call(.fromBibleChapterIndex(pageIndex)),
      onPageChanged: (pageIndex) => onPageChanged?.call(.fromBibleChapterIndex(pageIndex)),
      itemBuilder: (context, pageIndex) => HookConsumer(
        builder: (context, pageRef, child) {
          final chapterReference = ChapterReference.fromBibleChapterIndex(pageIndex);
          final passageController = usePassageController(chapterReference);
          final translation = configuration.translationForChapter(chapterReference);
          final chapterValue = pageRef.watch(
            chapterProvider(translation: translation, chapterReference: chapterReference),
          );

          if (chapterValue.hasError) {
            return BibleLoadingError(
              translation: translation,
              error: chapterValue.error,
              padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top + 24) + .symmetric(horizontal: 16),
              fallbackTranslation: configuration.fallbackTranslation,
              onSwitchToFallback: configuration.onSwitchToFallback,
              onRetry: () => pageRef.invalidate(
                chapterProvider(chapterReference: chapterReference, translation: translation),
                asReload: true,
              ),
            );
          }

          final chapter = chapterValue.value;
          return chapter == null
              ? SizedBox.shrink()
              : itemBuilder(context, chapterReference, chapter, passageController);
        },
      ),
    );
  }
}
