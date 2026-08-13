import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:lux/src/ui/widgets/passage_content.dart';

class ChapterBuilder extends HookConsumerWidget {
  final ChapterReference chapterReference;
  final Chapter chapter;
  final PassageController? controller;

  final VerseSelection? scrollToSelection;
  final double scrollToSelectionAlignment;
  final List<Reference> underlinedReferences;
  final PassageSelectionController? selection;
  final Function(VerseSelection)? onNavigateToVerseSelection;

  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final bool removeScrollbarPadding;

  const ChapterBuilder({
    super.key,
    required this.chapterReference,
    required this.chapter,
    this.controller,
    this.scrollToSelection,
    this.scrollToSelectionAlignment = 0.25,
    this.underlinedReferences = const [],
    this.selection,
    this.onNavigateToVerseSelection,
    this.padding,
    this.shrinkWrap = false,
    this.removeScrollbarPadding = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configuration = ref.watch(luxReaderConfigurationProvider);
    final translation = configuration.translationForChapter(chapterReference);
    final controller = this.controller ?? usePassageController(chapterReference);

    final selection = this.selection;
    final onNavigateToVerseSelection = this.onNavigateToVerseSelection;

    if (chapterReference.next case final nextReference?) {
      ref.watch(
        chapterProvider(
          translation: configuration.translationForChapter(nextReference),
          chapterReference: nextReference,
        ),
      );
    }
    if (chapterReference.previous case final previousReference?) {
      ref.watch(
        chapterProvider(
          translation: configuration.translationForChapter(previousReference),
          chapterReference: previousReference,
        ),
      );
    }

    usePostFrameEffect(() {
      if (scrollToSelection case final scrollToSelection?) {
        controller.jumpToReference(
          scrollToSelection.references.first,
          paragraphs: chapter.paragraphs,
          alignment: scrollToSelectionAlignment,
        );
      }
    });

    return PassageContent(
      configuration: configuration,
      paragraphs: chapter.paragraphs,
      chapterReference: chapterReference,
      translation: translation,
      selection: selection,
      underlinedReferences: underlinedReferences,
      onNavigateToVerseSelection: onNavigateToVerseSelection,
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      removeScrollbarPadding: removeScrollbarPadding,
      showChapterAccessories: true,
      animate: true,
    );
  }
}
