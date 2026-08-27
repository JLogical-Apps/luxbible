import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:memory/models/activity_plan.dart';
import 'package:memory/ui/widgets/phrase_text.dart';
import 'package:style/style.dart';

class PhraseReadBuilder extends HookConsumerWidget {
  final PhraseReadActivityPlan plan;

  const PhraseReadBuilder({super.key, required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verses = ref.watch(verseSelectionVersesProvider(translation: .bsb, selection: plan.passage)).value;
    if (verses == null) {
      return SizedBox.shrink();
    }

    final phrases = verses.expand((verse) => Phrase.fromVerse(verse)).toList();

    final visibleIndexState = useState(0);

    return GestureDetector(
      onTap: () => visibleIndexState.value++,
      child: StyledListView(
        padding: .all(16),
        children: [
          ...phrases.mapIndexed(
            (phraseIndex, phrase) => StyledSizeAndFade.showHide(
              key: ValueKey(phraseIndex),
              show: visibleIndexState.value >= phraseIndex,
              child: Padding(
                padding: .only(bottom: 16),
                child: Align(alignment: .centerLeft, child: PhraseText.phrase(phrase)),
              ),
            ),
          ),
          gapH16,
          AnimatedCrossFade(
            duration: Duration(milliseconds: 300),
            crossFadeState: visibleIndexState.value + 1 < phrases.length ? .showFirst : .showSecond,
            firstChild: Center(child: Text('Tap to reveal the next phrase', style: context.textStyle.labelSm.subtle())),
            secondChild: StyledRectButton.secondary(
              label: 'Reset'.toText(),
              onPressed: () => visibleIndexState.value = 0,
            ),
          ),
        ],
      ),
    );
  }
}
