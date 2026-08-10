import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';

class ChapterBuilder extends HookConsumerWidget {
  final ChapterReference chapterReference;
  final BibleTranslation translation;
  final Chapter chapter;
  final PassageController? passageController;

  final VerseSelection? selection;
  final Function(Reference)? onReferencePressed;

  final bool shrinkWrap;
  final EdgeInsets? padding;

  const ChapterBuilder({
    super.key,
    required this.chapterReference,
    required this.translation,
    required this.chapter,
    this.passageController,
    this.selection,
    this.onReferencePressed,
    this.shrinkWrap = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passageController = this.passageController ?? usePassageController(chapterReference);
    final nextReference = chapterReference.next;
    if (nextReference != null) {
      ref.watch(chapterProvider(translation: translation, chapterReference: nextReference));
    }

    final previousReference = chapterReference.previous;
    if (previousReference != null) {
      ref.watch(chapterProvider(translation: translation, chapterReference: previousReference));
    }

    if (selection case final selection?) {
      usePostFrameEffect(
        () => passageController.jumpToReference(
          selection.references.first,
          paragraphs: chapter.paragraphs,
          alignment: 0.25,
        ),
      );
    }

    return BibleParagraphsBuilder(
      paragraphs: chapter.paragraphs,
      chapterReference: chapterReference,
      translation: translation,
      underlinedReferences: selection?.references ?? [],
      onReferencePressed: onReferencePressed,
      controller: passageController,
      padding: padding,
      shrinkWrap: shrinkWrap,
    );
  }
}
