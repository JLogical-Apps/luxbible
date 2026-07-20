// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_bible_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(audioBiblePlayer)
final audioBiblePlayerProvider = AudioBiblePlayerProvider._();

final class AudioBiblePlayerProvider
    extends $FunctionalProvider<AudioPlayer, AudioPlayer, AudioPlayer>
    with $Provider<AudioPlayer> {
  AudioBiblePlayerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioBiblePlayerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioBiblePlayerHash();

  @$internal
  @override
  $ProviderElement<AudioPlayer> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AudioPlayer create(Ref ref) {
    return audioBiblePlayer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AudioPlayer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AudioPlayer>(value),
    );
  }
}

String _$audioBiblePlayerHash() => r'8757b98da3cac5e9af39601bd2b6233885b91552';

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
    r'008b9d17ba2956f0f270199e80d38c0c4eb2528e';

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
    r'5277cdc8ae7b02e60ae4b21a777f75ddc358b8d3';

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
    r'867f2e8c6f1d1c07fdb24f1d6495fbfa9a8b2b70';

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

String _$audioAssetLoaderHash() => r'980ef28fde6497d7a11b101aad2144bdffacf99f';

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

String _$audioBibleHash() => r'60e22639c1df480ebc237900984a4fca4d368269';

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
