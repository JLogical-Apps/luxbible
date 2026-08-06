import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lux/lux.dart';
import 'package:memory/models/activity.dart';
import 'package:memory/providers/root_ref.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:utils_core/utils_core.dart';

part 'history_provider.g.dart';

@Riverpod(keepAlive: true)
class HistoryNotifier extends _$HistoryNotifier {
  @override
  List<Activity> build() {
    if (historyFile.existsSync()) {
      final history = guard(
        () => (jsonDecode(historyFile.readAsStringSync()) as List)
            .cast<Map<String, dynamic>>()
            .map((json) => Activity.fromJson(json))
            .toList(),
        onException: (error, stackTrace) {
          debugPrint(error.toString());
          debugPrintStack(stackTrace: stackTrace);
        },
      );
      if (history != null) {
        return history;
      }
    }

    return [];
  }

  @override
  bool updateShouldNotify(_, _) => true;

  Future<void> update(List<Activity> Function(List<Activity>) updater) async {
    state = updater(state);
    historyFile.writeAsStringSync(jsonEncode(state.map((activity) => activity.toJson()).toList()));
  }

  File get historyFile => ref.read(pathServiceProvider)!.applicationSupport - 'history.json';
}
