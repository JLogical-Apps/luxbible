import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class PhraseText extends StatelessWidget {
  final List<Phrase> phrases;

  const PhraseText({super.key, required this.phrases});
  PhraseText.phrase({super.key, required Phrase phrase}) : phrases = [phrase];

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: context.textStyle.paragraphLg,
        children: phrases
            .expandIndexed(
              (index, phrase) => [
                if (index > 0) TextSpan(text: ' '),
                ...phrase.words
                    .where((word) => word.text != null)
                    .map(
                      (word) => TextSpan(
                        text: word.text!,
                        style: TextStyle(color: word.redLetters ? context.colors.red.dark : null),
                      ),
                    ),
              ],
            )
            .toList(),
      ),
    );
  }
}
