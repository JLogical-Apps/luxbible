import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/custom_bible_plans_provider.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/ui/widgets/bible_plan_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class BiblePlanTile extends ConsumerWidget {
  final String planId;
  final BiblePlan plan;

  final Widget? trailing;
  final Function()? onPressed;

  final bool showTags;

  const BiblePlanTile({
    super.key,
    required this.planId,
    required this.plan,
    this.trailing,
    this.onPressed,
    this.showTags = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final isCustom = ref.watch(customBiblePlansProvider).containsKey(planId);

    final hasStarted = user.hasStartedPlan(planId);

    return StyledListItem(
      leading: BiblePlanThumbnail.fromPlan(plan: plan, id: planId, isEnabled: !hasStarted),
      title: SingleChildScrollView(
        scrollDirection: .horizontal,
        child: Row(
          spacing: 8,
          children: [
            plan.getDisplayName(planId).toText(),
            if (hasStarted)
              StyledTag.sm(leading: Symbols.check.toIcon(), child: t.labels.following.toText(), isEnabled: false),
            if (user.completedPlans.has(planId))
              StyledTag.sm(
                leading: Symbols.history.toIcon(),
                child: t.labels.completed.toText(),
                isEnabled: !hasStarted,
              ),
          ],
        ),
      ),
      subtitle: BiblePlanType.getById(planId)?.description().toText(),
      thirdLine: isCustom && showTags
          ? Padding(
              padding: .only(top: 4),
              child: StyledTag.sm(child: t.common.custom.toText(), isEnabled: !hasStarted),
            )
          : null,
      trailing: trailing,
      isEnabled: !hasStarted,
      onPressed: hasStarted ? null : onPressed,
    );
  }
}
