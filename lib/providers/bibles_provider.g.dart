// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bibles_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bibles)
final biblesProvider = BiblesProvider._();

final class BiblesProvider
    extends $FunctionalProvider<List<Bible>, List<Bible>, List<Bible>>
    with $Provider<List<Bible>> {
  BiblesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biblesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biblesHash();

  @$internal
  @override
  $ProviderElement<List<Bible>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Bible> create(Ref ref) {
    return bibles(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Bible> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Bible>>(value),
    );
  }
}

String _$biblesHash() => r'd9b5f3b04a77a7a337c9394fc946d2fba0e2f388';

@ProviderFor(studyBible)
final studyBibleProvider = StudyBibleProvider._();

final class StudyBibleProvider extends $FunctionalProvider<Bible, Bible, Bible>
    with $Provider<Bible> {
  StudyBibleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'studyBibleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studyBibleHash();

  @$internal
  @override
  $ProviderElement<Bible> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Bible create(Ref ref) {
    return studyBible(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Bible value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Bible>(value),
    );
  }
}

String _$studyBibleHash() => r'b09836042fdbea9586ce083dd8d247ae59e871cb';

@ProviderFor(bible)
final bibleProvider = BibleProvider._();

final class BibleProvider extends $FunctionalProvider<Bible, Bible, Bible>
    with $Provider<Bible> {
  BibleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bibleProvider',
        isAutoDispose: true,
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

String _$bibleHash() => r'22cc573b54b33b94108f8c723bbe3454d36ff0af';
