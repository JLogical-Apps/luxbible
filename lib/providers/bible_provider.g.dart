// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bible)
const bibleProvider = BibleProvider._();

final class BibleProvider extends $FunctionalProvider<Bible, Bible, Bible>
    with $Provider<Bible> {
  const BibleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bibleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bibleHash();

  @$internal
  @override
  $ProviderElement<Bible> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Bible create(Ref ref) {
    return bible(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Bible value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Bible>(value),
    );
  }
}

String _$bibleHash() => r'c5d41a89d774e04910365be858aa91c054acf1c5';
