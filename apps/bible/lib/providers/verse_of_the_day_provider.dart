import 'package:bible/providers/user_provider.dart';
import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:utils_core/utils_core.dart';

part 'verse_of_the_day_provider.g.dart';

@Riverpod(keepAlive: true)
List<VerseSelection> verseOfTheDaySelections(Ref ref) => throw UnimplementedError();

@riverpod
VerseSelection todayVerseOfTheDaySelection(Ref ref) =>
    ref.watch(verseOfTheDaySelectionsProvider)[getVerseOfTheDayIndex(.now())];

@riverpod
Future<VerseOfTheDay> verseOfTheDay(Ref ref) async {
  final passage = ref.watch(todayVerseOfTheDaySelectionProvider);
  final user = ref.watch(userProvider);
  final selectedTranslation = user.getTranslationFor(passage.references.first.book);

  final (translation, text) =
      await guardAsync(
        () async => (
          selectedTranslation,
          await ref.watch(verseSelectionTextProvider(selection: passage, translation: selectedTranslation).future),
        ),
      ) ??
      (
        user.studyTranslation,
        await ref.watch(verseSelectionTextProvider(selection: passage, translation: user.studyTranslation).future),
      );

  return VerseOfTheDay(selection: passage, translation: translation, text: text);
}

class VerseOfTheDay {
  final VerseSelection selection;
  final BibleTranslation translation;
  final String text;

  VerseOfTheDay({required this.selection, required this.translation, required this.text});

  String format() => '${selection.format()} ${translation.title()}\n$text';
}

int getVerseOfTheDayIndex(DateTime localDate) =>
    DateTime.utc(2000, localDate.month, localDate.day).difference(.utc(2000, 1, 1)).inDays;
