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
    r'0e78356c0aa0ff416b28b0163c6c36cee47786ad';

@ProviderFor(verseOfTheDayForDate)
final verseOfTheDayForDateProvider = VerseOfTheDayForDateFamily._();

final class VerseOfTheDayForDateProvider
    extends
        $FunctionalProvider<
          AsyncValue<VerseOfTheDay>,
          VerseOfTheDay,
          FutureOr<VerseOfTheDay>
        >
    with $FutureModifier<VerseOfTheDay>, $FutureProvider<VerseOfTheDay> {
  VerseOfTheDayForDateProvider._({
    required VerseOfTheDayForDateFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'verseOfTheDayForDateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$verseOfTheDayForDateHash();

  @override
  String toString() {
    return r'verseOfTheDayForDateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<VerseOfTheDay> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VerseOfTheDay> create(Ref ref) {
    final argument = this.argument as DateTime;
    return verseOfTheDayForDate(ref, date: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VerseOfTheDayForDateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$verseOfTheDayForDateHash() =>
    r'1f1a2984bad5653d43d8ab570153fa0bcc7a883b';

final class VerseOfTheDayForDateFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<VerseOfTheDay>, DateTime> {
  VerseOfTheDayForDateFamily._()
    : super(
        retry: null,
        name: r'verseOfTheDayForDateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VerseOfTheDayForDateProvider call({required DateTime date}) =>
      VerseOfTheDayForDateProvider._(argument: date, from: this);

  @override
  String toString() => r'verseOfTheDayForDateProvider';
}

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

String _$verseOfTheDayHash() => r'11e6795a3b690277abc2a8cd92c9e491756d875f';
