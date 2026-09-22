// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_of_the_day_widget_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(verseOfTheDayWidgetPayload)
final verseOfTheDayWidgetPayloadProvider =
    VerseOfTheDayWidgetPayloadProvider._();

final class VerseOfTheDayWidgetPayloadProvider
    extends
        $FunctionalProvider<
          AsyncValue<VerseOfTheDayWidgetPayload>,
          VerseOfTheDayWidgetPayload,
          FutureOr<VerseOfTheDayWidgetPayload>
        >
    with
        $FutureModifier<VerseOfTheDayWidgetPayload>,
        $FutureProvider<VerseOfTheDayWidgetPayload> {
  VerseOfTheDayWidgetPayloadProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verseOfTheDayWidgetPayloadProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verseOfTheDayWidgetPayloadHash();

  @$internal
  @override
  $FutureProviderElement<VerseOfTheDayWidgetPayload> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VerseOfTheDayWidgetPayload> create(Ref ref) {
    return verseOfTheDayWidgetPayload(ref);
  }
}

String _$verseOfTheDayWidgetPayloadHash() =>
    r'd9e7eef8b74e11469956320d2a311940f4c8cd3a';

@ProviderFor(verseOfTheDayWidgetSynchronizer)
final verseOfTheDayWidgetSynchronizerProvider =
    VerseOfTheDayWidgetSynchronizerProvider._();

final class VerseOfTheDayWidgetSynchronizerProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  VerseOfTheDayWidgetSynchronizerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verseOfTheDayWidgetSynchronizerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verseOfTheDayWidgetSynchronizerHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return verseOfTheDayWidgetSynchronizer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$verseOfTheDayWidgetSynchronizerHash() =>
    r'7c18021aa87996fd6f175c50760102b412c94fc3';
