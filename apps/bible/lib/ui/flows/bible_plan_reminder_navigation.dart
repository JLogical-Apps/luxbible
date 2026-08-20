import 'package:bible/main.dart';
import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/local_notification_service.dart';
import 'package:bible/ui/pages/bible_page.dart';
import 'package:bible/ui/pages/bible_plan_read_page.dart';
import 'package:bible/ui/pages/bible_plans_page.dart';
import 'package:collection/collection.dart';
import 'package:lux/lux.dart';

class BiblePlanReminderNavigation {
  void handlePayload(String? payload) {
    final planType = BiblePlanType.values.firstWhereOrNull(
      (type) => payload == '${LocalNotificationService.payloadPrefix}${type.name}',
    );
    if (planType == null) return;

    final context = navigatorKey.currentContext;
    if (context == null) return;

    final user = ref.read(userProvider);
    final plans = ref.read(biblePlansProvider);
    final planProgress = user.getHydratedPlanProgress(planType: planType, planByType: plans);
    if (planProgress == null) {
      context.goToStack([BiblePage(), BiblePlansPage()]);
      return;
    }

    if (planProgress.currentDay.isReviewAndReflect) {
      context.goToStack([BiblePage(), BiblePlansPage()]);
      return;
    }

    final dayProgress = planProgress.progress.days[planProgress.currentDayIndex];

    final page = BiblePlanReadPage(
      planType: planType,
      dayIndex: planProgress.currentDayIndex,
      initialPassageIndex:
          planProgress.currentDay.passages.indexWhereOrNull((passage) => !dayProgress.isPassageComplete(passage)) ?? 0,
    );
    context.goToStack(page.pageStack);
  }
}
