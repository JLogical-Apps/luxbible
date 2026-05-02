import 'package:bible/models/bible/study/study_verse.dart';
import 'package:flutter/material.dart';

class VerseText extends StatelessWidget {
  final StudyVerse verse;

  final String? highlightStrongId;

  const VerseText({super.key, required this.verse, this.highlightStrongId});

  @override
  Widget build(BuildContext context) {
    final highlightStrongId = this.highlightStrongId;
    return Text.rich(
      TextSpan(
        children: verse.fragments
            .map(
              (fragment) => TextSpan(
                text: fragment.text,
                style: highlightStrongId != null && fragment.strongIds.contains(highlightStrongId)
                    ? TextStyle(fontWeight: FontWeight.bold)
                    : null,
              ),
            )
            .toList(),
      ),
    );
  }
}
