import 'package:bible/main.dart';
import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/bible_plans_provider.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/analytics_service.dart';
import 'package:bible/services/local_notification_service.dart';
import 'package:bible/ui/pages/bible_page.dart';
import 'package:bible/ui/pages/bible_plan_read_page.dart';
import 'package:bible/ui/pages/bible_plans_page.dart';
import 'package:collection/collection.dart';
import 'package:lux/lux.dart';
import 'package:utils_core/utils_core.dart';

class BiblePlanNotification {
  static bool handlePayload(String payload) {
    final planId = BiblePlanNotification.getPlanIdForPayload(payload);
    if (planId == null) return false;

    final context = navigatorKey.currentContext;
    if (context == null) return false;

    AnalyticsEvent.notificationTapped.log();
    final user = ref.read(userProvider);
    final plans = ref.read(biblePlansProvider);
    final planProgress = user.getHydratedPlanProgress(planId: planId, planById: plans);
    if (planProgress == null || planProgress.isCompleted) {
      context.goToStack([BiblePage(), BiblePlansPage()]);
      return true;
    }

    if (planProgress.currentDay.isReviewAndReflect) {
      context.goToStack([BiblePage(), BiblePlansPage()]);
      return true;
    }

    final dayProgress =
        planProgress.progress.days.elementAtOrNull(planProgress.currentDayIndex) ?? BiblePlanDayProgress.incomplete();

    final page = BiblePlanReadPage(
      planId: planId,
      dayIndex: planProgress.currentDayIndex,
      initialPassageIndex:
          planProgress.currentDay.passages.indexWhereOrNull((passage) => !dayProgress.isPassageComplete(passage)) ?? 0,
    );
    context.goToStack(page.pageStack);
    return true;
  }

  static String getNotificationPrefixFor(String planId) =>
      '${LocalNotificationService.payloadPrefix}bible-plan:$planId';

  static int getNotificationIdFor(String planId, DateTime date) {
    if (BiblePlanType.getById(planId) case final type?) {
      return 300000000 + type.index * 100000000 + date.year * 10000 + date.month * 100 + date.day;
    }
    final key = '$planId:${date.year}-${date.month}-${date.day}';
    return 1700000000 + key.codeUnits.fold(0, (hash, unit) => (hash * 31 + unit) % 400000000);
  }

  static String? getPlanIdForPayload(String payload) {
    final prefix = '${LocalNotificationService.payloadPrefix}bible-plan:';
    if (!payload.startsWith(prefix)) return null;
    return payload.substring(prefix.length).nullIfBlank;
  }
}
