import 'dart:convert';

import 'package:bible/models/user/user.dart';
import 'package:bible/services/path_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:utils_core/utils_core.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  @override
  User build() {
    final userFile = ref.watch(pathServiceProvider).applicationSupport - 'user.json';
    if (userFile.existsSync()) {
      final user = guard(() => User.fromJson(jsonDecode(userFile.readAsStringSync())));
      if (user != null) {
        return user;
      }
    }

    return User();
  }

  Future<void> update(User Function(User) updater) async {
    state = updater(state);
    final userFile = ref.read(pathServiceProvider).applicationSupport - 'user.json';
    userFile.writeAsStringSync(jsonEncode(state.toJson()));
  }
}
