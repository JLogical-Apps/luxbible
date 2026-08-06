import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/widgets/chapter_builder.dart';
import 'package:bible/ui/widgets/chapter_page_view.dart';
import 'package:bible/ui/widgets/passage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class ChapterPreviewPage extends HookConsumerWidget {
  final VerseSelection verseSelection;
  final Function() onNavigateToPassage;

  const ChapterPreviewPage({super.key, required this.verseSelection, required this.onNavigateToPassage});

  static Future<void> show(
    BuildContext context, {
    required VerseSelection verseSelection,
    required VoidCallback onNavigateToPassage,
  }) =>
      context.pushDialog(ChapterPreviewPage(verseSelection: verseSelection, onNavigateToPassage: onNavigateToPassage));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    final initialChapterReference = verseSelection.references.first.toChapterReference();

    final pageController = usePageController(initialPage: initialChapterReference.bibleChapterIndex);
    useListenableSelector(pageController, () => pageController.pageOrNull?.round());

    final currentPage = (pageController.pageOrNull ?? initialChapterReference.bibleChapterIndex).round();
    final currentChapterReference = ChapterReference.fromBibleChapterIndex(currentPage);

    return StyledPage(
      title: currentChapterReference.format().toText(),
      leading: StyledCircleButton.md(child: Symbols.close.toIcon(), onPressed: () => context.pop()),
      showTopShadow: true,
      trailing: Tooltip(
        message: t.navigation.navigate,
        child: StyledCircleButton.md(
          child: Symbols.expand_circle_right.toIcon(),
          onPressed: () {
            context.pop();
            onNavigateToPassage();
          },
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: ChapterPageView(
          controller: pageController,
          user: user,
          itemBuilder: (context, chapterReference, chapter) => HookBuilder(
            builder: (context) {
              final passageController = usePassageController(chapterReference);
              final scrollController = passageController.scrollController;

              final scrollToSelection = chapterReference == initialChapterReference ? verseSelection : null;
              final isLoaded = useOnContentLoaded(
                controller: scrollController,
                onContentLoaded: (maxScrollExtent) {
                  if (scrollToSelection == null) {
                    return;
                  }

                  passageController.jumpToReference(
                    scrollToSelection.references.first,
                    paragraphs: chapter.paragraphs,
                    alignment: 0.35,
                  );
                },
              );

              return AnimatedOpacity(
                opacity: isLoaded ? 1 : 0,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                child: StyledScrollbar(
                  controller: scrollController,
                  child: ChapterBuilder(
                    controller: passageController,
                    padding: .only(left: 24, top: 16, right: 24, bottom: MediaQuery.paddingOf(context).bottom + 40),
                    chapterReference: chapterReference,
                    user: user,
                    chapter: chapter,
                    underlinedReferences: scrollToSelection?.references ?? const [],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
