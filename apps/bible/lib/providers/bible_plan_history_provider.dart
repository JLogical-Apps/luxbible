import 'dart:convert';
import 'dart:io';

import 'package:bible/models/bible_plan.dart';
import 'package:bible/models/hydrated_bible_plan_progress.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:lux/lux.dart';
import 'package:path/path.dart' as path;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:utils_core/utils_core.dart';

part 'bible_plan_history_provider.g.dart';

@Riverpod(keepAlive: true)
class BiblePlanHistory extends _$BiblePlanHistory {
  Directory get directory => ref.read(pathServiceProvider)!.applicationSupport / 'bible_plan_history';
  File getFile(String instanceId) => directory - '$instanceId.json';

  @override
  Map<String, BiblePlanHistoryEntry> build() => !directory.existsSync()
      ? {}
      : directory
            .listSync()
            .whereType<File>()
            .where((file) => path.extension(file.path) == '.json')
            .mapToMap(
              (file) => MapEntry(
                path.basenameWithoutExtension(file.path),
                guard(() => BiblePlanHistoryEntry.fromJson(jsonDecode(file.readAsStringSync()))),
              ),
            )
            .withoutNulls;

  void moveToHistory(String planId) {
    storeHistory(planId);
    ref.read(userProvider.notifier).update((user) => user.withStoppedPlan(planId));
  }

  void resume(String instanceId) {
    final entry = state[instanceId];
    if (entry == null) return;

    storeHistory(entry.planId);
    delete(instanceId);
    ref
        .read(userProvider.notifier)
        .update((user) => user.withResumedPlan(planId: entry.planId, progress: entry.progress));
  }

  void storeHistory(String planId) {
    final progress = getActiveProgress(planId);
    if (progress == null) return;

    final entry = BiblePlanHistoryEntry(planId: planId, progress: progress.progress, endedAt: .now());
    directory.createSync(recursive: true);
    getFile(progress.instanceId).writeAsStringSync(jsonEncode(entry.toJson()));
    state = {...state, progress.instanceId: entry};
  }

  void delete(String instanceId) {
    final file = getFile(instanceId);
    if (file.existsSync()) file.deleteSync();
    state = {...state}..remove(instanceId);
  }

  void deleteAllForPlan(String planId) => state.getEntriesForPlan(planId).keys.forEach(delete);

  HydratedBiblePlanProgress? getActiveProgress(String planId) =>
      ref.read(userProvider).getHydratedPlanProgress(planId: planId, planById: ref.read(biblePlansProvider));
}

extension BiblePlanHistoryExtension on Map<String, BiblePlanHistoryEntry> {
  Map<String, BiblePlanHistoryEntry> getEntriesForPlan(String planId) => where((_, entry) => entry.planId == planId);

  bool hasEntriesForPlan(String planId) => values.any((entry) => entry.planId == planId);

  bool hasCompletedPlan(String planId, BiblePlan plan) =>
      getEntriesForPlan(planId).values.any((entry) => entry.hydrate(plan).isCompleted);
}
