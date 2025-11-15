import 'dart:convert';

import 'package:bible/models/user.dart';
import 'package:bible/utils/guard.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_service.g.dart';

class SharedPreferencesService {
  final SharedPreferences sharedPreferences;

  const SharedPreferencesService(this.sharedPreferences);

  User? getUser() {
    final userRaw = sharedPreferences.getString('user');
    final userJson = userRaw == null ? null : guard(() => jsonDecode(userRaw));
    return userJson == null ? null : User.fromJson(userJson);
  }

  Future<void> setUser(User user) async => await sharedPreferences.setString('user', jsonEncode(user.toJson()));
}

@riverpod
SharedPreferencesService sharedPreferenceService(Ref ref) => throw UnimplementedError();
