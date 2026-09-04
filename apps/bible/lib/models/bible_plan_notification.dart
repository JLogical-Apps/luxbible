import 'package:bible/main.dart';
import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/local_notification_service.dart';
import 'package:bible/services/analytics_service.dart';
import 'package:bible/ui/pages/bible_page.dart';
import 'package:bible/ui/pages/bible_plan_read_page.dart';
import 'package:bible/ui/pages/bible_plans_page.dart';
import 'package:collection/collection.dart';
import 'package:lux/lux.dart';

class BiblePlanNotification {
  static bool handlePayload(String payload) {
    final planType = BiblePlanNotification.getPlanTypeForPayload(payload);
    if (planType == null) return false;

    final context = navigatorKey.currentContext;
    if (context == null) return false;

    AnalyticsEvent.notificationTapped.log();
    final user = ref.read(userProvider);
    final plans = ref.read(biblePlansProvider);
    final planProgress = user.getHydratedPlanProgress(planType: planType, planByType: plans);
    if (planProgress == null) {
      context.goToStack([BiblePage(), BiblePlansPage()]);
      return true;
    }

    if (planProgress.currentDay.isReviewAndReflect) {
      context.goToStack([BiblePage(), BiblePlansPage()]);
      return true;
    }

    final dayProgress = planProgress.progress.days[planProgress.currentDayIndex];

    final page = BiblePlanReadPage(
      planType: planType,
      dayIndex: planProgress.currentDayIndex,
      initialPassageIndex:
          planProgress.currentDay.passages.indexWhereOrNull((passage) => !dayProgress.isPassageComplete(passage)) ?? 0,
    );
    context.goToStack(page.pageStack);
    return true;
  }

  static String getNotificationPrefixFor(BiblePlanType planType) =>
      '${LocalNotificationService.payloadPrefix}bible-plan:${planType.name}';

  static int getNotificationIdFor(BiblePlanType planType, DateTime date) =>
      300000000 + planType.index * 100000000 + date.year * 10000 + date.month * 100 + date.day;

  static BiblePlanType? getPlanTypeForPayload(String payload) =>
      BiblePlanType.values.firstWhereOrNull((planType) => payload == getNotificationPrefixFor(planType));
}
