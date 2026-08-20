// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_of_the_day_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(verseOfTheDaySelections)
final verseOfTheDaySelectionsProvider = VerseOfTheDaySelectionsProvider._();

final class VerseOfTheDaySelectionsProvider
    extends
        $FunctionalProvider<
          List<VerseSelection>,
          List<VerseSelection>,
          List<VerseSelection>
        >
    with $Provider<List<VerseSelection>> {
  VerseOfTheDaySelectionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verseOfTheDaySelectionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verseOfTheDaySelectionsHash();

  @$internal
  @override
  $ProviderElement<List<VerseSelection>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<VerseSelection> create(Ref ref) {
    return verseOfTheDaySelections(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<VerseSelection> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<VerseSelection>>(value),
    );
  }
}

String _$verseOfTheDaySelectionsHash() =>
    r'f4e6c88cdd20a097210ab798c72bab5c93a1d0f2';

@ProviderFor(todayVerseOfTheDaySelection)
final todayVerseOfTheDaySelectionProvider =
    TodayVerseOfTheDaySelectionProvider._();

final class TodayVerseOfTheDaySelectionProvider
    extends $FunctionalProvider<VerseSelection, VerseSelection, VerseSelection>
    with $Provider<VerseSelection> {
  TodayVerseOfTheDaySelectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayVerseOfTheDaySelectionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayVerseOfTheDaySelectionHash();

  @$internal
  @override
  $ProviderElement<VerseSelection> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VerseSelection create(Ref ref) {
    return todayVerseOfTheDaySelection(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VerseSelection value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VerseSelection>(value),
    );
  }
}

String _$todayVerseOfTheDaySelectionHash() =>
    r'96f3f5ff236973b1fb436747e9fbdb33fceaff3f';

@ProviderFor(verseOfTheDay)
final verseOfTheDayProvider = VerseOfTheDayProvider._();

final class VerseOfTheDayProvider
    extends
        $FunctionalProvider<
          AsyncValue<VerseOfTheDay>,
          VerseOfTheDay,
          FutureOr<VerseOfTheDay>
        >
    with $FutureModifier<VerseOfTheDay>, $FutureProvider<VerseOfTheDay> {
  VerseOfTheDayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verseOfTheDayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verseOfTheDayHash();

  @$internal
  @override
  $FutureProviderElement<VerseOfTheDay> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VerseOfTheDay> create(Ref ref) {
    return verseOfTheDay(ref);
  }
}

String _$verseOfTheDayHash() => r'ba96f3afceae1821b81d59f859e33630a3f357a8';
