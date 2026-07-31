import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/style/style.dart';
import 'package:bible/ui/widgets/bible_plan_thumbnail.dart';
import 'package:bible/utils/extensions/flutter_string_extensions.dart';
import 'package:bible/utils/extensions/icon_data_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class BiblePlanTile extends ConsumerWidget {
  final BiblePlanType planType;
  final BiblePlan plan;

  final Widget? trailing;
  final Function()? onPressed;
  final bool showTags;

  const BiblePlanTile({
    super.key,
    required this.planType,
    required this.plan,
    this.trailing,
    this.onPressed,
    this.showTags = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    final hasStarted = user.hasStartedPlan(planType);

    return StyledListItem(
      leading: BiblePlanThumbnail(plan: plan, planType: planType, isEnabled: !hasStarted),
      title: SingleChildScrollView(
        scrollDirection: .horizontal,
        child: Row(
          spacing: 8,
          children: [
            planType.title().toText(),
            if (hasStarted)
              StyledTag.sm(leading: Symbols.check.toIcon(), child: t.labels.following.toText(), isEnabled: false),
            if (user.completedPlans.contains(planType))
              StyledTag.sm(
                leading: Symbols.history.toIcon(),
                child: t.labels.completed.toText(),
                isEnabled: !hasStarted,
              ),
          ],
        ),
      ),
      subtitle: planType.description().toText(),
      trailing: trailing,
      thirdLine: showTags
          ? Padding(
              padding: .only(top: 4),
              child: Row(
                spacing: 4,
                children: [
                  StyledTag.sm(isEnabled: !hasStarted, child: planType.scope.title().toText()),
                  StyledTag.sm(isEnabled: !hasStarted, child: planType.searchType.title().toText()),
                ],
              ),
            )
          : null,
      isEnabled: !hasStarted,
      onPressed: hasStarted ? null : onPressed,
    );
  }
}
