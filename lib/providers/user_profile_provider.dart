import 'package:bible/models/user_profile.dart';
import 'package:bible/services/shared_preferences_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_profile_provider.g.dart';

@Riverpod(keepAlive: true)
class UserProfileNotifier extends _$UserProfileNotifier {
  @override
  UserProfile build() {
    return ref.watch(sharedPreferenceServiceProvider).getUserProfile() ?? UserProfile();
  }

  Future<void> update(UserProfile Function(UserProfile) updater) async {
    state = updater(state);
    await ref.read(sharedPreferenceServiceProvider).setUserProfile(state);
  }
}
