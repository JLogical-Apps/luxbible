import 'package:bible/main.dart';
import 'package:bible/models/bible_plan.dart';
import 'package:bible/providers/root_ref.dart';
import 'package:bible/providers/user_provider.dart';
import 'package:bible/services/analytics_service.dart';
import 'package:bible/services/bible_navigation_service.dart';
import 'package:bible/services/launch_link_channel.dart';
import 'package:bible/ui/pages/bible_plan_search_page.dart';
import 'package:bible/ui/pages/bible_plans_page.dart';
import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_link_service.g.dart';

class AppLinkService {
  static final channel = LaunchLinkChannel(
    'app.luxbible.app/app-link',
    launchMethod: 'getLaunchLink',
    openMethod: 'openLink',
  );

  final BibleNavigationService navigation;

  AppLinkService({required this.navigation});

  void initialize() => channel.listen(open);

  Future<void> openLaunchLink() async {
    if (await channel.getLaunchValue() case final link?) open(link);
  }

  void open(String link) {
    if (Uri.tryParse(link) case final uri? when uri.scheme == 'https' && uri.host == 'app.luxbible.app') {
      switch (uri.pathSegments) {
        case ['passage', final osisId] when VerseSelection.isOsisId(osisId):
          AnalyticsEvent.sharedPassageOpened.log();
          navigation.navigateTo(VerseSelection.fromOsisId(osisId));
        case ['plans', final planId] when BiblePlanType.getById(planId) != null:
          AnalyticsEvent.planLinkOpened.log();
          openPlan(planId);
      }
    }
  }

  // A plan that's already being followed is on Bible Plans, so only a new one opens its details to start it.
  void openPlan(String planId) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    context.goToRoot(
      pages: [
        BiblePlansPage(),
        if (!ref.read(userProvider).hasStartedPlan(planId)) BiblePlanSearchPage(initialPlanId: planId),
      ],
    );
  }
}

@Riverpod(keepAlive: true)
AppLinkService appLinkService(Ref ref) => AppLinkService(navigation: ref.watch(bibleNavigationServiceProvider));
