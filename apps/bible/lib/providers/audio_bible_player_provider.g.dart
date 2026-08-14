// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_bible_player_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(audioBibleNativePlayer)
final audioBibleNativePlayerProvider = AudioBibleNativePlayerProvider._();

final class AudioBibleNativePlayerProvider
    extends
        $FunctionalProvider<
          AsyncValue<AudioBibleNativePlayerState>,
          AudioBibleNativePlayerState,
          Stream<AudioBibleNativePlayerState>
        >
    with
        $FutureModifier<AudioBibleNativePlayerState>,
        $StreamProvider<AudioBibleNativePlayerState> {
  AudioBibleNativePlayerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioBibleNativePlayerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioBibleNativePlayerHash();

  @$internal
  @override
  $StreamProviderElement<AudioBibleNativePlayerState> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<AudioBibleNativePlayerState> create(Ref ref) {
    return audioBibleNativePlayer(ref);
  }
}

String _$audioBibleNativePlayerHash() =>
    r'81255575d1318a397044ef1a007d808294e1d85e';

@ProviderFor(audioBiblePlayer)
final audioBiblePlayerProvider = AudioBiblePlayerFamily._();

final class AudioBiblePlayerProvider
    extends
        $FunctionalProvider<
          AudioBiblePlayerState,
          AudioBiblePlayerState,
          AudioBiblePlayerState
        >
    with $Provider<AudioBiblePlayerState> {
  AudioBiblePlayerProvider._({
    required AudioBiblePlayerFamily super.from,
    required AudioBibleContext super.argument,
  }) : super(
         retry: null,
         name: r'audioBiblePlayerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$audioBiblePlayerHash();

  @override
  String toString() {
    return r'audioBiblePlayerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<AudioBiblePlayerState> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AudioBiblePlayerState create(Ref ref) {
    final argument = this.argument as AudioBibleContext;
    return audioBiblePlayer(ref, context: argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AudioBiblePlayerState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AudioBiblePlayerState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AudioBiblePlayerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$audioBiblePlayerHash() => r'8c78f673ef35a4f76965d35b72c2b91c06adb868';

final class AudioBiblePlayerFamily extends $Family
    with $FunctionalFamilyOverride<AudioBiblePlayerState, AudioBibleContext> {
  AudioBiblePlayerFamily._()
    : super(
        retry: null,
        name: r'audioBiblePlayerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AudioBiblePlayerProvider call({required AudioBibleContext context}) =>
      AudioBiblePlayerProvider._(argument: context, from: this);

  @override
  String toString() => r'audioBiblePlayerProvider';
}

@ProviderFor(audioBibleSpokenReference)
final audioBibleSpokenReferenceProvider = AudioBibleSpokenReferenceFamily._();

final class AudioBibleSpokenReferenceProvider
    extends $FunctionalProvider<Reference?, Reference?, Reference?>
    with $Provider<Reference?> {
  AudioBibleSpokenReferenceProvider._({
    required AudioBibleSpokenReferenceFamily super.from,
    required AudioBibleContext super.argument,
  }) : super(
         retry: null,
         name: r'audioBibleSpokenReferenceProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$audioBibleSpokenReferenceHash();

  @override
  String toString() {
    return r'audioBibleSpokenReferenceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Reference?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Reference? create(Ref ref) {
    final argument = this.argument as AudioBibleContext;
    return audioBibleSpokenReference(ref, context: argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Reference? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Reference?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AudioBibleSpokenReferenceProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$audioBibleSpokenReferenceHash() =>
    r'a1925f2a1e57ef818ca1fd5282ed1ecba203181a';

final class AudioBibleSpokenReferenceFamily extends $Family
    with $FunctionalFamilyOverride<Reference?, AudioBibleContext> {
  AudioBibleSpokenReferenceFamily._()
    : super(
        retry: null,
        name: r'audioBibleSpokenReferenceProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AudioBibleSpokenReferenceProvider call({
    required AudioBibleContext context,
  }) => AudioBibleSpokenReferenceProvider._(argument: context, from: this);

  @override
  String toString() => r'audioBibleSpokenReferenceProvider';
}
