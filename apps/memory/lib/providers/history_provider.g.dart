// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HistoryNotifier)
final historyProvider = HistoryNotifierProvider._();

final class HistoryNotifierProvider
    extends $NotifierProvider<HistoryNotifier, List<Activity>> {
  HistoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyNotifierHash();

  @$internal
  @override
  HistoryNotifier create() => HistoryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Activity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Activity>>(value),
    );
  }
}

String _$historyNotifierHash() => r'caa4ce5254e80699bdd536f87aa789480e4bad98';

abstract class _$HistoryNotifier extends $Notifier<List<Activity>> {
  List<Activity> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<Activity>, List<Activity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Activity>, List<Activity>>,
              List<Activity>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
