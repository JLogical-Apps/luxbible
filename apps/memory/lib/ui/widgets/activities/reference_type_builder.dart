import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:memory/models/activity_plan.dart';
import 'package:style/style.dart';

class ReferenceTypeBuilder extends HookConsumerWidget {
  final ReferenceTypeActivityPlan plan;

  const ReferenceTypeBuilder({super.key, required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verses = ref.watch(verseSelectionVersesProvider(translation: .bsb, selection: plan.passage)).value;
    if (verses == null) {
      return StyledLoading(loadingPadding: .all(16));
    }

    final isCompletedState = useState(false);
    final selectorState = useState(SelectorState(focus: .book));
    final errorCountState = useState(0);

    void selectReference(ChapterPosition position, bool shouldSelectVerse) {
      if (!shouldSelectVerse || isCompletedState.value) return;

      if (position.getReference() == plan.passage.references.first) {
        isCompletedState.value = true;
      } else {
        errorCountState.value++;
      }
    }

    usePostFrameEffect(() {
      if (isCompletedState.value) FocusManager.instance.primaryFocus?.unfocus();
    }, [isCompletedState.value]);

    return StyledTransitionBuilder(
      value: errorCountState.value,
      builder: (context, value, child) => StyledDock(
        shrinkWrap: false,
        childrenPadding: .all(16),
        children: [VerseText(verses: verses, style: context.textStyle.paragraphLg)],
        buttonsColor: Color.lerp(context.colors.surfacePrimary, context.colors.surfaceCritical, value),
        aboveButtons: isCompletedState.value
            ? null
            : Padding(
                padding: .only(top: 16),
                child: ChapterPositionSelectorHeading(
                  selectorState: selectorState,
                  onSelect: selectReference,
                  forceVerseNum: true,
                  showShadow: false,
                  color: Colors.transparent,
                ),
              ),
        buttonsBuilder: (context) => [
          if (isCompletedState.value)
            StyledRectButton.secondary(
              label: 'Reset'.toText(),
              onPressed: () {
                isCompletedState.value = false;
                selectorState.value = SelectorState(focus: .book);
              },
            ),
        ],
      ),
    );
  }
}
