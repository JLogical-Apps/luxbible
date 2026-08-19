import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/lux.dart';
import 'package:memory/models/activity_plan.dart';
import 'package:memory/ui/widgets/activities/phrase_read_builder.dart';
import 'package:memory/ui/widgets/activities/phrase_selection_builder.dart';
import 'package:style/style.dart';

class ActivityPage extends HookConsumerWidget {
  final ActivityPlan plan;

  const ActivityPage({super.key, required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StyledPage(
      title: plan.passage.format().toText(),
      body: switch (plan) {
        PhraseReadActivityPlan plan => PhraseReadBuilder(plan: plan),
        PhraseSelectionActivityPlan plan => PhraseSelectionBuilder(plan: plan),
        _ => SizedBox.shrink(),
      },
    );
  }
}
