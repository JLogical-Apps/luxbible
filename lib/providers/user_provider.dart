import 'dart:convert';
import 'dart:io';

import 'package:bible/models/user/user.dart';
import 'package:bible/services/path_service.dart';
import 'package:bible/services/shared_preferences_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utils_core/utils_core.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  SharedPreferences get sharedPreferences => ref.watch(sharedPreferencesServiceProvider);

  @override
  User build() {
    final userFile = this.userFile;
    if (userFile != null) {
      if (userFile.existsSync()) {
        final user = guard(() => User.fromJson(jsonDecode(userFile.readAsStringSync())));
        if (user != null) {
          return user;
        }
      }
    } else {
      final user = guard(
        () => sharedPreferences.getString('user')?.mapIfNonNull((rawUser) => User.fromJson(jsonDecode(rawUser))),
      );
      if (user != null) {
        return user;
      }
    }

    return User();
  }

  Future<void> update(User Function(User) updater) async {
    state = updater(state);

    final userFile = this.userFile;
    if (userFile != null) {
      userFile.writeAsStringSync(jsonEncode(state.toJson()));
    } else {
      sharedPreferences.setString('user', jsonEncode(state.toJson()));
    }
  }

  File? get userFile => ref.read(pathServiceProvider)?.applicationSupport.mapIfNonNull((dir) => dir - 'user.json');
}
