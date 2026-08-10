import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/widgets/bible_loading_error.dart';
import 'package:bible/ui/widgets/bible_selection.dart';
import 'package:bible/ui/widgets/font_size_spacing_zoom_gesture.dart';
import 'package:bible/ui/widgets/paragraphs_builder.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';

class PassageBuilder extends HookConsumerWidget {
  final VerseSelection verseSelection;
  final BibleTranslation? translation;

  final BibleSelection? selection;
  final Function(VerseSelection)? onNavigateToVerseSelection;

  final Widget Function(BuildContext context, Widget passage)? contentBuilder;
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
    final user = ref.watch(userProvider);
    final translation =
        this.translation?.effectiveFor(chapterReference.book) ?? user.getTranslationFor(chapterReference.book);
    final paragraphsValue = ref.watch(
      verseSelectionParagraphsProvider(selection: verseSelection, translation: translation),
    );
    if (paragraphsValue.hasError) {
      return BibleLoadingError(
        translation: translation,
        error: paragraphsValue.error,
        onRetry: () => ref.invalidate(
          chapterProvider(chapterReference: chapterReference, translation: translation),
          asReload: true,
        ),
      );
    }

    final paragraphs = paragraphsValue.value ?? [];
    usePostFrameEffect(() {
      if (paragraphs.isNotEmpty) {
        onParagraphsLoaded?.call(paragraphs);
      }
    }, [paragraphs.isNotEmpty]);

    final passage = ParagraphsBuilder(
      paragraphs: paragraphs,
      chapterReference: chapterReference,
      user: user,
      translation: translation,
      selection: selection,
      onNavigateToVerseSelection: onNavigateToVerseSelection,
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
    );

    return FontSizeSpacingZoomGesture(
      language: translation.bibleLanguage,
      child: AnimatedOpacity(
        opacity: paragraphs.isEmpty ? 0 : 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        child: contentBuilder?.call(context, passage) ?? passage,
      ),
    );
  }
}
