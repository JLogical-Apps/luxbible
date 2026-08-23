import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:lux/src/ui/widgets/passage_content.dart';
import 'package:style/style.dart';

class PassageBuilder extends HookConsumerWidget {
  final VerseSelection verseSelection;
  final BibleTranslation? translation;

  final PassageSelectionController? selection;
  final Reference? emphasizedReference;
  final Function(VerseSelection)? onNavigateToVerseSelection;
  final Function(Reference)? onReferencePressed;

  final Widget Function(BuildContext, Widget)? contentBuilder;
  final Widget? footer;
  final PassageController? controller;

  final EdgeInsets padding;
  final bool shrinkWrap;
  final Function(List<Paragraph>)? onParagraphsLoaded;
  final bool showLoading;

  const PassageBuilder({
    super.key,
    required this.verseSelection,
    this.translation,
    this.selection,
    this.emphasizedReference,
    this.onNavigateToVerseSelection,
    this.onReferencePressed,
    this.contentBuilder,
    this.footer,
    this.controller,
    this.padding = .zero,
    this.shrinkWrap = false,
    this.onParagraphsLoaded,
    this.showLoading = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (verseSelection.isEmpty) return SizedBox.shrink();

    final chapterReference = verseSelection.references.first.toChapterReference();
    final configuration = ref.watch(luxReaderConfigurationProvider);
    final translation =
        this.translation?.effectiveFor(chapterReference.book) ?? configuration.translationForChapter(chapterReference);

    final paragraphsValue = ref.watch(
      verseSelectionParagraphsProvider(selection: verseSelection, translation: translation),
    );

    if (paragraphsValue.hasError) {
      return BibleLoadingError(
        translation: translation,
        error: paragraphsValue.error,
        fallbackTranslation: configuration.fallbackTranslation,
        onSwitchToFallback: configuration.onSwitchToFallback,
        onRetry: () => ref.invalidate(
          chapterProvider(translation: translation, chapterReference: chapterReference),
          asReload: true,
        ),
        padding: padding,
        shrinkWrap: shrinkWrap,
        suggestTranslationSwap: this.translation == null,
      );
    }

    final paragraphs = paragraphsValue.value ?? [];
    usePostFrameEffect(() {
      if (paragraphs.isNotEmpty) {
        onParagraphsLoaded?.call(paragraphs);
      }
    }, [paragraphs.isNotEmpty]);

    return StyledLoading(
      loadingPadding: .all(16),
      child: paragraphs.isEmpty && showLoading
          ? null
          : PassageContent(
              configuration: configuration,
              paragraphs: paragraphs,
              chapterReference: chapterReference,
              translation: translation,
              selection: selection,
              emphasizedReference: emphasizedReference,
              onNavigateToVerseSelection: onNavigateToVerseSelection,
              onReferencePressed: onReferencePressed,
              controller: controller,
              padding: padding,
              shrinkWrap: shrinkWrap,
              animate: true,
              contentBuilder: contentBuilder,
              footer: footer,
            ),
    );
  }
}
