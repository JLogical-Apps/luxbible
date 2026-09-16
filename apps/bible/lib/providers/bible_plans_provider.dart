import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/custom_bible_plans_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bible_plans_provider.g.dart';

@Riverpod(keepAlive: true)
Map<String, BiblePlan> includedBiblePlans(Ref ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
Map<String, BiblePlan> biblePlans(Ref ref) => {
  ...ref.watch(includedBiblePlansProvider),
  ...ref.watch(customBiblePlansProvider),
};
