import 'package:bible/models/bible_plan.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bible_plans_provider.g.dart';

@Riverpod(keepAlive: true)
Map<BiblePlanType, BiblePlan> biblePlans(Ref ref) => throw UnimplementedError();
