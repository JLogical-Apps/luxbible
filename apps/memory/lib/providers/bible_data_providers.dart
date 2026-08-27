import 'package:lux/lux.dart';

final bibleDataOverrides = [
  localBibleProvider.overrideWith((ref, translation) => BibleImporter().importBible(translation: translation)),
  chapterProvider.overrideWith(
    (ref, argument) => switch (argument.translation.source) {
      LocalTranslationSource() =>
        ref
            .watch(localBibleProvider(translation: argument.translation))
            .requireValue
            .getChapterByReference(argument.chapterReference),
      _ => throw UnimplementedError(),
    },
  ),
];
