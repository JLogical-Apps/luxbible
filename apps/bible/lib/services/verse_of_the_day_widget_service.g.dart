// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_of_the_day_widget_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(verseOfTheDayWidgetService)
final verseOfTheDayWidgetServiceProvider =
    VerseOfTheDayWidgetServiceProvider._();

final class VerseOfTheDayWidgetServiceProvider
    extends
        $FunctionalProvider<
          VerseOfTheDayWidgetService,
          VerseOfTheDayWidgetService,
          VerseOfTheDayWidgetService
        >
    with $Provider<VerseOfTheDayWidgetService> {
  VerseOfTheDayWidgetServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verseOfTheDayWidgetServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verseOfTheDayWidgetServiceHash();

  @$internal
  @override
  $ProviderElement<VerseOfTheDayWidgetService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VerseOfTheDayWidgetService create(Ref ref) {
    return verseOfTheDayWidgetService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VerseOfTheDayWidgetService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VerseOfTheDayWidgetService>(value),
    );
  }
}

String _$verseOfTheDayWidgetServiceHash() =>
    r'1033c9bbc5080f44978d8212bfa62795a0171d28';
