// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_plans_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(includedBiblePlans)
final includedBiblePlansProvider = IncludedBiblePlansProvider._();

final class IncludedBiblePlansProvider
    extends
        $FunctionalProvider<
          Map<String, BiblePlan>,
          Map<String, BiblePlan>,
          Map<String, BiblePlan>
        >
    with $Provider<Map<String, BiblePlan>> {
  IncludedBiblePlansProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'includedBiblePlansProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$includedBiblePlansHash();

  @$internal
  @override
  $ProviderElement<Map<String, BiblePlan>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<String, BiblePlan> create(Ref ref) {
    return includedBiblePlans(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, BiblePlan> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, BiblePlan>>(value),
    );
  }
}

String _$includedBiblePlansHash() =>
    r'57462eb164c814ba6f1dafe6fd10a29c16d56bbe';

@ProviderFor(biblePlans)
final biblePlansProvider = BiblePlansProvider._();

final class BiblePlansProvider
    extends
        $FunctionalProvider<
          Map<String, BiblePlan>,
          Map<String, BiblePlan>,
          Map<String, BiblePlan>
        >
    with $Provider<Map<String, BiblePlan>> {
  BiblePlansProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biblePlansProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biblePlansHash();

  @$internal
  @override
  $ProviderElement<Map<String, BiblePlan>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<String, BiblePlan> create(Ref ref) {
    return biblePlans(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, BiblePlan> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, BiblePlan>>(value),
    );
  }
}

String _$biblePlansHash() => r'f1713b15f52d4d18577bf3710b39696234d1cf65';
