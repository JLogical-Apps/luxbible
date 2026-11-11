import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/utils/extensions/ref_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lux/i18n.dart';
import 'package:lux/lux.dart';
import 'package:style/style.dart';

class BiblePlanReflectionFlow {
  // Completing a reflection without an answer skips it, and the run's first skip offers to skip the rest.
  static Future<void> complete({required BuildContext context, required String planId, required int dayIndex}) async {
    final plan = ref.read(biblePlansProvider)[planId];
    if (plan == null) return;

    final user = ref.updateUser(
      (user) => user.withPlanItemCompleted(
        planId: planId,
        dayIndex: dayIndex,
        day: plan.days[dayIndex],
        item: BiblePlanDayStep.reflection,
      ),
    );
    final progress = user.planProgressById[planId];
    if (progress == null || progress.getReflectionAnswer(dayIndex) != null || progress.hasOfferedToSkipReflections) {
      return;
    }

    ref.updateUser((user) => user.withPlanReflectionSkipOffered(planId));
    final shouldSkipAll = await context.showStyledDialog(
      (context) => StyledDialog.confirmOrCancel(
        title: t.biblePlans.skipAllReflectionsQuestion.toText(),
        body: t.biblePlans.skipAllReflectionsConfirmation.toText(),
        confirmLabel: t.biblePlans.skipAll.toText(),
        cancelLabel: t.biblePlans.justThisOne.toText(),
      ),
    );
    if (shouldSkipAll == true) {
      ref.updateUser((user) => user.withPlanReflectionsSkipped(planId: planId, plan: plan, isSkipped: true));
    }
  }
}
