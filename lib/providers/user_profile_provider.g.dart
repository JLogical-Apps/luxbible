// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserProfileNotifier)
const userProfileProvider = UserProfileNotifierProvider._();

final class UserProfileNotifierProvider
    extends $NotifierProvider<UserProfileNotifier, UserProfile> {
  const UserProfileNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userProfileProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userProfileNotifierHash();

  @$internal
  @override
  UserProfileNotifier create() => UserProfileNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserProfile value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserProfile>(value),
    );
  }
}

String _$userProfileNotifierHash() =>
    r'939ca50b0e6e7f9eb087235c3a2aac1777a7bc23';

abstract class _$UserProfileNotifier extends $Notifier<UserProfile> {
  UserProfile build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<UserProfile, UserProfile>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserProfile, UserProfile>,
              UserProfile,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
