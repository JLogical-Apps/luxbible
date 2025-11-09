import 'dart:convert';

import 'package:bible/models/user_profile.dart';
import 'package:bible/utils/guard.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_service.g.dart';

class SharedPreferencesService {
  final SharedPreferences sharedPreferences;

  const SharedPreferencesService(this.sharedPreferences);

  UserProfile? getUserProfile() {
    final userProfileRaw = sharedPreferences.getString('userProfile');
    final userProfileJson = userProfileRaw == null
        ? null
        : guard(() => jsonDecode(userProfileRaw));
    return userProfileJson == null ? null : UserProfile.fromJson(userProfileJson);
  }

  Future<void> setUserProfile(UserProfile userProfile) async =>
      await sharedPreferences.setString('userProfile', jsonEncode(userProfile.toJson()));
}

@riverpod
SharedPreferencesService sharedPreferenceService(Ref ref) => throw UnimplementedError();
