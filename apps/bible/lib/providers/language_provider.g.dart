// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(language)
final languageProvider = LanguageProvider._();

final class LanguageProvider
    extends $FunctionalProvider<Language, Language, Language>
    with $Provider<Language> {
  LanguageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'languageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$languageHash();

  @$internal
  @override
  $ProviderElement<Language> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Language create(Ref ref) {
    return language(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Language value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Language>(value),
    );
  }
}

String _$languageHash() => r'ac73ce9f2e39ed0894faa5f94d212f3bece5e1d0';
