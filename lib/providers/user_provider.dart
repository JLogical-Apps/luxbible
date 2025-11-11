import 'package:bible/models/user.dart';
import 'package:bible/services/shared_preferences_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  @override
  User build() => ref.watch(sharedPreferenceServiceProvider).getUser() ?? User();

  Future<void> update(User Function(User) updater) async {
    state = updater(state);
    await ref.read(sharedPreferenceServiceProvider).setUser(state);
  }
}
