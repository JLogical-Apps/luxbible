// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_bible_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(audioBibleHandler)
final audioBibleHandlerProvider = AudioBibleHandlerProvider._();

final class AudioBibleHandlerProvider
    extends
        $FunctionalProvider<
          AudioBibleHandler,
          AudioBibleHandler,
          AudioBibleHandler
        >
    with $Provider<AudioBibleHandler> {
  AudioBibleHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioBibleHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioBibleHandlerHash();

  @$internal
  @override
  $ProviderElement<AudioBibleHandler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AudioBibleHandler create(Ref ref) {
    return audioBibleHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AudioBibleHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AudioBibleHandler>(value),
    );
  }
}

String _$audioBibleHandlerHash() => r'31afdaaf95e858333197535c5fd93a5e647b85ba';

@ProviderFor(audioBiblePosition)
final audioBiblePositionProvider = AudioBiblePositionProvider._();

final class AudioBiblePositionProvider
    extends
        $FunctionalProvider<AsyncValue<Duration>, Duration, Stream<Duration>>
    with $FutureModifier<Duration>, $StreamProvider<Duration> {
  AudioBiblePositionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioBiblePositionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioBiblePositionHash();

  @$internal
  @override
  $StreamProviderElement<Duration> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Duration> create(Ref ref) {
    return audioBiblePosition(ref);
  }
}

String _$audioBiblePositionHash() =>
    r'e8eebed54303b9662f31c7a517bf254e3ab2f540';

@ProviderFor(audioBibleDuration)
final audioBibleDurationProvider = AudioBibleDurationProvider._();

final class AudioBibleDurationProvider
    extends
        $FunctionalProvider<AsyncValue<Duration?>, Duration?, Stream<Duration?>>
    with $FutureModifier<Duration?>, $StreamProvider<Duration?> {
  AudioBibleDurationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioBibleDurationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioBibleDurationHash();

  @$internal
  @override
  $StreamProviderElement<Duration?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Duration?> create(Ref ref) {
    return audioBibleDuration(ref);
  }
}

String _$audioBibleDurationHash() =>
    r'd6be3f7beb5e3281b77373b3d31c15c435dc02bc';

@ProviderFor(audioBiblePlayerState)
final audioBiblePlayerStateProvider = AudioBiblePlayerStateProvider._();

final class AudioBiblePlayerStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<PlayerState>,
          PlayerState,
          Stream<PlayerState>
        >
    with $FutureModifier<PlayerState>, $StreamProvider<PlayerState> {
  AudioBiblePlayerStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioBiblePlayerStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioBiblePlayerStateHash();

  @$internal
  @override
  $StreamProviderElement<PlayerState> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<PlayerState> create(Ref ref) {
    return audioBiblePlayerState(ref);
  }
}

String _$audioBiblePlayerStateHash() =>
    r'cf769f4d1edb9c72fa73c80c5c59f634c941428b';

@ProviderFor(isAudioBiblePlaying)
final isAudioBiblePlayingProvider = IsAudioBiblePlayingProvider._();

final class IsAudioBiblePlayingProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsAudioBiblePlayingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isAudioBiblePlayingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isAudioBiblePlayingHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isAudioBiblePlaying(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isAudioBiblePlayingHash() =>
    r'7947cfb894303fb511adeb94b6d2e7328c003b24';

@ProviderFor(AudioBibleTimer)
final audioBibleTimerProvider = AudioBibleTimerProvider._();

final class AudioBibleTimerProvider
    extends $NotifierProvider<AudioBibleTimer, DateTime?> {
  AudioBibleTimerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioBibleTimerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioBibleTimerHash();

  @$internal
  @override
  AudioBibleTimer create() => AudioBibleTimer();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime?>(value),
    );
  }
}

String _$audioBibleTimerHash() => r'100474d39a3453e487fb7484336d491e1549ea13';

abstract class _$AudioBibleTimer extends $Notifier<DateTime?> {
  DateTime? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DateTime?, DateTime?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime?, DateTime?>,
              DateTime?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(audioAssetLoader)
final audioAssetLoaderProvider = AudioAssetLoaderProvider._();

final class AudioAssetLoaderProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  AudioAssetLoaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioAssetLoaderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioAssetLoaderHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return audioAssetLoader(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$audioAssetLoaderHash() => r'629e50e5e90aa6d66b625df30e214bba11b5eac6';

@ProviderFor(AudioBible)
final audioBibleProvider = AudioBibleProvider._();

final class AudioBibleProvider
    extends $AsyncNotifierProvider<AudioBible, AudioBibleState> {
  AudioBibleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioBibleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioBibleHash();

  @$internal
  @override
  AudioBible create() => AudioBible();
}

String _$audioBibleHash() => r'4d7d8bf06c9b90f7ee61caf1675fa5fff86c7cfd';

abstract class _$AudioBible extends $AsyncNotifier<AudioBibleState> {
  FutureOr<AudioBibleState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AudioBibleState>, AudioBibleState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AudioBibleState>, AudioBibleState>,
              AsyncValue<AudioBibleState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
