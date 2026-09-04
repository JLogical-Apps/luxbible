import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class PassagePreviewPage extends HookConsumerWidget implements StyledRoute<void> {
  final VerseSelection verseSelection;
  final Function(VerseSelection)? onNavigateToVerseSelection;

  const PassagePreviewPage({super.key, required this.verseSelection, this.onNavigateToVerseSelection});

  @override
  String get path => '/passage-preview';

  static Future<void> show(
    BuildContext context, {
    required VerseSelection verseSelection,
    Function(VerseSelection)? onNavigateToVerseSelection,
  }) => context.pushDialog(
    PassagePreviewPage(verseSelection: verseSelection, onNavigateToVerseSelection: onNavigateToVerseSelection),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialChapterReference = verseSelection.references.first.toChapterReference();
    final pageController = usePageController(initialPage: initialChapterReference.bibleChapterIndex);
    useListenableSelector(pageController, () => pageController.pageOrNull?.round());

    final currentPage = (pageController.pageOrNull ?? initialChapterReference.bibleChapterIndex).round();
    final currentChapterReference = ChapterReference.fromBibleChapterIndex(currentPage);
    final onNavigateToVerseSelection = this.onNavigateToVerseSelection;

    return StyledPage(
      title: currentChapterReference.format().toText(),
      leading: StyledCircleButton.md(child: Symbols.close.toIcon(), onPressed: () => context.pop()),
      showTopShadow: true,
      trailing: onNavigateToVerseSelection == null
          ? null
          : Tooltip(
              message: t.navigation.navigate,
              child: StyledCircleButton.md(
                child: Symbols.expand_circle_right.toIcon(),
                onPressed: () {
                  context.pop();
                  onNavigateToVerseSelection(verseSelection);
                },
              ),
            ),
      body: SafeArea(
        bottom: false,
        child: ChapterPageView(
          controller: pageController,
          itemBuilder: (context, chapterReference, chapter, passageController) => ChapterBuilder(
            chapterReference: chapterReference,
            chapter: chapter,
            controller: passageController,
            scrollToSelection: chapterReference == initialChapterReference ? verseSelection : null,
            underlinedReferences: [if (chapterReference == initialChapterReference) ...verseSelection.references],
            onNavigateToVerseSelection: onNavigateToVerseSelection == null
                ? null
                : (selection) {
                    context.pop();
                    onNavigateToVerseSelection(selection);
                  },
            padding: .only(left: 24, top: 16, right: 24, bottom: MediaQuery.paddingOf(context).bottom + 40),
          ),
        ),
      ),
    );
  }
}
