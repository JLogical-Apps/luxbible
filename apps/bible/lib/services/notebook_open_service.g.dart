// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notebook_open_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notebookOpenService)
final notebookOpenServiceProvider = NotebookOpenServiceProvider._();

final class NotebookOpenServiceProvider
    extends
        $FunctionalProvider<
          NotebookOpenService,
          NotebookOpenService,
          NotebookOpenService
        >
    with $Provider<NotebookOpenService> {
  NotebookOpenServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notebookOpenServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notebookOpenServiceHash();

  @$internal
  @override
  $ProviderElement<NotebookOpenService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotebookOpenService create(Ref ref) {
    return notebookOpenService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotebookOpenService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotebookOpenService>(value),
    );
  }
}

String _$notebookOpenServiceHash() =>
    r'bc4c997c6a5e6917e4b8f855e0770d8f74b0cc53';
