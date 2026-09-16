import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class PassageSelectionPreview extends ConsumerWidget {
  final ChapterPosition position;
  final PassageSelectionController selectionController;

  const PassageSelectionPreview({super.key, required this.position, required this.selectionController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reference = position.reference;
    final translation = ref.watch(luxReaderConfigurationProvider).translationForChapter(reference);
    final chapter = ref.watch(chapterProvider(translation: translation, chapterReference: reference)).value;
    return StyledLoading(
      loadingPadding: .all(16),
      child: chapter == null
          ? null
          : ChapterBuilder(
              key: ValueKey(position),
              chapterReference: reference,
              chapter: chapter,
              selection: selectionController,
              padding: .all(16),
              scrollToSelection: position.getReference()?.mapIfNonNull((reference) => .reference(reference)),
            ),
    );
  }
}
