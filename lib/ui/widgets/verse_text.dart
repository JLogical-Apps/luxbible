import 'package:bible/models/bible/verse.dart';
import 'package:flutter/material.dart';

class VerseText extends StatelessWidget {
  final Verse verse;

  final String? highlightStrongId;

  const VerseText({super.key, required this.verse, this.highlightStrongId});

  @override
  Widget build(BuildContext context) {
    final highlightStrongId = this.highlightStrongId;
    return Text.rich(
      TextSpan(
        children: verse.words
            .where((word) => word.text != null)
            .map(
              (word) => TextSpan(
                text: word.text,
                style: highlightStrongId != null && word.data?.strongId == highlightStrongId
                    ? TextStyle(fontWeight: .bold)
                    : null,
              ),
            )
            .toList(),
      ),
    );
  }
}
