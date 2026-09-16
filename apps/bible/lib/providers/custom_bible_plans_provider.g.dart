// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_bible_plans_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CustomBiblePlans)
final customBiblePlansProvider = CustomBiblePlansProvider._();

final class CustomBiblePlansProvider
    extends $NotifierProvider<CustomBiblePlans, Map<String, BiblePlan>> {
  CustomBiblePlansProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customBiblePlansProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customBiblePlansHash();

  @$internal
  @override
  CustomBiblePlans create() => CustomBiblePlans();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, BiblePlan> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, BiblePlan>>(value),
    );
  }
}

String _$customBiblePlansHash() => r'353e00b1de5279c622e87f825436afda38158128';

abstract class _$CustomBiblePlans extends $Notifier<Map<String, BiblePlan>> {
  Map<String, BiblePlan> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<Map<String, BiblePlan>, Map<String, BiblePlan>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, BiblePlan>, Map<String, BiblePlan>>,
              Map<String, BiblePlan>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
