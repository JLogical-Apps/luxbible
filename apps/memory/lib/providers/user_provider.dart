import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:memory/models/user.dart';
import 'package:memory/providers/root_ref.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:utils_core/utils_core.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
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

  User get userOrDefault => userOrNull ?? User();

  Future<void> update(User Function(User) updater) async {
    state = updater(state);
    userFile.writeAsStringSync(jsonEncode(state.toJson()));
  }

  File get userFile => ref.read(pathServiceProvider)!.applicationSupport - 'user.json';
}
