import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class FindInBibleSheet {
  static Future<VerseSelection?> show(BuildContext context) => context.showStyledSheet<VerseSelection>((context, ref) {
    final chapterPositionState = useState<ChapterPosition?>(null);
    final selectionController = usePassageSelectionController(ref.read(luxReaderConfigurationProvider).selection);

    void selectReference(ChapterPosition position, bool shouldSelectVerse) {
      FocusManager.instance.primaryFocus?.unfocus();
      selectionController.clear();
      if (position.getReference() case final reference?) selectionController.selectReferences([reference]);
      chapterPositionState.value = position;
    }

    final selectorState = useState(SelectorState(focus: .book));

    final scrollController = useScrollController();
    final isScrollingDownState = useState(true);
    useOnStickyScrollDirectionChanged(
      scrollController,
      (direction) => isScrollingDownState.value = direction == .forward,
    );

    return StyledSheet.builder(
      title: 'Find in Bible'.toText(),
      aboveDivider: Listener(
        behavior: .translucent,
        onPointerDown: (_) {
          selectionController.clear();
          chapterPositionState.value = null;
        },
        child: ChapterPositionSelectorHeading(
          selectorState: selectorState,
          readOnly: !isScrollingDownState.value,
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
                child: ChapterPositionSelectorBody(
                  selectorState: selectorState,
                  onSelect: selectReference,
                  forceVerseNum: true,
                ),
              ),
            ),
          ];
        }

        final chapterReference = chapterPosition.reference;
        final chapter = ref.watch(chapterProvider(translation: .bsb, chapterReference: chapterReference)).value;

        return [
          Expanded(
            child: StyledLoading(
              child: chapter == null
                  ? null
                  : ChapterBuilder(
                      key: ValueKey(chapterPosition),
                      chapterReference: chapterReference,
                      chapter: chapter,
                      shrinkWrap: false,
                      selection: selectionController,
                      padding: .all(16),
                      scrollToSelection: chapterPosition.getReference()?.mapIfNonNull(
                        (reference) => .reference(reference),
                      ),
                    ),
            ),
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
                            ? 'Select Verses'
                            : 'Add ${selectionController.verseSelection!.format()}')
                        .toText(),
                onPressed: selectionController.verseSelection == null
                    ? null
                    : () => context.pop(selectionController.verseSelection),
              ),
            ],
    );
  });
}
