import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:memory/ui/widgets/paragraphs_builder.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class ChapterBuilder extends HookConsumerWidget {
  final ChapterReference chapterReference;
  final BibleTranslation translation;
  final Chapter chapter;

  final VerseSelection? selection;

  const ChapterBuilder({
    super.key,
    required this.chapterReference,
    required this.translation,
    required this.chapter,
    this.selection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyByReference = useMemoized(
      () => chapterReference.references.mapToMap((reference) => MapEntry(reference, GlobalKey())),
    );

    final nextReference = chapterReference.next;
    if (nextReference != null) {
      ref.watch(chapterProvider(translation: translation, chapterReference: nextReference));
    }

    final previousReference = chapterReference.previous;
    if (previousReference != null) {
      ref.watch(chapterProvider(translation: translation, chapterReference: previousReference));
    }

    if (selection case final selection?) {
      useOneTimeEffect(
        () => WidgetsBinding.instance.addPostFrameCallback(
          (_) => keyByReference[selection.references.first]?.scrollIntoView(duration: .zero),
        ),
      );
    }

    return Column(
      crossAxisAlignment: .stretch,
      spacing: 12,
      children: [
        ParagraphsBuilder(
          paragraphs: chapter.paragraphs,
          chapterReference: chapterReference,
          translation: translation,
          underlinedReferences: selection?.references ?? [],
          keyByReference: keyByReference,
        ),
        if (translation.copyright case final copyright?)
          Text(copyright, style: context.textStyle.paragraphXs.subtle(), textAlign: .center),
      ],
    );
  }
}
