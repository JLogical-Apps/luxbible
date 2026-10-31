import 'package:bible/models/bible_plan.dart';
import 'package:bible/services/bible_plan_file_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:style/style.dart';

class BiblePlanExportSheet {
  static Future<BiblePlanFile?> show(
    BuildContext context, {
    required String title,
    required String planId,
    required BiblePlan plan,
    BiblePlanProgress? progress,
  }) async {
    final displayName = plan.getDisplayName(planId);
    final namedPlan = plan.copyWith(name: displayName);

    final progressDays = switch (progress?.days) {
      final days? when days.any((day) => day.hasProgress) => days,
      _ => null,
    };
    final planTargetDate = BiblePlanType.getById(planId)?.getUpcomingTargetDate(.now());
    final runTargetDate = switch (progress?.pace.endDate) {
      final endDate? when endDate != planTargetDate => endDate,
      _ => null,
    };
    if (progressDays == null && runTargetDate == null) {
      return BiblePlanFile(plan: namedPlan, targetDate: planTargetDate);
    }

    return context.showStyledSheet(path: '/bible-plans/export', (context, _) {
      final includesProgressState = useState(false);
      final includesTargetDateState = useState(false);

      return StyledSheet(
        title: title.toText(),
        subtitle: displayName.toText(),
        children: [
          if (progressDays != null)
            StyledListItem.switchControl(
              leading: Symbols.task_alt.toIcon(),
              title: t.biblePlans.includeProgress.toText(),
              subtitle: t.biblePlans
                  .includeProgressDescription(completed: progressDays.completedDayCount, total: plan.dayCount)
                  .toText(),
              isSelected: includesProgressState.value,
              onSelected: (isIncluded) => includesProgressState.value = isIncluded,
            ),
          if (runTargetDate != null)
            StyledListItem.switchControl(
              leading: BiblePlanPaceType.paced.icon.toIcon(),
              title: t.biblePlans.includeTargetDate.toText(),
              subtitle: t.biblePlans.includeTargetDateDescription(date: runTargetDate.formatDate()).toText(),
              isSelected: includesTargetDateState.value,
              onSelected: (isIncluded) => includesTargetDateState.value = isIncluded,
            ),
        ],
        buttonsBuilder: (context) => [
          StyledRectButton.primary(
            label: title.toText(),
            onPressed: () => context.pop(
              BiblePlanFile(
                plan: namedPlan,
                progress: includesProgressState.value ? progressDays : null,
                targetDate: includesTargetDateState.value ? runTargetDate : planTargetDate,
              ),
            ),
          ),
          StyledRectButton.transparent(label: t.common.cancel.toText(), onPressed: () => context.pop()),
        ],
      );
    });
  }
}
