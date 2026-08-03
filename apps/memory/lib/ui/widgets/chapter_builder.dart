import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:memory/ui/widgets/paragraphs_builder.dart';
import 'package:style/style.dart';

class ChapterBuilder extends ConsumerWidget {
  final ChapterReference chapterReference;
  final BibleTranslation translation;
  final Chapter chapter;

  const ChapterBuilder({super.key, required this.chapterReference, required this.translation, required this.chapter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nextReference = chapterReference.next;
    if (nextReference != null) {
      ref.watch(chapterProvider(translation: translation, chapterReference: nextReference));
    }

    final previousReference = chapterReference.previous;
    if (previousReference != null) {
      ref.watch(chapterProvider(translation: translation, chapterReference: previousReference));
    }

    return Column(
      crossAxisAlignment: .stretch,
      spacing: 12,
      children: [
        ParagraphsBuilder(paragraphs: chapter.paragraphs, chapterReference: chapterReference, translation: translation),
        if (translation.copyright case final copyright?)
          Text(copyright, style: context.textStyle.paragraphXs.subtle(), textAlign: .center),
      ],
    );
  }
}
