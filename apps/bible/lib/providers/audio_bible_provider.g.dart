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
    r'3827e2f6b54f0543cc775a3c1fa5869957853b07';

@ProviderFor(audioBible)
final audioBibleProvider = AudioBibleFamily._();

final class AudioBibleProvider
    extends
        $FunctionalProvider<
          AudioBibleContextState?,
          AudioBibleContextState?,
          AudioBibleContextState?
        >
    with $Provider<AudioBibleContextState?> {
  AudioBibleProvider._({
    required AudioBibleFamily super.from,
    required AudioBibleContext super.argument,
  }) : super(
         retry: null,
         name: r'audioBibleProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$audioBibleHash();

  @override
  String toString() {
    return r'audioBibleProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<AudioBibleContextState?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AudioBibleContextState? create(Ref ref) {
    final argument = this.argument as AudioBibleContext;
    return audioBible(ref, context: argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AudioBibleContextState? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AudioBibleContextState?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AudioBibleProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$audioBibleHash() => r'13a1273de93409feff6d35a606a20a4b6e0ce277';

final class AudioBibleFamily extends $Family
    with $FunctionalFamilyOverride<AudioBibleContextState?, AudioBibleContext> {
  AudioBibleFamily._()
    : super(
        retry: null,
        name: r'audioBibleProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AudioBibleProvider call({required AudioBibleContext context}) =>
      AudioBibleProvider._(argument: context, from: this);

  @override
  String toString() => r'audioBibleProvider';
}

@ProviderFor(AudioBibleController)
final audioBibleControllerProvider = AudioBibleControllerProvider._();

final class AudioBibleControllerProvider
    extends $NotifierProvider<AudioBibleController, AudioBibleState> {
  AudioBibleControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioBibleControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioBibleControllerHash();

  @$internal
  @override
  AudioBibleController create() => AudioBibleController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AudioBibleState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AudioBibleState>(value),
    );
  }
}

String _$audioBibleControllerHash() =>
    r'8dc5066ea302577cb7d30d1d66dfde28819bbafd';

abstract class _$AudioBibleController extends $Notifier<AudioBibleState> {
  AudioBibleState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AudioBibleState, AudioBibleState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AudioBibleState, AudioBibleState>,
              AudioBibleState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
