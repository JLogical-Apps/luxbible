import 'package:bible/functions/api_bible.dart';
import 'package:bible/functions/bible_importer.dart';
import 'package:bible/functions/youversion.dart';
import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/paragraph.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/utils/range.dart';
import 'package:bible/utils/riverpod_utils.dart';
import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:utils_core/utils_core.dart';

part 'bibles_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Bible> localBible(Ref ref, {required BibleTranslation translation}) async =>
    BibleImporter().importBible(translation: translation);

@Riverpod(keepAlive: true)
FutureOr<Bible> studyBible(Ref ref) {
  final user = ref.watch(userProvider);
  return ref.watch(localBibleProvider(translation: user.studyTranslation)).requireValue;
}

@Riverpod(keepAlive: true, retry: RiverpodUtils.noRetry)
FutureOr<Chapter> chapter(
  Ref ref, {
  required ChapterReference chapterReference,
  required BibleTranslation translation,
}) {
  final effectiveTranslation = translation.effectiveFor(chapterReference.book);
  final localBible = effectiveTranslation.isLocal
      ? ref.watch(localBibleProvider(translation: effectiveTranslation)).requireValue
      : null;

  return switch (effectiveTranslation.source) {
    LocalTranslationSource() => localBible!.getChapterByReference(chapterReference),
    YouVersionTranslationSource(:final bibleId) => YouVersion.fetchChapter(
      bibleId: bibleId,
      chapterReference: chapterReference,
    ),
    ApiBibleTranslationSource() => ApiBible.fetchChapter(
      translationSlug: translation.name,
      chapterReference: chapterReference,
    ),
  };
}

@Riverpod(keepAlive: true)
FutureOr<Verse?> verse(Ref ref, {required Reference reference, required BibleTranslation translation}) {
  if (translation.isLocal) {
    final bible = ref.watch(localBibleProvider(translation: translation)).requireValue;
    return bible.getVerseByReference(reference);
  } else {
    final chapter = ref
        .watch(chapterProvider(chapterReference: reference.toChapterReference(), translation: translation))
        .requireValue;
    return chapter.getVerseByReference(reference);
  }
}

@riverpod
FutureOr<List<Verse>> verseSelectionVerses(
  Ref ref, {
  required VerseSelection selection,
  required BibleTranslation translation,
}) {
  if (translation.isLocal) {
    final bible = ref.watch(localBibleProvider(translation: translation)).requireValue;
    return selection.references.map((reference) => bible.getVerseByReference(reference)).nonNulls.toList();
  } else {
    return selection.references
        .map((reference) => ref.watch(verseProvider(reference: reference, translation: translation)).requireValue)
        .nonNulls
        .toList();
  }
}

@riverpod
FutureOr<String> verseSelectionText(
  Ref ref, {
  required VerseSelection selection,
  required BibleTranslation translation,
}) => ref
    .watch(verseSelectionVersesProvider(translation: translation, selection: selection))
    .requireValue
    .map((verse) => verse.text)
    .join(' ');

@riverpod
FutureOr<List<Paragraph>> verseSelectionParagraphs(
  Ref ref, {
  required VerseSelection selection,
  required BibleTranslation translation,
}) => selection.references.groupListsBy((reference) => reference.toChapterReference()).mapToIterable<List<Paragraph>>((
  chapterReference,
  reference,
) {
  final chapter = ref.watch(chapterProvider(chapterReference: chapterReference, translation: translation)).requireValue;

  bool isSelected(Verse verse) => selection.references.any((reference) => reference.verseNum == verse.verseNum);

  final paragraphs = chapter.paragraphs;
  final selectedIndices = paragraphs
      .mapIndexed((index, paragraph) => paragraph is VersesParagraph && paragraph.verses.any(isSelected) ? index : null)
      .nonNulls
      .toList();
  if (selectedIndices.isEmpty) return [];

  bool sectionIntroducesShownParagraph(int index) {
    final firstVerse = paragraphs.skip(index + 1).whereType<VersesParagraph>().firstOrNull?.verses.firstOrNull;
    return firstVerse != null && isSelected(firstVerse);
  }

  var startIndex = selectedIndices.first;
  while (startIndex > 0) {
    var precedingIndex = startIndex - 1;
    while (precedingIndex >= 0 && paragraphs[precedingIndex] is BreakParagraph) {
      precedingIndex--;
    }
    if (precedingIndex >= 0 && paragraphs[precedingIndex] is SectionParagraph) {
      startIndex = precedingIndex;
    } else {
      break;
    }
  }

  return Range.generate(startIndex, selectedIndices.last)
      .map((index) {
        final paragraph = paragraphs[index];
        switch (paragraph) {
          case SectionParagraph():
            return sectionIntroducesShownParagraph(index) ? paragraph : null;
          case VersesParagraph():
            final selectedVerses = paragraph.verses.where(isSelected).toList();
            if (selectedVerses.isEmpty) return null;

            final isContinuation = selectedVerses.first != paragraph.verses.first;
            return paragraph.copyWith(
              verses: selectedVerses,
              firstVerseOffset: isContinuation ? 0 : paragraph.firstVerseOffset,
              preventIndent: selectedVerses.first != paragraph.verses.first,
            );
          case BreakParagraph():
            return paragraph;
        }
      })
      .nonNulls
      .toList();
}).flattenedToList;

@riverpod
FutureOr<String> textSelectionText(Ref ref, BibleTextSelection selection) {
  final translation = selection.translation;
  if (translation.isLocal) {
    final bible = ref.watch(localBibleProvider(translation: translation)).requireValue;
    return bible.getTextSelectionText(selection);
  } else {
    return selection
        .toVerseSelection()
        .references
        .map((reference) => ref.watch(verseProvider(reference: reference, translation: translation)).requireValue)
        .nonNulls
        .getTextSelectionText(selection);
  }
}

@riverpod
Future<String> annotationSelectionText(
  Ref ref, {
  required AnnotationSelection selection,
  required BibleTranslation translation,
}) => switch (selection) {
  VersesAnnotationSelection(:final verseSelection) => ref.watch(
    verseSelectionTextProvider(selection: verseSelection, translation: translation).future,
  ),
  TextAnnotationSelection(:final textSelection) => ref.watch(textSelectionTextProvider(textSelection).future),
};
