// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_navigation_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bibleNavigationService)
final bibleNavigationServiceProvider = BibleNavigationServiceProvider._();

final class BibleNavigationServiceProvider
    extends
        $FunctionalProvider<
          BibleNavigationService,
          BibleNavigationService,
          BibleNavigationService
        >
    with $Provider<BibleNavigationService> {
  BibleNavigationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bibleNavigationServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bibleNavigationServiceHash();

  @$internal
  @override
  $ProviderElement<BibleNavigationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BibleNavigationService create(Ref ref) {
    return bibleNavigationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BibleNavigationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BibleNavigationService>(value),
    );
  }
}

String _$bibleNavigationServiceHash() =>
    r'5dd49eecfd569baf25aeb8e14c970540ddbb5cf8';
