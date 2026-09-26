import 'package:bible/models/verse_of_the_day_widget_payload.dart';
import 'package:bible/providers/language_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/providers/verse_of_the_day_provider.dart';
import 'package:bible/services/verse_of_the_day_widget_service.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:utils_core/utils_core.dart';

part 'verse_of_the_day_widget_provider.g.dart';

const verseOfTheDayWidgetHorizonDays = 14;

@Riverpod(keepAlive: true)
Future<VerseOfTheDayWidgetPayload> verseOfTheDayWidgetPayload(Ref ref) async {
  ref.invalidateDaily();
  ref.watch(userProvider.select((user) => user.translationsSelection));
  ref.watch(languageProvider);

  final horizon = await resolveVerseOfTheDayHorizon(ref, start: DateTime.now(), count: verseOfTheDayWidgetHorizonDays);

  return VerseOfTheDayWidgetPayload(
    entries: horizon
        .mapToIterable(
          (date, verseOfTheDay) => VerseOfTheDayWidgetEntry(
            date: date,
            reference: verseOfTheDay.selection.format(),
            translation: verseOfTheDay.translation.title(),
            text: verseOfTheDay.text,
          ),
        )
        .toList(),
  );
}

@Riverpod(keepAlive: true)
void verseOfTheDayWidgetSynchronizer(Ref ref) {
  ref.listen(
    verseOfTheDayWidgetPayloadProvider,
    (previous, next) => next.whenData((payload) => ref.read(verseOfTheDayWidgetServiceProvider).synchronize(payload)),
    fireImmediately: true,
  );
}
