import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/providers/bibles_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/widgets/styled_loading.dart';
import 'package:bible/ui/widgets/bible_loading_error.dart';
import 'package:bible/ui/widgets/bible_selection.dart';
import 'package:bible/ui/widgets/font_size_spacing_zoom_gesture.dart';
import 'package:bible/ui/widgets/paragraphs_builder.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PassageBuilder extends HookConsumerWidget {
  final VerseSelection verseSelection;
  final BibleTranslation? translation;

  final BibleSelection? selection;
  final Function(VerseSelection)? onNavigateToVerseSelection;

  final bool showLoading;
  final Widget Function(BuildContext context, Widget passage)? contentBuilder;

  const PassageBuilder({
    super.key,
    required this.verseSelection,
    this.translation,
    this.selection,
    this.onNavigateToVerseSelection,
    this.showLoading = false,
    this.contentBuilder,
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
    final passage = ParagraphsBuilder(
      paragraphs: paragraphs,
      chapterReference: chapterReference,
      user: user,
      translation: translation,
      selection: selection,
      onNavigateToVerseSelection: onNavigateToVerseSelection,
    );

    return FontSizeSpacingZoomGesture(
      language: translation.language,
      child: showLoading
          ? StyledLoading(child: paragraphs.isEmpty ? null : contentBuilder?.call(context, passage) ?? passage)
          : AnimatedOpacity(
              opacity: paragraphs.isEmpty ? 0 : 1,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              child: contentBuilder?.call(context, passage) ?? passage,
            ),
    );
  }
}
