import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/user/user.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/ui/widgets/bible_loading_error.dart';
import 'package:bible/ui/widgets/hook_consumer_builder.dart';
import 'package:bible/ui/widgets/swipe_page_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChapterPageView extends StatelessWidget {
  final PageController controller;
  final User user;
  final Widget Function(BuildContext context, ChapterReference chapterReference, Chapter chapter) itemBuilder;
  final void Function(ChapterReference chapterReference)? onPageChanged;
  final void Function(ChapterReference chapterReference)? onSwipe;

  const ChapterPageView({
    super.key,
    required this.controller,
    required this.user,
    required this.itemBuilder,
    this.onPageChanged,
    this.onSwipe,
  });

  @override
  Widget build(BuildContext context) {
    return SwipePageView.builder(
      controller: controller,
      pageCount: ChapterReference.values.length,
      onSwipe: (pageIndex) => onSwipe?.call(ChapterReference.fromBibleChapterIndex(pageIndex)),
      onPageChanged: (pageIndex) => onPageChanged?.call(ChapterReference.fromBibleChapterIndex(pageIndex)),
      itemBuilder: (context, pageIndex) => HookConsumerBuilder(
        builder: (context, ref) {
          final chapterReference = ChapterReference.fromBibleChapterIndex(pageIndex);
          final translation = user.getTranslationFor(chapterReference.book);
          final chapterValue = ref.watch(chapterProvider(translation: translation, chapterReference: chapterReference));

          if (chapterValue.hasError) {
            return BibleLoadingError(
              translation: translation,
              error: chapterValue.error,
              padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top + 24) + .symmetric(horizontal: 16),
              onRetry: () => ref.invalidate(
                chapterProvider(chapterReference: chapterReference, translation: translation),
                asReload: true,
              ),
            );
          }

          final chapter = chapterValue.value;
          if (chapter == null) {
            return SizedBox.shrink();
          }

          return itemBuilder(context, chapterReference, chapter);
        },
      ),
    );
  }
}
