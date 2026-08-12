// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lux_reader_configuration_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(luxReaderConfiguration)
final luxReaderConfigurationProvider = LuxReaderConfigurationProvider._();

final class LuxReaderConfigurationProvider
    extends
        $FunctionalProvider<
          LuxReaderConfiguration,
          LuxReaderConfiguration,
          LuxReaderConfiguration
        >
    with $Provider<LuxReaderConfiguration> {
  LuxReaderConfigurationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'luxReaderConfigurationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$luxReaderConfigurationHash();

  @$internal
  @override
  $ProviderElement<LuxReaderConfiguration> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LuxReaderConfiguration create(Ref ref) {
    return luxReaderConfiguration(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LuxReaderConfiguration value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LuxReaderConfiguration>(value),
    );
  }
}

String _$luxReaderConfigurationHash() =>
    r'50947b367156852141237b88209e5cdc809573cd';
