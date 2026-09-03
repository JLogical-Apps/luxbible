import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bible/models/user/language.dart';
import 'package:bible/models/user/migration.dart';
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
        if (user.latestMigration != Migration.values.last) {
          final latestMigration = user.latestMigration;
          final newUser = Migration.values
              .skip(latestMigration == null ? 0 : (latestMigration.index + 1))
              .fold(user, (user, migration) => migration.migrate(user));
          Future.microtask(() async {
            update((_) => newUser.copyWith(latestMigration: Migration.values.last));
          });
          return newUser;
        }

        return user;
      }
    }

    return null;
  }

  User get userOrDefault =>
      userOrNull ??
      User(
        translation: getDefaultBibleTranslations(Language.device).first,
        completedOnboardingSteps: [],
        recentBibles: [getDefaultBibleTranslations(Language.device).first],
        latestMigration: Migration.values.last,
      );

  User update(User Function(User) updater) {
    state = updater(state);
    userFile.writeAsStringSync(jsonEncode(state.toJson()));
    return state;
  }

  File get userFile => ref.read(pathServiceProvider)!.applicationSupport - 'user.json';
}
