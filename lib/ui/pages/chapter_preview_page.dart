import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/chapter_builder.dart';
import 'package:bible/ui/widgets/chapter_page_view.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/controller_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:bible/utils/hook_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:utils_core/utils_core.dart';

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
        message: 'Navigate',
        child: StyledCircleButton.md(
          child: Symbols.expand_circle_right.toIcon(),
          onPressed: () {
            context.pop();
            onNavigateToPassage();
          },
        ),
      ),
      body: ChapterPageView(
        controller: pageController,
        user: user,
        itemBuilder: (context, chapterReference, chapter) => HookBuilder(
          builder: (context) {
            final scrollController = useScrollController();
            final keyByReference = useMemoized(
              () => chapterReference.references.mapToMap((reference) => MapEntry(reference, GlobalKey())),
              [chapterReference],
            );

            final scrollToSelection = chapterReference == initialChapterReference ? verseSelection : null;
            final isLoaded = useOnContentLoaded(
              controller: scrollController,
              onContentLoaded: (maxScrollExtent) {
                if (scrollToSelection == null) {
                  return;
                }

                final verseContext = keyByReference[scrollToSelection.references.first]?.currentContext;
                if (verseContext != null && verseContext.mounted) {
                  Scrollable.ensureVisible(
                    verseContext,
                    alignment: 0.35,
                    curve: Curves.easeInOutCubic,
                    duration: .zero,
                  );
                }
              },
            );

            return AnimatedOpacity(
              opacity: isLoaded ? 1 : 0,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              child: StyledScrollbar(
                controller: scrollController,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: scrollController,
                  padding: .symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      ChapterBuilder(
                        chapterReference: chapterReference,
                        user: user,
                        chapter: chapter,
                        underlinedReferences: scrollToSelection?.references ?? const [],
                        keyByReference: keyByReference,
                      ),
                      Builder(builder: (context) => SizedBox(height: MediaQuery.paddingOf(context).bottom + 24)),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
