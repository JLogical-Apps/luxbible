import 'package:bible/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';
import 'package:utils_core/utils_core.dart';

class PassageListItem extends ConsumerWidget {
  final VerseSelection verseSelection;
  final int? maxLines;
  final Function() onPressed;

  const PassageListItem({super.key, required this.verseSelection, this.maxLines, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final book = verseSelection.references.first.book;
    final translation = user.translation.isOnline ? user.studyTranslation : user.getTranslationFor(book);

    // A line-limited preview never reaches past the first chapter, so a long passage only loads its first.
    final previewSelection = maxLines == null ? verseSelection : verseSelection.splitByChapter().first;
    final verses = ref.watch(verseSelectionVersesProvider(translation: translation, selection: previewSelection)).value;

    return StyledListItem.navigation(
      title: Row(
        spacing: 4,
        children: [
          verseSelection.format().toText(),
          if (user.translation.isLocal && !user.translation.containsBook(book))
            StyledTag.sm(child: translation.title().toText()),
        ],
      ),
      subtitle: StyledLoading(
        child: verses?.mapIfNonNull(
          (verses) => VerseText(redLetters: user.themeLayout.redLetters, verses: verses, maxLines: maxLines),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
