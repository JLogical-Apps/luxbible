import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:memory/models/activity_plan.dart';
import 'package:memory/utils/qwerty_keyboard.dart';
import 'package:style/style.dart';

class WordTypeBuilder extends HookConsumerWidget {
  final WordTypeActivityPlan plan;

  const WordTypeBuilder({super.key, required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bible = ref.watch(localBibleProvider(translation: .bsb)).value;
    if (bible == null) {
      return StyledLoading(loadingPadding: .all(16));
    }

    final passageWords = useMemoized(() => bible.getPassageVerses(plan.passage).expand(getWordTypeWords).toList());
    final indexedWords = passageWords
        .mapIndexed((wordIndex, word) => (word: word, typeIndex: word.firstSymbol == null ? null : wordIndex))
        .toList();
    final wordsToType = indexedWords.where((word) => word.typeIndex != null).map((word) => word.word).toList();
    final wordKeys = useMemoized(() => wordsToType.map((_) => GlobalKey()).toList());
    final cursorKeys = useMemoized(() => wordsToType.map((_) => GlobalKey()).toList());
    final wordsStackKey = useMemoized(() => GlobalKey());

    final currentIndexState = useState(0);
    final errorCountState = useState(0);
    final controller = useTextEditingController();
    final focusNode = useFocusNode();

    final cursorRectState = useState<Rect?>(null);
    final cursorBlinkController = useAnimationController(duration: Duration(milliseconds: 500));
    final cursorOpacity = useMemoized(
      () => Tween(
        begin: 1.0,
        end: 0.15,
      ).animate(CurvedAnimation(parent: cursorBlinkController, curve: Curves.easeInOutCubic)),
      [cursorBlinkController],
    );

    useEffect(() {
      cursorBlinkController.repeat(reverse: true);
      return cursorBlinkController.stop;
    }, [cursorBlinkController]);

    final isComplete = currentIndexState.value == wordsToType.length;

    usePostFrameEffect(() {
      if (isComplete) {
        focusNode.unfocus();
      } else {
        focusNode.requestFocus();
      }
    }, [isComplete]);

    usePostFrameEffect(
      () => wordKeys.elementAtOrNull(currentIndexState.value)?.scrollIntoView(duration: Duration(milliseconds: 300)),
      [currentIndexState.value],
    );

    usePostFrameEffect(() {
      final stackBox = wordsStackKey.renderBox;
      final cursorBox = cursorKeys.elementAtOrNull(currentIndexState.value)?.renderBox;
      if (stackBox == null || cursorBox == null) {
        cursorRectState.value = null;
        return;
      }

      final cursorOffset = cursorBox.localToGlobal(.zero, ancestor: stackBox);
      cursorRectState.value = cursorOffset & cursorBox.size;
    }, [currentIndexState.value, MediaQuery.sizeOf(context), MediaQuery.textScalerOf(context)]);

    void handleInput(String input) {
      controller.clear();
      if (input.isEmpty || isComplete) return;

      final enteredLetter = input[0];
      final expectedLetter = wordsToType[currentIndexState.value].firstSymbol!;
      if (enteredLetter.toLowerCase() == expectedLetter.toLowerCase()) {
        currentIndexState.value++;
      } else if (isQwertyKeyClose(enteredLetter, expectedLetter)) {
        context.showStyledSnackbar(message: 'That was close enough.'.toText(), duration: Duration(seconds: 1));
        currentIndexState.value++;
      } else {
        errorCountState.value++;
      }
    }

    return GestureDetector(
      onTap: () {
        if (!isComplete) focusNode.requestFocus();
      },
      child: StyledTransitionBuilder(
        value: errorCountState.value,
        builder: (context, value, child) => Stack(
          children: [
            StyledDock(
              shrinkWrap: false,
              childrenPadding: .all(16),
              children: [
                Offstage(
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    autofocus: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    textCapitalization: .none,
                    onChanged: handleInput,
                  ),
                ),
                Stack(
                  key: wordsStackKey,
                  children: [
                    Wrap(
                      spacing: 6,
                      runSpacing: 8,
                      children: indexedWords.map((indexedWord) {
                        Widget animatedText(String text, {required bool isVisible}) => AnimatedOpacity(
                          opacity: isVisible ? 1 : 0,
                          duration: Duration(milliseconds: 140),
                          curve: Curves.easeInOutCubic,
                          child: Text(
                            text,
                            style: context.textStyle.paragraphLg.copyWith(
                              color: indexedWord.word.redLetters ? context.colors.red.dark : null,
                            ),
                          ),
                        );

                        return Row(
                          key: indexedWord.typeIndex == null ? null : wordKeys[indexedWord.typeIndex!],
                          mainAxisSize: .min,
                          children: [
                            animatedText(
                              indexedWord.word.leadingText,
                              isVisible:
                                  indexedWord.typeIndex == null || currentIndexState.value >= indexedWord.typeIndex!,
                            ),
                            KeyedSubtree(
                              key: indexedWord.typeIndex == null ? null : cursorKeys[indexedWord.typeIndex!],
                              child: animatedText(
                                indexedWord.word.afterLeadingText,
                                isVisible:
                                    indexedWord.typeIndex == null || currentIndexState.value > indexedWord.typeIndex!,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                    if (cursorRectState.value case final cursorRect?)
                      AnimatedPositioned(
                        left: cursorRect.left,
                        top: cursorRect.top,
                        width: 2,
                        height: cursorRect.height,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeOutQuad,
                        child: FadeTransition(
                          opacity: cursorOpacity,
                          child: Padding(
                            padding: .symmetric(vertical: 2),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: context.colors.contentPrimary,
                                borderRadius: .circular(999),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
              buttonsColor: Color.lerp(context.colors.surfacePrimary, context.colors.surfaceCritical, value),
              aboveButtons: isComplete
                  ? null
                  : Padding(
                      padding: .symmetric(horizontal: 16, vertical: 12),
                      child: Center(
                        child: Text('Type the first letter of each word', style: context.textStyle.labelSm.subtle()),
                      ),
                    ),
              buttonsBuilder: (context) => [
                if (isComplete)
                  StyledRectButton.secondary(label: 'Reset'.toText(), onPressed: () => currentIndexState.value = 0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<WordTypeWord> getWordTypeWords(Verse verse) => verse.words
    .expand(
      (word) => RegExp(
        r'\S+',
      ).allMatches(word.text ?? '').map((match) => WordTypeWord(text: match.group(0)!, redLetters: word.redLetters)),
    )
    .toList();

class WordTypeWord {
  final String text;
  final bool redLetters;

  WordTypeWord({required this.text, required this.redLetters});

  RegExpMatch? get firstSymbolMatch => RegExp('[a-zA-Z0-9]').firstMatch(text);
  String? get firstSymbol => firstSymbolMatch?.group(0);
  String get leadingText => text.substring(0, firstSymbolMatch?.start ?? text.length);
  String get afterLeadingText => text.substring(firstSymbolMatch?.start ?? 0);
}
