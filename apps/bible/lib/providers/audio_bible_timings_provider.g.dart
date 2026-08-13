// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_bible_timings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(audioBibleTimings)
final audioBibleTimingsProvider = AudioBibleTimingsProvider._();

final class AudioBibleTimingsProvider
    extends
        $FunctionalProvider<
          Map<BibleTranslation, Map<Reference, AudioBibleVerseTiming>>,
          Map<BibleTranslation, Map<Reference, AudioBibleVerseTiming>>,
          Map<BibleTranslation, Map<Reference, AudioBibleVerseTiming>>
        >
    with
        $Provider<
          Map<BibleTranslation, Map<Reference, AudioBibleVerseTiming>>
        > {
  AudioBibleTimingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioBibleTimingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioBibleTimingsHash();

  @$internal
  @override
  $ProviderElement<Map<BibleTranslation, Map<Reference, AudioBibleVerseTiming>>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  Map<BibleTranslation, Map<Reference, AudioBibleVerseTiming>> create(Ref ref) {
    return audioBibleTimings(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    Map<BibleTranslation, Map<Reference, AudioBibleVerseTiming>> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<
            Map<BibleTranslation, Map<Reference, AudioBibleVerseTiming>>
          >(value),
    );
  }
}

String _$audioBibleTimingsHash() => r'087d2706a4650c13dc17929408d902ca6414d032';
