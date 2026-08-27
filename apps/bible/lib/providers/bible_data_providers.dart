import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bible_data_providers.g.dart';

@Riverpod(keepAlive: true)
FutureOr<Book> localBook(Ref ref, {required BibleTranslation translation, required BookType book}) =>
    BibleImporter().importBook(translation: translation, book: book);

final bibleDataOverrides = [
  localBibleProvider.overrideWith(
    (ref, translation) async => Bible(
      translation: translation,
      books: await BookType.values
          .where(translation.containsBook)
          .map((book) => ref.watch(localBookProvider(translation: translation, book: book).future))
          .wait,
    ),
  ),
  chapterProvider.overrideWith(
    (ref, argument) async => switch (argument.translation.source) {
      LocalTranslationSource() => (await ref.watch(
        localBookProvider(translation: argument.translation, book: argument.chapterReference.book).future,
      )).chapters[argument.chapterReference.chapterNum - 1],
      _ => await getOnlineChapter(
        ref: ref,
        translation: argument.translation,
        chapterReference: argument.chapterReference,
      ),
    },
  ),
];
