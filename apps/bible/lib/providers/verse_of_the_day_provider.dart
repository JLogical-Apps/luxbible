import 'package:bible/providers/user_provider.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
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
FutureOr<VerseOfTheDay> verseOfTheDayForDate(Ref ref, {required DateTime date}) {
  final passage = ref.watch(verseOfTheDaySelectionsProvider)[getVerseOfTheDayIndex(date)];
  final user = ref.watch(userProvider);
  final selectedTranslation = user.getTranslationFor(passage.references.first.book);

  final (translation, text) =
      guard(
        () => (
          selectedTranslation,
          ref.watch(verseSelectionTextProvider(selection: passage, translation: selectedTranslation)).requireValue,
        ),
      ) ??
      (
        user.studyTranslation,
        ref.watch(verseSelectionTextProvider(selection: passage, translation: user.studyTranslation)).requireValue,
      );

  return VerseOfTheDay(selection: passage, translation: translation, text: text);
}

@riverpod
Future<VerseOfTheDay> verseOfTheDay(Ref ref) {
  ref.invalidateDaily();
  return ref.watch(verseOfTheDayForDateProvider(date: .now().withoutTime()).future);
}

Future<Map<DateTime, VerseOfTheDay>> resolveVerseOfTheDayHorizon(
  Ref ref, {
  required DateTime start,
  required int count,
}) => start
    .getFollowingDates(count: count)
    .map(
      (date) async => MapEntry(date, await guardAsync(() => ref.read(verseOfTheDayForDateProvider(date: date).future))),
    )
    .waitToMap
    .then((horizon) => horizon.withoutNullValues);

class VerseOfTheDay {
  final VerseSelection selection;
  final BibleTranslation translation;
  final String text;

  VerseOfTheDay({required this.selection, required this.translation, required this.text});

  String format() => '${selection.format()} ${translation.title()}\n$text';
}

int getVerseOfTheDayIndex(DateTime localDate) =>
    DateTime.utc(2000, localDate.month, localDate.day).difference(.utc(2000, 1, 1)).inDays;
