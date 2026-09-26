// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewed_bible_plan_day_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ViewedBiblePlanDay)
final viewedBiblePlanDayProvider = ViewedBiblePlanDayProvider._();

final class ViewedBiblePlanDayProvider
    extends $NotifierProvider<ViewedBiblePlanDay, BiblePlanDayId?> {
  ViewedBiblePlanDayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'viewedBiblePlanDayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$viewedBiblePlanDayHash();

  @$internal
  @override
  ViewedBiblePlanDay create() => ViewedBiblePlanDay();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BiblePlanDayId? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BiblePlanDayId?>(value),
    );
  }
}

String _$viewedBiblePlanDayHash() =>
    r'7dddf58ddcb246b69776397af95081a4d86d858f';

abstract class _$ViewedBiblePlanDay extends $Notifier<BiblePlanDayId?> {
  BiblePlanDayId? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<BiblePlanDayId?, BiblePlanDayId?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BiblePlanDayId?, BiblePlanDayId?>,
              BiblePlanDayId?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
