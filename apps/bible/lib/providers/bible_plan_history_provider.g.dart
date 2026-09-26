// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_plan_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BiblePlanHistory)
final biblePlanHistoryProvider = BiblePlanHistoryProvider._();

final class BiblePlanHistoryProvider
    extends
        $NotifierProvider<
          BiblePlanHistory,
          Map<String, BiblePlanHistoryEntry>
        > {
  BiblePlanHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biblePlanHistoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biblePlanHistoryHash();

  @$internal
  @override
  BiblePlanHistory create() => BiblePlanHistory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, BiblePlanHistoryEntry> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, BiblePlanHistoryEntry>>(
        value,
      ),
    );
  }
}

String _$biblePlanHistoryHash() => r'5c32431b61ea9e9ac66e8aab0e73e3bc14b6c600';

abstract class _$BiblePlanHistory
    extends $Notifier<Map<String, BiblePlanHistoryEntry>> {
  Map<String, BiblePlanHistoryEntry> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              Map<String, BiblePlanHistoryEntry>,
              Map<String, BiblePlanHistoryEntry>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<String, BiblePlanHistoryEntry>,
                Map<String, BiblePlanHistoryEntry>
              >,
              Map<String, BiblePlanHistoryEntry>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
