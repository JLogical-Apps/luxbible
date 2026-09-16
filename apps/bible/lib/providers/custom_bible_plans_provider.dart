import 'dart:convert';
import 'dart:io';

import 'package:bible/models/bible_plan.dart';
import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:utils_core/utils_core.dart';
import 'package:uuid/uuid.dart';

part 'custom_bible_plans_provider.g.dart';

@Riverpod(keepAlive: true)
class CustomBiblePlans extends _$CustomBiblePlans {
  Directory get directory => ref.read(pathServiceProvider)!.applicationSupport / 'bible_plans';
  File getFile(String id) => directory - '$id.json';

  @override
  Map<String, BiblePlan> build() => !directory.existsSync()
      ? {}
      : directory.listSync().whereType<File>().mapToMap((file) {
          final filename = file.uri.pathSegments.last;
          final id = filename.endsWith('.json') ? filename.substring(0, filename.length - 5) : '';
          return MapEntry(id, guard(() => BiblePlan.tryFromJson(jsonDecode(file.readAsStringSync()))));
        }).withoutNulls;

  String create(BiblePlan plan) {
    if (!plan.isValid) throw ArgumentError.value(plan, 'plan', 'Invalid Bible plan');
    final id = Uuid().v4();
    directory.createSync(recursive: true);
    getFile(id).writeAsStringSync(jsonEncode(plan.toJson()));
    state = {...state, id: plan};
    return id;
  }

  void delete(String id) {
    final file = getFile(id);
    if (file.existsSync()) file.deleteSync();
    state = {...state}..remove(id);
  }
}
