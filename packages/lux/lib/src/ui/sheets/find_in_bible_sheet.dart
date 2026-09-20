import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:lux/src/ui/widgets/passage_selection_preview.dart';
import 'package:style/style.dart';

class FindInBibleSheet {
  static Future<VerseSelection?> show(
    BuildContext context, {
    required PassageSelectionConfiguration selectionConfiguration,
    Widget? title,
  }) => context.showStyledSheet<VerseSelection>((context, _) {
    final chapterPositionState = useState<ChapterPosition?>(null);
    final selectionController = usePassageSelectionController(selectionConfiguration);

    void selectReference(PositionResult result) {
      FocusManager.instance.primaryFocus?.unfocus();
      selectionController.clear();
      switch (result) {
        case ChapterPositionResult(:final position):
          chapterPositionState.value = position;
        case PassagePositionResult(:final selection):
          selectionController.selectReferences(selection.references);
          final reference = selection.start.startReference;
          chapterPositionState.value = ChapterPosition(
            reference: reference.toChapterReference(),
            verseNum: reference.verseNum,
          );
      }
    }

    final selectorState = useState(SelectorState(focus: .book));

    final scrollController = useScrollController();

    return StyledSheet.builder(
      title: title ?? t.passageSelection.findInBible.toText(),
      aboveDivider: Listener(
        behavior: .translucent,
        onPointerDown: (_) {
          selectionController.clear();
          chapterPositionState.value = null;
        },
        child: PositionSelectorHeading(
          selectorState: selectorState,
          scrollController: scrollController,
          onSelect: selectReference,
          showShadow: false,
          forceVerseNum: true,
        ),
      ),
      forceHeight: true,
      childrenBuilder: (context, ref) {
        final chapterPosition = chapterPositionState.value;
        if (chapterPosition == null) {
          return [
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: PositionSelectorBody(
                  selectorState: selectorState,
                  onSelect: selectReference,
                  forceVerseNum: true,
                  onSelectEntireChapter: (reference) => context.pop(VerseSelection.fromOsisId(reference.osisId())),
                ),
              ),
            ),
          ];
        }

        return [
          Expanded(
            child: PassageSelectionPreview(position: chapterPosition, selectionController: selectionController),
          ),
        ];
      },
      forceBottomShadow: chapterPositionState.value != null,
      buttonsBuilder: chapterPositionState.value == null
          ? null
          : (context) => [
              StyledRectButton.primary(
                label:
                    (selectionController.verseSelection == null
                            ? t.passageSelection.selectVerses
                            : t.passageSelection.addPassage(reference: selectionController.verseSelection!.format()))
                        .toText(),
                onPressed: selectionController.verseSelection == null
                    ? null
                    : () => context.pop(selectionController.verseSelection),
              ),
            ],
    );
  });
}
