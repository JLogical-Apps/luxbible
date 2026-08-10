import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:memory/ui/widgets/chapter_builder.dart';
import 'package:memory/ui/widgets/chapter_page_view.dart';
import 'package:style/style.dart';

class PassagePreviewPage extends HookWidget {
  final BibleTranslation translation;
  final VerseSelection passage;

  const PassagePreviewPage({super.key, required this.translation, required this.passage});

  @override
  Widget build(BuildContext context) {
    final currentReferenceState = useState(passage.references.first.toChapterReference());

    return StyledPage(
      title: currentReferenceState.value.format().toText(),
      showTopShadow: true,
      body: SafeArea(
        bottom: false,
        child: ChapterPageView(
          chapterReference: currentReferenceState.value,
          translation: translation,
          onPageChanged: (reference) => currentReferenceState.value = reference,
          itemBuilder: (context, chapterReference, chapter, passageController) => StyledScrollbar(
            controller: passageController.scrollController,
            child: ChapterBuilder(
              chapterReference: chapterReference,
              translation: translation,
              chapter: chapter,
              selection: passage,
              passageController: passageController,
              padding:
                  EdgeInsets.symmetric(horizontal: 24, vertical: 16) +
                  .only(bottom: MediaQuery.paddingOf(context).bottom + 24),
            ),
          ),
        ),
      ),
    );
  }
}
