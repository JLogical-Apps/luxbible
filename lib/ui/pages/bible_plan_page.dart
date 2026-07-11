import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/utils/extensions/build_context_extensions.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BiblePlanPage extends ConsumerWidget {
  final BiblePlanType planType;

  const BiblePlanPage({super.key, required this.planType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(biblePlansProvider);
    final plan = plans[planType]!;

    return StyledPage(
      title: plan.name.toText(),
      body: StyledDock(
        shrinkWrap: false,
        children: StyledSection(
          padding: .only(top: 24),
          title: 'Days'.toText(),
          children: plan.days
              .mapIndexed<Widget>(
                (dayIndex, day) => StyledListItem(
                  title: 'Day ${dayIndex + 1}'.toText(),
                  subtitle: Text(day.passages.map((passage) => passage.format()).join(' • ')),
                ),
              )
              .toList(),
        ).buildChildren(context),
        buttonsBuilder: (context) => [
          StyledRectButton.primary(
            label: 'Start Plan'.toText(),
            onPressed: () {
              ref.updateUser((user) => user.withStartedPlan(planType: planType, plan: plan));
              context.pop(planType);
            },
          ),
        ],
      ),
    );
  }
}
