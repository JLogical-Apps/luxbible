// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_plan_open_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(biblePlanOpenService)
final biblePlanOpenServiceProvider = BiblePlanOpenServiceProvider._();

final class BiblePlanOpenServiceProvider
    extends
        $FunctionalProvider<
          BiblePlanOpenService,
          BiblePlanOpenService,
          BiblePlanOpenService
        >
    with $Provider<BiblePlanOpenService> {
  BiblePlanOpenServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biblePlanOpenServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biblePlanOpenServiceHash();

  @$internal
  @override
  $ProviderElement<BiblePlanOpenService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BiblePlanOpenService create(Ref ref) {
    return biblePlanOpenService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BiblePlanOpenService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BiblePlanOpenService>(value),
    );
  }
}

String _$biblePlanOpenServiceHash() =>
    r'cc96f196a57187838e13b64a9f9cf62a7b2fae5d';
