// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dictionary)
final dictionaryProvider = DictionaryProvider._();

final class DictionaryProvider
    extends
        $FunctionalProvider<
          Map<String, DictionaryEntry>,
          Map<String, DictionaryEntry>,
          Map<String, DictionaryEntry>
        >
    with $Provider<Map<String, DictionaryEntry>> {
  DictionaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dictionaryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dictionaryHash();

  @$internal
  @override
  $ProviderElement<Map<String, DictionaryEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<String, DictionaryEntry> create(Ref ref) {
    return dictionary(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, DictionaryEntry> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, DictionaryEntry>>(value),
    );
  }
}

String _$dictionaryHash() => r'abfce30fd882aef5e9b6e692396e8e573689825a';
