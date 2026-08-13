// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_plans_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(biblePlans)
final biblePlansProvider = BiblePlansProvider._();

final class BiblePlansProvider
    extends
        $FunctionalProvider<
          Map<BiblePlanType, BiblePlan>,
          Map<BiblePlanType, BiblePlan>,
          Map<BiblePlanType, BiblePlan>
        >
    with $Provider<Map<BiblePlanType, BiblePlan>> {
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
  $ProviderElement<Map<BiblePlanType, BiblePlan>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<BiblePlanType, BiblePlan> create(Ref ref) {
    return biblePlans(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<BiblePlanType, BiblePlan> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<BiblePlanType, BiblePlan>>(
        value,
      ),
    );
  }
}

String _$biblePlansHash() => r'833ea3eadb392879a1ee230960428859a40de261';
