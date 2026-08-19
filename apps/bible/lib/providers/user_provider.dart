import 'dart:convert';
import 'dart:io';

import 'package:bible/models/user/language.dart';
import 'package:bible/models/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utils_core/utils_core.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  SharedPreferences get sharedPreferences => ref.watch(sharedPreferencesServiceProvider);

  @override
  User build() => userOrDefault;

  @override
  bool updateShouldNotify(_, _) => true;

  User? get userOrNull {
    if (userFile.existsSync()) {
      final user = guard(
        () => User.fromJson(jsonDecode(userFile.readAsStringSync())),
        onException: (error, stackTrace) {
          debugPrint(error.toString());
          debugPrintStack(stackTrace: stackTrace);
        },
      );
      if (user != null) {
        return user;
      }
    }

    return null;
  }

  User get userOrDefault =>
      userOrNull ?? User(translation: getDefaultBibleTranslations(Language.device).first, completedOnboardingSteps: []);

  User update(User Function(User) updater) {
    state = updater(state);
    userFile.writeAsStringSync(jsonEncode(state.toJson()));
    return state;
  }

  File get userFile => ref.read(pathServiceProvider)!.applicationSupport - 'user.json';
}
