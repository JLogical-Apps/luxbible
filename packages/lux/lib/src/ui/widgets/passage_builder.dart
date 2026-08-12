import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:lux/src/ui/widgets/passage_content.dart';

class PassageBuilder extends HookConsumerWidget {
  final VerseSelection verseSelection;
  final BibleTranslation? translation;

  final PassageSelectionController? selection;
  final Function(VerseSelection)? onNavigateToVerseSelection;

  final Widget Function(BuildContext, Widget)? contentBuilder;
  final PassageController? controller;

  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final Function(List<Paragraph>)? onParagraphsLoaded;

  const PassageBuilder({
    super.key,
    required this.verseSelection,
    this.translation,
    this.selection,
    this.onNavigateToVerseSelection,
    this.contentBuilder,
    this.controller,
    this.padding,
    this.shrinkWrap = true,
    this.onParagraphsLoaded,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (verseSelection.isEmpty) return SizedBox.shrink();

    final chapterReference = verseSelection.references.first.toChapterReference();
    final configuration = ref.watch(luxReaderConfigurationProvider);
    final translation =
        this.translation?.effectiveFor(chapterReference.book) ?? configuration.translationForChapter(chapterReference);

    final paragraphsProvider = verseSelectionParagraphsProvider(selection: verseSelection, translation: translation);
    final paragraphsValue = ref.watch(paragraphsProvider);

    if (paragraphsValue.hasError) {
      return BibleLoadingError(
        translation: translation,
        error: paragraphsValue.error,
        fallbackTranslation: configuration.fallbackTranslation,
        onSwitchToFallback: configuration.onSwitchToFallback,
        onRetry: () => ref.invalidate(paragraphsProvider, asReload: true),
      );
    }

    final paragraphs = paragraphsValue.value ?? [];
    usePostFrameEffect(() {
      if (paragraphs.isNotEmpty) {
        onParagraphsLoaded?.call(paragraphs);
      }
    }, [paragraphs.isNotEmpty]);

    return PassageContent(
      configuration: configuration,
      paragraphs: paragraphs,
      chapterReference: chapterReference,
      translation: translation,
      selection: selection,
      onNavigateToVerseSelection: onNavigateToVerseSelection,
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      animate: true,
      contentBuilder: contentBuilder,
    );
  }
}
