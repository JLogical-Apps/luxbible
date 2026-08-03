import 'package:bible/models/annotation.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_bible_provider.g.dart';

@Riverpod(keepAlive: true)
FutureOr<Bible> studyBible(Ref ref) {
  final user = ref.watch(userProvider);
  return ref.watch(localBibleProvider(translation: user.studyTranslation)).requireValue;
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
