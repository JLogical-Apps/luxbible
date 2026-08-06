import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:memory/ui/widgets/chapter_builder.dart';
import 'package:memory/ui/widgets/chapter_page_view.dart';
import 'package:style/style.dart';

class ChapterPreviewPage extends HookWidget {
  final ChapterReference chapterReference;
  final BibleTranslation translation;

  final VerseSelection? selection;

  const ChapterPreviewPage({super.key, required this.chapterReference, required this.translation, this.selection});

  @override
  Widget build(BuildContext context) {
    final currentReferenceState = useState(chapterReference);

    return StyledPage(
      title: currentReferenceState.value.format().toText(),
      showTopShadow: true,
      body: SafeArea(
        bottom: false,
        child: ChapterPageView(
          chapterReference: chapterReference,
          translation: translation,
          onPageChanged: (reference) => currentReferenceState.value = reference,
          itemBuilder: (context, chapterReference, chapter) => StyledScrollbar(
            child: SingleChildScrollView(
              primary: currentReferenceState.value == chapterReference,
              physics: AlwaysScrollableScrollPhysics(),
              padding: .symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  ChapterBuilder(
                    chapterReference: chapterReference,
                    translation: translation,
                    chapter: chapter,
                    selection: selection,
                  ),
                  Builder(builder: (context) => SizedBox(height: MediaQuery.paddingOf(context).bottom + 24)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
