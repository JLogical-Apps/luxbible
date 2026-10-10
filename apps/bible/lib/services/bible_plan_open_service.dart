import 'package:bible/main.dart';
import 'package:bible/services/analytics_service.dart';
import 'package:bible/services/bible_plan_file_service.dart';
import 'package:bible/services/launch_link_channel.dart';
import 'package:bible/ui/pages/bible_plans_page.dart';
import 'package:bible/ui/pages/create_bible_plan_page.dart';
import 'package:lux/lux.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bible_plan_open_service.g.dart';

class BiblePlanOpenService {
  static final channel = LaunchLinkChannel(
    'app.luxbible.app/bible-plan-open',
    launchMethod: 'getLaunchPlan',
    openMethod: 'openPlan',
  );

  final createPageImportHandlers = <Function(BiblePlanFileImport)>[];

  void initialize() => channel.listen(openContents);

  Future<void> openLaunchPlan() async {
    if (await channel.getLaunchValue() case final contents?) openContents(contents, isLaunch: true);
  }

  void openContents(String contents, {bool isLaunch = false}) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    AnalyticsEvent.biblePlanFileOpened.log();

    final fileImport = BiblePlanFileImport.decode(contents);
    if (isLaunch) {
      context.goToRoot(
        pages: [
          BiblePlansPage(),
          CreateBiblePlanPage(fileImport: fileImport),
        ],
      );
    } else if (createPageImportHandlers.lastOrNull case final onImport?) {
      onImport(fileImport);
    } else {
      context.push(CreateBiblePlanPage(fileImport: fileImport));
    }
  }
}

@Riverpod(keepAlive: true)
BiblePlanOpenService biblePlanOpenService(Ref ref) => BiblePlanOpenService();
