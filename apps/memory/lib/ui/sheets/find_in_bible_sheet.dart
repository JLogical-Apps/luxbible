import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:memory/providers/root_ref.dart';
import 'package:style/style.dart';

class FindInBibleSheet {
  static Future<VerseSelection?> show(BuildContext context) => context.showStyledSheet<VerseSelection>((context) {
    final chapterReferenceState = useState<ChapterReference?>(null);
    final selection = usePassageSelection(ref.read(luxReaderConfigurationProvider).selection);

    void deselectChapter() {
      selection.clear();
      chapterReferenceState.value = null;
    }

    void selectChapter(ChapterPosition position, bool shouldSelectVerse) {
      FocusManager.instance.primaryFocus?.unfocus();
      selection.clear();
      chapterReferenceState.value = position.reference;
    }

    final selectorController = useChapterReferenceSelectorController();
    useOnFocusNodeFocused(selectorController.bookFocusNode, deselectChapter);
    useOnFocusNodeFocused(selectorController.chapterFocusNode, deselectChapter);

    return StyledSheet.builder(
      title: 'Find in Bible'.toText(),
      aboveDivider: ChapterReferenceSelectorHeading(
        controller: selectorController,
        onSelect: selectChapter,
        showShadow: false,
      ),
      controller: selectorController.scrollController,
      shrinkWrap: false,
      childrenBuilder: (context, ref) {
        final chapterReference = chapterReferenceState.value;
        if (chapterReference == null) {
          return [ChapterReferenceSelectorBody(controller: selectorController, onSelect: selectChapter)];
        }

        final chapter = ref.watch(chapterProvider(translation: .bsb, chapterReference: chapterReference)).value;
        return [
          StyledLoading(
            child: chapter == null
                ? null
                : ChapterBuilder(
                    chapterReference: chapterReference,
                    chapter: chapter,
                    shrinkWrap: true,
                    selection: selection,
                    padding: .all(16),
                  ),
          ),
        ];
      },
      buttonsBuilder: chapterReferenceState.value == null
          ? null
          : (context) => [
              StyledRectButton.primary(
                label:
                    (selection.verseSelection == null ? 'Select Verses' : 'Add ${selection.verseSelection!.format()}')
                        .toText(),
                onPressed: selection.verseSelection == null ? null : () => context.pop(selection.verseSelection),
              ),
            ],
    );
  });
}
