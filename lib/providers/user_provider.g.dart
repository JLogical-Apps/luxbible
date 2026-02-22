// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserNotifier)
const userProvider = UserNotifierProvider._();

final class UserNotifierProvider extends $NotifierProvider<UserNotifier, User> {
  const UserNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userNotifierHash();

  @$internal
  @override
  UserNotifier create() => UserNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(User value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<User>(value),
    );
  }
}

String _$userNotifierHash() => r'38fa1699027d79e323d0a892cf7e2ba2533112c1';

abstract class _$UserNotifier extends $Notifier<User> {
  User build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<User, User>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<User, User>,
              User,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
