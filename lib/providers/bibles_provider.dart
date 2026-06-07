import 'package:bible/models/annotation.dart';
import 'package:bible/models/bible/bible.dart';
import 'package:bible/models/bible/bible_translation.dart';
import 'package:bible/models/bible/chapter.dart';
import 'package:bible/models/bible/verse.dart';
import 'package:bible/models/reference/bible_text_selection.dart';
import 'package:bible/models/reference/chapter_reference.dart';
import 'package:bible/models/reference/reference.dart';
import 'package:bible/models/reference/verse_selection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bibles_provider.g.dart';

@Riverpod(keepAlive: true)
List<Bible> localBibles(Ref ref) => throw UnimplementedError();

@riverpod
Bible studyBible(Ref ref) => ref.watch(localBiblesProvider).firstWhere((bible) => bible.translation == .bsb);

@Riverpod(keepAlive: true)
Future<Chapter> chapter(Ref ref, {required ChapterReference chapterReference, required BibleTranslation translation}) =>
    translation.source.getChapter(
      chapterReference: chapterReference,
      translation: translation,
      localBibles: ref.watch(localBiblesProvider),
    );

@Riverpod(keepAlive: true)
FutureOr<Verse?> verse(Ref ref, {required Reference reference, required BibleTranslation translation}) {
  if (translation.isLocal) {
    return ref
        .watch(localBiblesProvider)
        .firstWhere((bible) => bible.translation == translation)
        .getVerseByReference(reference);
  } else {
    final chapter = ref
        .watch(chapterProvider(chapterReference: reference.toChapterReference(), translation: translation))
        .requireValue;
    return chapter.getVerseByReference(reference);
  }
}

@riverpod
FutureOr<String> verseSelectionText(
  Ref ref, {
  required VerseSelection selection,
  required BibleTranslation translation,
}) {
  if (translation.isLocal) {
    return ref
        .watch(localBiblesProvider)
        .firstWhere((bible) => bible.translation == translation)
        .getVerseSelectionText(selection);
  } else {
    return selection.references
        .map((reference) => ref.watch(verseProvider(reference: reference, translation: translation)).requireValue)
        .nonNulls
        .map((verse) => verse.text)
        .join(' ');
  }
}

@riverpod
FutureOr<String> textSelectionText(Ref ref, BibleTextSelection selection) {
  final translation = selection.translation;
  if (translation.isLocal) {
    return ref
        .watch(localBiblesProvider)
        .firstWhere((bible) => bible.translation == translation)
        .getTextSelectionText(selection);
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
