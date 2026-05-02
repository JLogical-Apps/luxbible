// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bibles_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(displayBibles)
final displayBiblesProvider = DisplayBiblesProvider._();

final class DisplayBiblesProvider
    extends
        $FunctionalProvider<
          List<DisplayBible>,
          List<DisplayBible>,
          List<DisplayBible>
        >
    with $Provider<List<DisplayBible>> {
  DisplayBiblesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'displayBiblesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$displayBiblesHash();

  @$internal
  @override
  $ProviderElement<List<DisplayBible>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<DisplayBible> create(Ref ref) {
    return displayBibles(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<DisplayBible> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<DisplayBible>>(value),
    );
  }
}

String _$displayBiblesHash() => r'f92be3c8c657e9395a8380a322bf7578aec0d487';

@ProviderFor(studyBibles)
final studyBiblesProvider = StudyBiblesProvider._();

final class StudyBiblesProvider
    extends
        $FunctionalProvider<
          List<StudyBible>,
          List<StudyBible>,
          List<StudyBible>
        >
    with $Provider<List<StudyBible>> {
  StudyBiblesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'studyBiblesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studyBiblesHash();

  @$internal
  @override
  $ProviderElement<List<StudyBible>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<StudyBible> create(Ref ref) {
    return studyBibles(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<StudyBible> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<StudyBible>>(value),
    );
  }
}

String _$studyBiblesHash() => r'92d360e38108eb9b0de77044053e9c6c8d2eef6f';
